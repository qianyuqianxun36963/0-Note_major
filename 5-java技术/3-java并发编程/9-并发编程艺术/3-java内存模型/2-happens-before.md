# happens-before

先行发生原则（happens-before）

happens-before是JMM最核心的概念。对应Java程序员来说，理解happens-before是理解JMM的关键。

首先，让我们来看JMM的设计意图。从JMM设计者的角度，在设计JMM时，需要考虑两个关键因素。

- 程序员对内存模型的使用。程序员希望内存模型易于理解、易于编程。程序员希望基于一个强内存模型来编写代码。

- 编译器和处理器对内存模型的实现。编译器和处理器希望内存模型对它们的束缚越少越好，这样它们就可以做尽可能多的优化来提高性能。编译器和处理器希望实现一个弱内存模型。

由于这两个因素互相矛盾，所以JSR-133专家组在设计JMM时的核心目标就是找到一个好的平衡点：一方面，要为程序员提供足够强的内存可见性保证；另一方面，对编译器和处理器的限制要尽可能地放松。下面让我们来看JSR-133是如何实现这一目标的。

## happens-before的定义

happens-before的概念最初由Leslie Lamport在其一篇影响深远的论文（《Time，Clocks andthe Ordering of Events in a Distributed System》）中提出。Leslie Lamport使用happens-before来定义分布式系统中事件之间的偏序关系（partial ordering）。Leslie Lamport在这篇论文中给出了一个分布式算法，该算法可以将该偏序关系扩展为某种全序关系。
JSR-133使用happens-before的概念来指定两个操作之间的执行顺序。由于这两个操作可以在一个线程之内，也可以是在不同线程之间。因此，JMM可以通过happens-before关系向程序员提供跨线程的内存可见性保证（如果A线程的写操作a与B线程的读操作b之间存在happensbefore关系，尽管a操作和b操作在不同的线程中执行，但JMM向程序员保证a操作将对b操作可见）。

《JSR-133:Java Memory Model and Thread Specification》对happens-before关系的定义如下。

1）如果一个操作happens-before另一个操作，那么第一个操作的执行结果将对第二个操作可见，而且第一个操作的执行顺序排在第二个操作之前。

2）两个操作之间存在happens-before关系，并不意味着Java平台的具体实现必须要按照happens-before关系指定的顺序来执行。如果重排序之后的执行结果，与按happens-before关系来执行的结果一致，那么这种重排序并不非法（也就是说，JMM允许这种重排序）。

上面的1）是JMM对程序员的承诺。从程序员的角度来说，可以这样理解happens-before关系：如果A happens-before B，那么Java内存模型将向程序员保证——A操作的结果将对B可见，且A的执行顺序排在B之前。注意，这**只是Java内存模型向程序员做出的保证**！

上面的2）是JMM对编译器和处理器重排序的约束原则。正如前面所言，JMM其实是在遵循一个基本原则：只要不改变程序的执行结果（指的是单线程程序和正确同步的多线程程序），编译器和处理器怎么优化都行。JMM这么做的原因是：程序员对于这两个操作是否真的被重排序并不关心，程序员关心的是程序执行时的语义不能被改变（即执行结果不能被改变）。因此，happens-before关系本质上和as-if-serial语义是一回事。

·as-if-serial语义保证单线程内程序的执行结果不被改变，happens-before关系保证正确同步的多线程程序的执行结果不被改变。

·as-if-serial语义给编写单线程程序的程序员创造了一个幻境：单线程程序是按程序的顺序来执行的。happens-before关系给编写正确同步的多线程程序的程序员创造了一个幻境：正确同步的多线程程序是按happens-before指定的顺序来执行的。

as-if-serial语义和happens-before这么做的目的，都是为了在不改变程序执行结果的前提下，尽可能地提高程序执行的并行度。

## happen-before 规则

《JSR-133:Java Memory Model and Thread Specification》定义了如下happens-before规则。

1. 程序顺序规则：一个线程中的每个操作，happens-before于该线程中的任意后续操作。

2. 监视器锁规则：对一个锁的解锁，happens-before于随后对这个锁的加锁。

3. volatile变量规则：对一个volatile域的写，happens-before于任意后续对这个volatile域的读。

4. 传递性：如果A happens-before B，且B happens-before C，那么A happens-before C。

5. start()规则：如果线程A执行操作ThreadB.start()（启动线程B），那么A线程的ThreadB.start()操作happens-before于线程B中的任意操作。

6. join()规则：如果线程A执行操作ThreadB.join()并成功返回，那么线程B中的任意操作happens-before于线程A从ThreadB.join()操作成功返回。

这里的规则1）、2）、3）和4）前面都讲到过，这里再做个总结。由于2）和3）情况类似，这里
只以1）、3）和4）为例来说明。图3-34是volatile写-读建立的happens-before关系图。

## 先行发生原则（Happens-before）

先行发生原则（Happens-Before）是判断数据是否存在竞争、线程是否安全的主要依据。

先行发生是Java内存，模型中定义的两项操作之间的偏序关系，如果操作A先行发生于操作B，那么操作A产生的影响能够被操作B观察到。

Java内存模型中存在的天然的先行发生关系：

1. 程序次序规则：同一个线程内，按照代码出现的顺序，前面的代码先行于后面的代码，准确的说是控制流顺序，因为要考虑到分支和循环结构。

2. 管程锁定规则：一个unlock操作先行发生于后面（时间上）对同一个锁的lock操作。

3. volatile变量规则：对一个volatile变量的写操作先行发生于后面（时间上）对这个变量的读操作。

4. 线程启动规则：Thread的start( )方法先行发生于这个线程的每一个操作。

5. 线程终止规则：线程的所有操作都先行于此线程的终止检测。可以通过Thread.join( )方法结束、Thread.isAlive( )的返回值等手段检测线程的终止。

6. 线程中断规则：对线程interrupt( )方法的调用先行发生于被中断线程的代码检测到中断事件的发生，可以通过Thread.interrupt( )方法检测线程是否中断

7. 对象终结规则：一个对象的初始化完成先行于发生它的finalize（）方法的开始。

8. 传递性：如果操作A先行于操作B，操作B先行于操作C，那么操作A先行于操作C。

总结：一个操作“时间上的先发生”不代表这个操作先行发生；一个操作先行发生也不代表这个操作在时间上是先发生的（重排序的出现）。
时间上的先后顺序对先行发生没有太大的关系，所以衡量并发安全问题的时候不要受到时间顺序的影响，一切以先行发生原则为准。
