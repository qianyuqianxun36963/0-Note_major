# volatile的应用

在多线程并发编程中synchronized和volatile都扮演着重要的角色，volatile是轻量级的synchronized，它在多处理器开发中保证了共享变量的“可见性”。可见性的意思是当一个线程修改一个共享变量时，另外一个线程能读到这个修改的值。如果volatile变量修饰符使用恰当的话，它比synchronized的使用和执行成本更低，因为它不会引起线程上下文的切换和调度。本文将深入分析在硬件层面上Intel处理器是如何实现volatile的，通过深入分析帮助我们正确地使用volatile变量。

## volatile的定义与实现原理

Java语言规范第3版中对volatile的定义如下：Java编程语言允许线程访问共享变量，为了确保共享变量能被准确和一致地更新，线程应该确保通过排他锁单独获得这个变量。Java语言提供了volatile，在某些情况下比锁要更加方便。如果一个字段被声明成volatile，Java线程内存模型确保所有线程看到这个变量的值是一致的。

在了解volatile实现原理之前，我们先来看下与其实现原理相关的CPU术语与说明。

### CPU术语的定义：
术语|英文名|描述
:--|:--|:--
内存屏障|memorybarriers|是一组处理器指令，用于实现对内存操作的顺序限制
缓冲行|cacheline|缓存中可以分配的最小存储单位。处理器填写缓存线时会加载整个缓存线，需要使用多个主内存读周期
原子操作|atomicoperations|不可中断的一个或一系列操作
缓存行填充|cachelinefill|当处理器识别到从内存屮读取操作数是可缓存的，处理器读取整个缓存行到适当的缓存（Ll,L2,L3的或所有）
缓存命中|cachehit|如果进行高速缓存行填充操作的内存位置仍然是下次处理器访问的地址时，处理器从缓存中读取操作数，而不是从内存读取
写命中|writehit|当处理器将操作数写回到一个内存缓存的区域时，它首先会检查这个缓存的内存地址是否在缓存行中，如果存在一个有效的缓存行，则处理器将这个操作数写回到缓存，而不是写问到内存，这个操作被称为写命中
写缺失|writemissesthecache|一个有效的缓存行被写入到不存在的内存区域

### 代码举例

volatile是如何来保证可见性的呢？让我们在X86处理器下通过工具获取JIT编译器生成的汇编指令来查看对volatile进行写操作时， CPU会做什么事情。

Java代码如下:

`instance = newSingleton();  //instance是volatile变量`

转变成汇编代码，如下:

`0x01a3de1d: movb $0x0，0xll04800（％esi);0x01a3de24: lock addl $0x0,(%esp);`

有volatile变量修饰的共享变量进行写操作的时候会多出第二行汇编代码，通过查IA-32架构软件开发者手册可知， Lock前缀的指令在多核处理器下会引发了两件事情[1]。

1) 将当前处理器缓存行的数据写回到系统内存。
2) 这个写回内存的操作会使在其他CPU里缓存了该内存地址的数据无效。

为了提高处理速度，处理器不直接和内存进行通信，而是先将系统内存的数据读到内部缓存(L1,L2或其他)后再进行操作，但操作完不知道何时会写到内存。如果对声明了volatile的变量进行写操作， JVM就会向处理器发送一条Lock前缀的指令，将这个变量所在缓存行的数据写回到系统内存。但是，就算写回到内存，如果其他处理器缓存的值还是旧的，再执行计算操作就会有问题。所以，在多处理器下，为了保证各个处理器的缓存是_ 致的，就 会 实 现 缓 存 _致性协议，毎个处理器通过嗅探在总线上传播的数据来检查自己缓存的值是不是过期了，当处理器发现自己缓存行对应的内存地址被修改，就会将当前处理器的缓存行设置成无效状态，当处理器对这个数据进行修改操作的时候，会重新从系统内存中把数据读到处理器缓存里。

### volatile的两条实现原则。

