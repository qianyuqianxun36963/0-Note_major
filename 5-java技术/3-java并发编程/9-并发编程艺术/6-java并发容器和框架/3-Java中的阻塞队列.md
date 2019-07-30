# Java中的阻塞队列

本节将介绍什么是阻塞队列，以及Java中阻塞队列的4种处理方式，并介绍Java 7中提供的7种阻塞队列，最后分析阻塞队列的一种实现方式。

## 什么是阻塞队列

阻塞队列（BlockingQueue）是一个支持两个附加操作的队列。这两个附加的操作支持阻塞的插入和移除方法。

1. 支持阻塞的插入方法：意思是当队列满时，队列会阻塞插入元素的线程，直到队列不满。
2. 支持阻塞的移除方法：意思是在队列为空时，获取元素的线程会等待队列变为非空。

阻塞队列常用于生产者和消费者的场景，生产者是向队列里添加元素的线程，消费者是从队列里取元素的线程。阻塞队列就是生产者用来存放元素、消费者用来获取元素的容器。

在阻塞队列不可用时，这两个附加操作提供了4种处理方式，如表6-1所示。

表6-1 插入和移除操作的4中处理方式

|方法/处理方式|抛出异常|返回特殊值|-直阻塞|超时退出|
|--|--|--|--|--|
|插人方法|add(e)|offer(e)|put(e)|offer(e,time,unit)|
|移除方法|remove()|poll()|take()|poll(time,unit)|
|检查方法|element()|peek()|不可用|不可用|

- 抛出异常：当队列满时，如果再往队列里插入元素，会抛出IllegalStateExceptionC'Queuefull")异常。当队列空时，从队列里获取元素会抛出NoSuchElementException异常。
- 返回特殊值：当往队列插入元素时，会返回元素是否插入成功，成功返回true。如果是移除方法，则是从队列里取出一个元素，如果没有则返回null。
- 一直阻塞：当阻塞队列满时，如果生产者线程往队列里put元素，队列会_直阻塞生产者线程，直到队列可用或者响应中断退出。当队列空时，如果消费者线程从队列里take元素，队列会阻塞住消费者线程，直到队列不为空。
- 超时退出：当阻塞队列满时，如果生产者线程往队列里插入元素，队列会阻塞生产者线程1 段时间，如果超过了指定的时间，生产者线程就会退出。

这两个附加操作的4种处理方式不方便记忆，所以我找了_下这几个方法的规律。put和take分别尾首含有字母t， offer和poll都含有字母o。

注意 如果是无界阻塞队列，队列不可能会出现满的情况，所以使用put或offer方法永远不会被阻塞，而且使用offer方法时，该方法永远返回true。

## Java里的阻塞队列

JDK 7提供了 7个阻塞队列，如下。

- ArrayBlockingQueue: 个由数组结构组成的有界阻塞队列。
- LinkedBlockingQueue:―^个由链表结构组成的有界阻塞队列。
- PriorityBlockingQueue: 个支持优先级排序的无界阻塞队列。
- DelayQueue ：- 个使用优先级队列实现的无界阻塞队列。
- SynchronousQueue:— 个不存储元素的阻塞队列。
- LinkedTransferQueue:―^个由链表结构组成的无界阻塞队列。
- LinkedBlockingDeque:―^个由链表结构组成的双向阻塞队列。

## 1.ArrayBlockingQueue

ArrayBlockingQueue是一个用数组实现的有界阻塞队列。此队列按照先进先出(FIFO)的原则对元素进行排序。

默认情况下不保证线程公平的访问队列，所谓公平访问队列是指阻塞的线程，可以按照阻塞的先后顺序访问队列，即先阻塞线程先访问队列。非公平性是对先等待的线程是非公平的，当队列可用时，阻塞的线程都可以争夺访问队列的资格，有可能先阻塞的线程最后才访问队列。为了保证公平性，通常会降低吞吐量。我们可以使用以下代码创建一个公平的阻塞队列。
    ArrayBlockingQueue fairQueue = new ArrayBlockingQueue(1000,true);