1) Lock前缀指令会引起处理器缓存回写到内存。Lock前缀指令导致在执行指令期间，声言处理器的LOCK#信号。在多处理器环境中， LOCK#信号确保在声言该信号期间，处理器可以独占任何共享内存[2]。但是，在最近的处理器里， LOCK# 信号一般不锁总线，而是锁缓存，毕竟锁总线开销的比较大。在8.1.4节有详细说明锁定操作对处理器缓存的影响，对于Intel486和Pentium处理器，在锁操作时，总是在总线上声言LOCK#信号。但在P6和目前的处理器中，如果访问的内存区域已经缓存在处理器内部，则不会声言LOCK#信号。相反，它会锁定这块内存区域的缓存并回写到内存，并使用缓存一致性机制来确保修改的原子性，此操作被称为“缓存锁定”，缓存一致性机制会阻止同时修改由两个以上处理器缓存的内存区域数据。

2) 一个处理器的缓存回写到内存会导致其他处理器的缓存无效。IA-32处理器和Intel 64处理器使用MESI(修改、独占、共享、无效)控制协议去维护内部缓存和其他处理器缓存的一致性。在多核处理器系统中进行操作的时候， IA-32和Intel 64处理器能嗅探其他处理器访问系统内存和它们的内部缓存。处理器使用嗅探技术保证它的内部缓存、系统内存和其他处理器的缓存的数据在总线上保持一致。例如，在Pentium和P6 family处理器中，如果通过嗅探一个处理器来检测其他处理器打算写内存地址，而这个地址当前处于共享状态，那么正在嗅探的处理器将使它的缓存行无效，在下次访问相同内存地址时，强制执行缓存行填充。

## volatile的使用优化

著名的Java并发编程大师Doug lea在JDK 7的并发包里新增一个队列集合类LinkedTransferQueue, 它在使用volatile变量时，用一种追加字节的方式来优化队列出队和入队的性能。LinkedTransferQueue的代码如下。
```
/**队列中的头部节点*/
privatetransientf?inalPaddedAtomicReference<QNode>head;
/**队列中的尾部节点*/
private transient final PaddedAtomicReference<QNode> tail;
static final class PaddedAtomicReference<T> extends AtomicReferenceT>{
	//使用很多4个字节的引用追加到64个字节
	Object p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,pa,pb,pc,pd,pe;
	PaddedAtomicReference(T r){
		super(r);
	}
}
public class AtomicReference<V> implements java.io.Serializable{
	private volatile V value;
	//省略其他代码
}
```

追加字节能优化性能？这种方式看起来很神奇，但如果深入理解处理器架构就能理解其中的奥秘。让我们先来看看LinkedTransferQueue这个类，它使用一个内部类类型来定义队列的头节点（head）和尾节点（tail），而这个内部类PaddedAtomicReference相对于父类AtomicReference只做了一件事情，就是将共享变量追加到64字节。我们可以来计算下，一个对象的引用占4个字节，它追加了15个变量（共占60个字节），再加上父类的value变量，一共64个字节。

为什么追加64字节能够提高并发编程的效率呢？因为对于英特尔酷睿i7、酷睿、Atom和NetBurst，以及Core Solo和Pentium M处理器的L1、L2或L3缓存的高速缓存行是64个字节宽，不支持部分填充缓存行，这意味着，如果队列的头节点和尾节点都不足64字节的话，处理器会将它们都读到同一个高速缓存行中，在多处理器下每个处理器都会缓存同样的头、尾节点，当一个处理器试图修改头节点时，会将整个缓存行锁定，那么在缓存一致性机制的作用下，会导致其他处理器不能访问自己高速缓存中的尾节点，而队列的入队和出队操作则需要不停修改头节点和尾节点，所以在多处理器的情况下将会严重影响到队列的入队和出队效率。Doug lea使用追加到64字节的方式来填满高速缓冲区的缓存行，避免头节点和尾节点加载到同一个缓存行，使头、尾节点在修改时不会互相锁定。

那么是不是在使用volatile变量时都应该追加到64字节呢？不是的。在两种场景下不应该使用这种方式。

- 缓存行非64字节宽的处理器。如P6系列和奔腾处理器，它们的L1和L2高速缓存行是32个字节宽。
- 共享变量不会被频繁地写。因为使用追加字节的方式需要处理器读取更多的字节到高速缓冲区，这本身就会带来一定的性能消耗，如果共享变量不被频繁写的话，锁的几率也非常
小，就没必要通过追加字节的方式来避免相互锁定。

不过这种追加字节的方式在Java 7下可能不生效，因为Java 7变得更加智慧，它会淘汰或重新排列无用字段，需要使用其他追加字节的方式。除了volatile，Java并发编程中应用较多的是synchronized，下面一起来看一下。

 ## volatile的作用

　　在《Java并发编程：核心理论》一文中，我们已经提到过可见性、有序性及原子性问题，通常情况下我们可以通过Synchronized关键字来解决这些个问题，不过如果对Synchronized原理有了解的话，应该知道Synchronized是一个比较重量级的操作，对系统的性能有比较大的影响，所以，如果有其他解决方案，我们通常都避免使用Synchronized来解决问题。而volatile关键字就是Java中提供的另一种解决可见性和有序性问题的方案。对于原子性，需要强调一点，也是大家容易误解的一点：对volatile变量的单次读/写操作可以保证原子性的，如long和double类型变量，但是并不能保证i++这种操作的原子性，因为本质上i++是读、写两次操作。

## volatile的使用

　　关于volatile的使用，我们可以通过几个例子来说明其使用方式和场景。

### 1、防止重排序

　　我们从一个最经典的例子来分析重排序问题。大家应该都很熟悉单例模式的实现，而在并发环境下的单例实现方式，我们通常可以采用双重检查加锁（DCL）的方式来实现。其源码如下：

```
 1 package com.paddx.test.concurrent;
 2
 3 public class Singleton {
 4     public static volatile Singleton singleton;
 5
 6     /**
 7      * 构造函数私有，禁止外部实例化
 8      */
 9     private Singleton() {};
10
11     public static Singleton getInstance() {
12         if (singleton == null) {
13             synchronized (singleton) {
14                 if (singleton == null) {
15                     singleton = new Singleton();
16                 }
17             }
18         }
19         return singleton;
20     }
21 }
```
　　现在我们分析一下为什么要在变量singleton之间加上volatile关键字。要理解这个问题，先要了解对象的构造过程，实例化一个对象其实可以分为三个步骤：

　　（1）分配内存空间。
　　（2）初始化对象。
　　（3）将内存空间的地址赋值给对应的引用。

但是由于操作系统可以对指令进行重排序，所以上面的过程也可能会变成如下过程：

　　（1）分配内存空间。
　　（2）将内存空间的地址赋值给对应的引用。
　　（3）初始化对象

　　如果是这个流程，多线程环境下就可能将一个未初始化的对象引用暴露出来，从而导致不可预料的结果。因此，为了防止这个过程的重排序，我们需要将变量设置为volatile类型的变量。

## 2、实现可见性

　　可见性问题主要指一个线程修改了共享变量值，而另一个线程却看不到。引起可见性问题的主要原因是每个线程拥有自己的一个高速缓存区——线程工作内存。volatile关键字能有效的解决这个问题，我们看下下面的例子，就可以知道其作用：

```
 1 package com.paddx.test.concurrent;
 2
 3 public class VolatileTest {
 4     int a = 1;
 5     int b = 2;
 6
 7     public void change(){
 8         a = 3;
 9         b = a;
10     }
11
12     public void print(){
13         System.out.println("b="+b+";a="+a);
14     }
15
16     public static void main(String[] args) {
17         while (true){
18             final VolatileTest test = new VolatileTest();
19             new Thread(new Runnable() {
20                 @Override
21                 public void run() {
22                     try {
23                         Thread.sleep(10);
24                     } catch (InterruptedException e) {
25                         e.printStackTrace();
26                     }
27                     test.change();
28                 }
29             }).start();
30
31             new Thread(new Runnable() {
32                 @Override
33                 public void run() {
34                     try {
35                         Thread.sleep(10);
36                     } catch (InterruptedException e) {
37                         e.printStackTrace();
38                     }
39                     test.print();
40                 }
41             }).start();
42
43         }
44     }
45 }
```
　　直观上说，这段代码的结果只可能有两种：b=3;a=3 或 b=2;a=1。不过运行上面的代码（可能时间上要长一点），你会发现除了上两种结果之外，还出现了第三种结果：
```
...
b=2;a=1
b=2;a=1
b=3;a=3
b=3;a=3
b=3;a=1
b=3;a=3
b=2;a=1
b=3;a=3
b=3;a=3
...
```
　　为什么会出现b=3;a=1这种结果呢？正常情况下，如果先执行change方法，再执行print方法，输出结果应该为b=3;a=3。相反，如果先执行的print方法，再执行change方法，结果应该是 b=2;a=1。那b=3;a=1的结果是怎么出来的？原因就是第一个线程将值a=3修改后，但是对第二个线程是不可见的，所以才出现这一结果。如果将a和b都改成volatile类型的变量再执行，则再也不会出现b=3;a=1的结果了。