访问者的公平性是使用可重入锁实现的，代码如下。
```
    public ArrayBlockingQueue(int capacity, boolean fair) {
        if (capacity <= 0)
            throw new IllegalArgumentException();
        this.items = new Object[capacity];
        lock = new ReentrantLock(fair);
        notEmpty = lock.newCondition();
        notFull = lock.newCondition();
    }
```
## 2.LinkedBlockingQueue
LinkedBlockingQueue是一个用链表实现的有界阻塞队列。此队列的默认和最大长度为
Integer.MAXJVALUE。此队列按照先进先出的原则对元素进行排序。
3.PriorityBlockingQueue
PriorityBlockingQueue是一个支持优先级的无界阻塞队列。默认情况下元素采取自然顺序
升序排列。也可以自定义类实现compareTo()方法来指定元素排序规则，或者初始化
PriorityBlockingQueue时，指定构造参数Comparator来对元素进行排序。需要注意的是不能保证
同优先级元素的顺序。
4.DelayQueue
DelayQueue是一个支持延时获取元素的无界阻塞队列。队列使用PriorityQueue来实现。队
列中的元素必须实现Delayed接口，在创建元素时可以指定多久才能从队列中获取当前元素。
只有在延迟期满时才能从队列中提取元素。
DelayQueue非常有用，可以将DelayQueue运用在以下应用场景。
•缓存系统的设计:可以用DelayQueue保存缓存元素的有效期，使用一个线程循环查询
DelayQueue, —旦能从DelayQueue中获取元素时，表示缓存有效期到了。
•定时任务调度:使用DelayQueue保存当天将会执行的任务和执行时间，_ 旦从
DelayQueue中获取到任务就开始执行，比如TimerQueue就是使用DelayQueue实现的。
(1)如何实现Delayed接口
DelayQueue队列的元素必须实现Delayed接口。我们可以参考ScheduledThreadPoolExecutor
里ScheduledFutureTask类的实现，_ 共有三步。
第一步:在对象创建的时候，初始化基本数据。使用time记录当前对象延迟到什么时候可
以使用，使用sequenceNumber来标识元素在队列中的先后顺序。代码如下。
p r i v a t e s t a t i c f i n a l A t o m i c L o n g s e q u e n c e r = n e w A t o m i c L o n g (0);
S c h e d u l e d F u t u r e T a s k ( R u n n a b l e r, V result, l o n g ns, l o n g period) {
S c h e d u l e d F u t u r e T a s k ( R u n n a b l e r, V result, l o n g ns, l o n g period) {
super(r, r e s u l t ) ;
t h i s . t i m e = ns;
t h i s . p e r i o d = period;
t h i s .s e q u e n c e N u m b e r = s e q u e n c e r . g e t A n d I n c r e m e n t ( ) ;
}
第二步:实现getDelay方法，该方法返回当前元素还需要延时多长时间，单位是纳秒，代码
如下。
p u b l i c l o n g g e t D e l a y ( T i m e U n i t unit) {
r e t u r n u n i t .c o n v e r t ( t i m e - n o w (), T i m e U n i t . N A N O S E C O N D S ) ;
}
通过构造函数可以看出延迟时间参数ns的单位是纳秒，自己设计的时候最好使用纳秒，因
为实现getDelay()方法时可以指定任意单位，_ 旦以秒或分作为单位，而延时时间又精确不到
纳秒就麻烦了。使用时请注意当time小于当前时间时， getDelay会返回负数。
第三步:实现compareTo方法来指定元素的顺序。例如，让延时时间最长的放在队列的末
尾。实现代码如下。
p u b l i c int c o m p a r e T o ( D e l a y e d other) {
if (other == this) // c o m p a r e zero O N L Y if same o b j e c t
r e t u r n 0;
if (other i n s t a n c e o f S c h e d u l e d F u t u r e T a s k ) {
S c h e d u l e d F u t u r e T a s k < > x = ( S c h e d u l e d F u t u r e T a s k < > ) o t h e r ;
l o n g d i f f = t ime — x.time;
if (diff < 0)
r e t u r n -1;
e l s e if (diff > 0)
r e t u r n 1;
e l s e if ( s e q u e n c e N u m b e r < x . s e q u e n c e N u m b e r )
r e t u r n -1;
else
r e t u r n 1;
}
l ong d = ( g e t D e l a y ( T i m e U n i t .N A N O S E C O N D S ) -
o t h e r . g e t D e l a y ( T i m e U n i t . N A N O S E C O N D S ) );
r e t u r n (d == 0) 0 : ( (d < 0) -1 : 1);
}
(2)如何实现延时阻塞队列
延时阻塞队列的实现很简单，当消费者从队列里获取元素时，如果元素没有迖到延时时
间，就阻塞当前线程。
l ong d e l a y = f i r s t . g e t D e l a y ( T i m e U n i t .N A N O S E C O N D S );
if (delay <= 0)
r e t u r n q .p o l l ();
e lse if (leader != null)
a v a i l a b l e .a w a i t ();
e lse {
T h r e a d t h i s T h r e a d = T h r e a d . c u r r e n t T h r e a d ();
l e a d e r = t h i s T h r e a d ;
t r y {
a v a i l a b l e . a w a i t N a n o s ( d e l a y ) ;
} f i n a l l y {
if (leader == t h i s Thread)
l e a d e r = null;
}
}
代码中的变量leader是一个等待获取队列头部元素的线程。如果leader不等于空，表示已
经有线程在等待获取队列的头元素。所以，使用await()方法让当前线程等待信号。如果leader
等于空，则把当前线程设置成leader，并使用awaitNanos()方法让当前线程等待接收信号或等
待delay时间。
5.SynchronousQueue
SynchronousQueue是 个 不 存 储 元 素 的 阻 塞 队 列 。毎 个 put操 作 必 须 等 待 个 take操作,
否则不能继续添加元素。
它支持公平访问队列。默认情况下线程采用非公平性策略访问队列。使用以下构造方法
可以创建公平性访问的SynchronousQueue, 如果设置为true, 则等待的线程会采用先进先出的
顺序访问队列。
p u b l i c S y n c h r o n o u s Q u e u e ( b o o l e a n fair) {
t r a n s f e r e r = f air n e w T r a n s f e r Q u e u e ( ) : n e w T r a n s f e r S t a c k ( ) ;
}
SynchronousQueue可 以 看 成 是 _个 传 球 手 ，负责把生产者线程处理的数据直接传递给消费
者线程。队列本身并不存储任何元素，非常适合传递性场景。 SynchronousQueue的吞吐量高于
LinkedBlockingQueue和ArrayBlockingQueue。
6.LinkedTransferQueue
LinkedTransferQueue是— 个由链表结构组成的无界阻塞TransferQueue队列。相对于其他阻
塞队列， LinkedTransferQueue 多了tryTransfer和transfer方法。
(1)transfer方法
如果当前有消费者正在等待接收元素(消费者使用take()方法或带时间限制的poll()方法
时）， transfer方法可以把生产者传入的元素立刻transfer(传输)给消费者。如果没有消费者在等
待接收元素， transfer方法会将元素存放在队列的tail节点，并等到该元素被消费者消费了才返
回。transfer方法的关键代码如下。
N o d e p r e d = t r y A p p e n d (s , h a v e D a t a ) ;
r e t u r n a w a i t M a t c h (s , pred, e , (how == TIMED), nanos);
第1 行代码是试图把存放当前元素的s节点作为tail节点。第二行代码是让CPU自旋等待
消费者消费元素。因为自旋会消耗CPU, 所以自旋一定的次数后使用Thread. yield()方法来暂停
当前正在执行的线程，并执行其他线程。
(2)tryTransfer方法
tryTransfer方法是用来试探生产者传入的元素是否能直接传给消费者。如果没有消费者等
待接收元素，则返回false。和transfer方法的区别是tryTransfer方法无论消费者是否接收，方法
立即返回，而transfer方法是必须等到消费者消费了才返回。
对于带有时间限制的tryTransfer(E e, longtimeout,TimeUnit unit)方法，试图把生产者传入
的元素直接传给消费者，但是如果没有消费者消费该元素则等待指定的时间再返回，如果超
时还没消费元素，则返回false, 如果在超时时间内消费了元素，则返回true。
7.LinkedBlockingDeque
LinkedBlockingDeque是一个由链表结构组成的双向阻塞队列。所谓双向队列指的是可以
从队列的两端插入和移出元素。双向队列因为多了一个操作队列的入口，在多线程同时入队
时，也就减少了一半的竞争。相比其他的阻塞队列， LinkedBlockingDeque多了addFirst、
addLast、 offerFirst、 offerLast、 peekFirst和peekLast等方法，以First单词结尾的方法，表示插入、
获 取 (peek)或移除双端队列的第一个元素。以Last单词结尾的方法，表示插入、获取或移除双
端队列的最后一个元素。另外，插入方法add等同于addLast，移除方法remove等效于
removeFirst。但是take方法却等同于takeFirst，不知道是不是JDK的bug，使用时还是用带有First
和Last后缀的方法更清楚。
在初始化LinkedBlockingDeque时可以设置容量防止其过度膨胀。另外，双向阻塞队列可以
运用在“工作窃取”模式中。

阻 塞 队 列 的 实 现 原 理
如果队列是空的，消费者会一直等待，当生产者添加元素时，消费者是如何知道当前队列
有元素的呢？如果让你来设计阻塞队列你会如何设计，如何让生产者和消费者进行高效率的
通 信呢？让我们先来看看JDK是如何实现的。
使用通知模式实现。所谓通知模式，就是当生产者往满的队列里添加元素时会阻塞住生
产者，当消费者消费了一个队列中的元素后，会通知生产者当前队列可用。通过查看JDK源码
发现ArrayBlockingQueue使用了Condition来实现，代码如下。
p r i v a t e f i n a l C o n d i t i o n notFull;
p r i v a t e f i n a l C o n d i t i o n n o t E mpty;
p u b l i c A r r a y B l o c k i n g Q u e u e ( i n t capacity, b o o l e a n fair) {
/ / 省 略 其 他 代 码
n o t E m p t y = l o c k .n e w C o n d i t i o n ();
n o t F u l l = l o c k .n e w C o n d i t i o n ();
}
p u b l i c v o i d p u t ( E e) t h r o w s I n t e r r u p t e d E x c e p t i o n {
c h e c k N o t N u l l ( e ) ;
f i n a l R e e n t r a n t L o c k l ock = t h i s . l o c k ;
l 〇c k . l 〇c k I n t e r r u p t i b l y ( ) ;
t r y {
w h i l e (count == i t e m s .length)
n o t F u l l .a w a i t ();
i n s e r t (e);
} f i n a l l y {
l o c k .u n l o c k ();
}
}
p u b l i c E t a k e () t h r o w s I n t e r r u p t e d E x c e p t i o n {
f i n a l R e e n t r a n t L o c k l ock = t h i s . l o c k ;
l o c k . l o c k I n t e r r u p t i b l y ( ) ;
t r y {
w h i l e (count == 0)
n o t E m p t y . a w a i t ();
r e t u r n e x t r a c t ( ) ;
} f i n a l l y {
l o c k .u n l o c k ();
}
}
p r i v a t e v o i d i n s e r t (E x) {
i t e m s [ p u t I n d e x ] = x ;
p u t I n d e x = i n c ( p u t l n d e x ) ;
++count;
n o t E m p t y . s i g n a l ();
}
当往队列里插入一个元素时，如果队列不可用，那么阻塞生产者主要通过
LockSupport.park(this)来实现。
p u b l i c f i n a l v o i d a w a i t () t h r o w s I n t e r r u p t e d E x c e p t i o n {
if ( T h r e a d . i n t e r r u p t e d ( ) )
t h r o w n e w I n t e r r u p t e d E x c e p t i o n ( ) ;
N o d e n o d e = a d d C o n d i t i o n W a i t e r ( ) ;
int s a v e d S t a t e = f u l l y R e l e a s e ( n o d e ) ;
int i n t e r r u p t M o d e = 0;
w h i l e ( !i s O n S y n c Q u e u e ( n o d e ) ) {
L o c k S u p p o r t . p a r k ( t h i s ) ;
if ( ( i n t e r r u p t M o d e = c h e c k I n t e r r u p t W h i l e W a i t i n g ( n o d e ) ) != 0)
break;
}
if ( a c q u i r e Q u e u e d ( n o d e , s a v e d S t a t e ) && i n t e r r u p t M o d e != T H R O W IE)
i n t e r r u p t M o d e = R E I N T E R R U P T ;
if ( n o d e .n e x t W a i t e r != null) // c l e a n up if c a n c e l l e d
u n l i n k C a n c e l l e d W a i t e r s ();
if ( i n t e r r u p t M o d e != 0)
r e p o r t I n t e r r u p t A f t e r W a i t ( i n t e r r u p t M o d e ) ;
}
继续进入源码，发现调用setBlocker先保存一下将要阻塞的线程，然后调用unsafe.park阻塞
当前线程。
p u b l i c s t a t i c v o i d p a r k ( O b j e c t blocker) {
T h r e a d t = T h r e a d . c u r r e n t T h r e a d ( ) ;
s e t B l o c k e r ( t , b l o c k e r ) ;
u n s a f e . p a r k ( f a l s e , 0L);
s e t B l o c k e r ( t , n u l l ) ;
}
unsafe.park是个native方法，代码如下。
p u b l i c n a t i v e v o i d p a r k ( b o o l e a n i s A b s o l u t e , l ong time);
park这个方法会阻塞当前线程，只有以下4种情况中的一种发生时，该方法才会返回。
•与park对应的unpark执行或已经执行时。“已经执行”是指unpark先执行，然后再执行park
的情况。
•线程被中断时。
•等待完time参数指定的毫秒数时。
•异常现象发生时，这个异常现象没有任何原因。
继续看一下JVM是如何实现park方法:park在不同的操作系统中使用不同的方式实现，在
Linux下使用的是系统方法pthread_cond_wait实现。实现代码在JVM源码路径
src/os/linux/vm/os_linux.cpp里的os::PlatformEvent::park方法，代码如下。
v o i d o s : : P l a t f o r m E v e n t : : p a r k ( ) {
int v ;
for (;;) {
v = E v e n t ;
if ( A t o m i c : : c m p x c h g (v-1, & E v e n t , v) == v) b r e a k ;
} _
g u a r a n t e e (v >= 0, " i n v a r i a n t " ) ;
if (v == 0) {
// Do this the h a r d w a y b y b l o c k i n g ...
int s t a t u s = p t h r e a d m u t e x l o c k ( mutex);
a s s e r t _ s t a t u s ( s t a t u s = = 〇, status, " m u t e x _ l o c k " ) ;
g u a r a n t e e ( n P a r k e d = = 〇, " i n v a r i a n t " ) ;
++ n P a r k e d ;
w h i l e ( E v e n t < 0) {
s tatus = p t h r e a d _ c o n d _ w a i t ( _ c o n d , _ m u t e x ) ;
// for some reason, u n d e r 2.7 lwp c o n d w a i t () m a y r e t u r n E T I M E ...
// T r e a t this the same as if the w a i t was i n t e r r u p t e d
if (status == ETIME) { s tatus = EINTR; }
a s s e r t _ s t a t u s ( s t a t u s = = 〇 || s t a t u s == EINTR, status, " c o n d _ w a i t " ) ;
} _ _
-- n P a r k e d ;
// In t h e o r y we c o u l d m o v e the ST of 〇 i n t o E v e n t p a s t the u n l o c k (),
// b u t t h e n w e Td n e e d a M E M B A R a f t e r the ST.
E v e n t = 〇 ;
s tatus = p t h r e a d m u t e x u n l o c k ( mute x ) ;
a s s e r t _ s t a t u s ( s t a t u s = = 〇, status, " m u t e x _ u n l o c k " ) ;
} _ _
g u a r a n t e e ( E v e n t > = 〇, " i n v a r i a n t " ) ;
} _
}
pthread_cond_wait是— 个多线程的条件变量函数， cond是condition的缩写，字面意思可以
理解为线程在等待一个条件发生，这个条件是一个全局变量。这个方法接收两个参数:一个共
享变量_cond, 个互斥量_^〇加\。而unpark方法在Linux下是使用pthread_cond_signal实现的。
park方法在Windows下则是使用WaitForSingleObject实现的。想知道pthread_cond_wait是如何实
现的，可以参考glibc-2.5的nptl/sysdeps/pthread/pthread_cond_wait.c。
当线程被阻塞队列阻塞时，线程会进入WAITING(parking)状态。我们可以使用jstack dump
阻塞的生产者线程看到这点，如下。
"main" p r i o = 5 t i d = 〇x 〇〇〇〇7 f c 8 3 c 〇〇〇〇〇〇 n i d = 〇x 1 〇1 6 4 e 〇〇〇 w a i t i n g on c o n d i t i o n [〇x 〇〇〇〇〇〇〇1 〇
j a v a . l a n g . T h r e a d . S t a t e : W A I T I N G (parking)
at s u n .m i s c . U n s a f e . p a r k ( N a t i v e Method)
一 p a r k i n g to w a i t for < 〇x 〇〇〇〇〇〇〇1 4 〇55 9 f e 8 > (a j a v a . u t i l . c o n c u r r e n t . l o c k
A b s t r a c t Q u e u e d S y n c h r o n i z e r $ C o n d i t i o n O b j e c t )
at j a v a . u t i l . c o n c u r r e n t . l o c k s . L o c k S u p p o r t .p a r k ( L o c k s u p p o r t .j a v a : 1 8 6)
at j a v a . u t i l . c o n c u r r e n t . l o c k s . A b s t r a c t Q u e u e d S y n c h r o n i z e r $ C o n d i t i o n O b j e c t
a w a i t ( A b s t r a c t Q u e u e d S y n c h r o n i z e r .j a v a : 2 〇43)
at j a v a . u t i l . c o n c u r r e n t .A r r a y B l o c k i n g Q u e u e .p u t ( A r r a y B l o c k i n g Q u e u e .j a v a :3
at b l o c k i n g q u e u e .A r r a y B l o c k i n g Q u e u e T e s t .m a i n ( A r r a y B l o c k i n g Q u e u e T e s t .j ava