## 3、保证原子性

 　　关于原子性的问题，上面已经解释过。volatile只能保证对单次读/写的原子性。这个问题可以看下JLS中的描述：

17.7 Non-Atomic Treatment of double and long
For the purposes of the Java programming language memory model, a single write to a non-volatile long or double value is treated as two separate writes: one to each 32-bit half. This can result in a situation where a thread sees the first 32 bits of a 64-bit value from one write, and the second 32 bits from another write.

Writes and reads of volatile long and double values are always atomic.

Writes to and reads of references are always atomic, regardless of whether they are implemented as 32-bit or 64-bit values.

Some implementations may find it convenient to divide a single write action on a 64-bit long or double value into two write actions on adjacent 32-bit values. For efficiency's sake, this behavior is implementation-specific; an implementation of the Java Virtual Machine is free to perform writes to long and double values atomically or in two parts.

Implementations of the Java Virtual Machine are encouraged to avoid splitting 64-bit values where possible. Programmers are encouraged to declare shared 64-bit values as volatile or synchronize their programs correctly to avoid possible complications.

　　这段话的内容跟我前面的描述内容大致类似。因为long和double两种数据类型的操作可分为高32位和低32位两部分，因此普通的long或double类型读/写可能不是原子的。因此，鼓励大家将共享的long和double变量设置为volatile类型，这样能保证任何情况下对long和double的单次读/写操作都具有原子性。

　　关于volatile变量对原子性保证，有一个问题容易被误解。现在我们就通过下列程序来演示一下这个问题：

```
 1 package com.paddx.test.concurrent;
 2
 3 public class VolatileTest01 {
 4     volatile int i;
 5
 6     public void addI(){
 7         i++;
 8     }
 9
10     public static void main(String[] args) throws InterruptedException {
11         final  VolatileTest01 test01 = new VolatileTest01();
12         for (int n = 0; n < 1000; n++) {
13             new Thread(new Runnable() {
14                 @Override
15                 public void run() {
16                     try {
17                         Thread.sleep(10);
18                     } catch (InterruptedException e) {
19                         e.printStackTrace();
20                     }
21                     test01.addI();
22                 }
23             }).start();
24         }
25
26         Thread.sleep(10000);//等待10秒，保证上面程序执行完成
27
28         System.out.println(test01.i);
29     }
30 }
```
大家可能会误认为对变量i加上关键字volatile后，这段程序就是线程安全的。大家可以尝试运行上面的程序。下面是我本地运行的结果：



　　可能每个人运行的结果不相同。不过应该能看出，volatile是无法保证原子性的（否则结果应该是1000）。原因也很简单，i++其实是一个复合操作，包括三步骤：

　　（1）读取i的值。

　　（2）对i加1。

　　（3）将i的值写回内存。

volatile是无法保证这三个操作是具有原子性的，我们可以通过AtomicInteger或者Synchronized来保证+1操作的原子性。

注：上面几段代码中多处执行了Thread.sleep()方法，目的是为了增加并发问题的产生几率，无其他作用。

## volatile的原理

　　通过上面的例子，我们基本应该知道了volatile是什么以及怎么使用。现在我们再来看看volatile的底层是怎么实现的。

### 1、可见性实现：

　　在前文中已经提及过，线程本身并不直接与主内存进行数据的交互，而是通过线程的工作内存来完成相应的操作。这也是导致线程间数据不可见的本质原因。因此要实现volatile变量的可见性，直接从这方面入手即可。对volatile变量的写操作与普通变量的主要区别有两点：

　　（1）修改volatile变量时会强制将修改后的值刷新的主内存中。

　　（2）修改volatile变量后会导致其他线程工作内存中对应的变量值失效。因此，再读取该变量值的时候就需要重新从读取主内存中的值。

　　通过这两个操作，就可以解决volatile变量的可见性问题。

### 2、有序性实现：

 　　在解释这个问题前，我们先来了解一下Java中的happen-before规则，JSR 133中对Happen-before的定义如下：

Two actions can be ordered by a happens-before relationship.If one action happens before another, then the first is visible to and ordered before the second.

　　通俗一点说就是如果a happen-before b，则a所做的任何操作对b是可见的。（这一点大家务必记住，因为happen-before这个词容易被误解为是时间的前后）。我们再来看看JSR 133中定义了哪些happen-before规则：

• Each action in a thread happens before every subsequent action in that thread.
• An unlock on a monitor happens before every subsequent lock on that monitor.
• A write to a volatile field happens before every subsequent read of that volatile.
• A call to start() on a thread happens before any actions in the started thread.
• All actions in a thread happen before any other thread successfully returns from a join() on that thread.
• If an action a happens before an action b, and b happens before an action c, then a happens before c.

　　翻译过来为：

同一个线程中的，前面的操作 happen-before 后续的操作。（即单线程内按代码顺序执行。但是，在不影响在单线程环境执行结果的前提下，编译器和处理器可以进行重排序，这是合法的。换句话说，这一是规则无法保证编译重排和指令重排）。
监视器上的解锁操作 happen-before 其后续的加锁操作。（Synchronized 规则）
对volatile变量的写操作 happen-before 后续的读操作。（volatile 规则）
线程的start() 方法 happen-before 该线程所有的后续操作。（线程启动规则）
线程所有的操作 happen-before 其他线程在该线程上调用 join 返回成功后的操作。
如果 a happen-before b，b happen-before c，则a happen-before c（传递性）。
　　这里我们主要看下第三条：volatile变量的保证有序性的规则。《Java并发编程：核心理论》一文中提到过重排序分为编译器重排序和处理器重排序。为了实现volatile内存语义，JMM会对volatile变量限制这两种类型的重排序。

### 3、内存屏障

　　为了实现volatile可见性和happen-befor的语义。JVM底层是通过一个叫做“内存屏障”的东西来完成。内存屏障，也叫做内存栅栏，是一组处理器指令，用于实现对内存操作的顺序限制。下面是完成上述规则所要求的内存屏障：

（1）LoadLoad 屏障
执行顺序：Load1—>Loadload—>Load2
确保Load2及后续Load指令加载数据之前能访问到Load1加载的数据。

（2）StoreStore 屏障
执行顺序：Store1—>StoreStore—>Store2
确保Store2以及后续Store指令执行前，Store1操作的数据对其它处理器可见。

（3）LoadStore 屏障
执行顺序： Load1—>LoadStore—>Store2
确保Store2和后续Store指令执行前，可以访问到Load1加载的数据。

（4）StoreLoad 屏障
执行顺序: Store1—> StoreLoad—>Load2
确保Load2和后续的Load指令读取之前，Store1的数据对其他处理器是可见的。

最后我可以通过一个实例来说明一下JVM中是如何插入内存屏障的：

```
 1 package com.paddx.test.concurrent;
 2
 3 public class MemoryBarrier {
 4     int a, b;
 5     volatile int v, u;
 6
 7     void f() {
 8         int i, j;
 9
10         i = a;
11         j = b;
12         i = v;
13         //LoadLoad
14         j = u;
15         //LoadStore
16         a = i;
17         b = j;
18         //StoreStore
19         v = i;
20         //StoreStore
21         u = j;
22         //StoreLoad
23         i = u;
24         //LoadLoad
25         //LoadStore
26         j = b;
27         a = i;
28     }
29 }
```

## volatile使用场景

总体来说，volatile是并发编程中的一种优化，在某些场景下可以代替Synchronized。但是，volatile的不能完全取代Synchronized的位置，只有在一些特殊的场景下，才能适用volatile。总的来说，必须同时满足下面两个条件才能保证在并发环境的线程安全：
　　（1）对变量的写操作不依赖于当前值。
　　（2）该变量没有包含在具有其他变量的不变式中。
