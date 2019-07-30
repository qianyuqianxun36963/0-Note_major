# Lock接口

锁是用来控制多个线程访问共享资源的方式，一般来说，一个锁能够防止多个线程同时访问共享资源（但是有些锁可以允许多个线程并发的访问共享资源，比如读写锁）。在Lock接口出现之前，Java程序是靠synchronized关键字实现锁功能的，而Java SE 5之后，并发包中新增了Lock接口（以及相关实现类）用来实现锁功能，它提供了与synchronized关键字类似的同步功能，只是在使用时需要显式地获取和释放锁。虽然它缺少了（通过synchronized块或者方法所提供的）隐式获取释放锁的便捷性，但是却拥有了锁获取与释放的可操作性、可中断的获取锁以及超时获取锁等多种synchronized关键字所不具备的同步特性。

使用synchronized关键字将会隐式地获取锁，但是它将锁的获取和释放固化了，也就是先获取再释放。当然，这种方式简化了同步的管理，可是扩展性没有显示的锁获取和释放来的好。例如，针对一个场景，手把手进行锁获取和释放，先获得锁A，然后再获取锁B，当锁B获得后，释放锁A同时获取锁C，当锁C获得后，再释放B同时获取锁D，以此类推。这种场景下，synchronized关键字就不那么容易实现了，而使用Lock却容易许多。

Lock的使用也很简单，代码清单5-1是Lock的使用的方式。

LockUseCase.java

    Lock lock = new ReentrantLock();
    lock.lock();
    try {
    } finally {
        lock.unlock();
    }

在finally块中释放锁，目的是保证在获取到锁之后，最终能够被释放。

不要将获取锁的过程写在try块中，因为如果在获取锁（自定义锁的实现）时发生了异常，异常抛出的同时，也会导致锁无故释放。

Lock接口提供的synchronized关键字所不具备的主要特性如表5-1所示。

<center>表5-1 Lock接口提供的synchronized关键字不具备的主要特性</center>

|特性|描述|
|--|--|
|尝试非阻塞地获取锁|当前线程尝试获取锁，如果这一时刻锁没W被其他线程获取到，则成功获取并持有锁|
|能被中断地获取锁|与synchronized不同，获取到锁的线程能够响位中断，获取到锁的线程被中断时，中断异常将会被抛出，同时锁会被释放|
|超时获取锁|在指定的截止时间之前获取锁，如果截止时间到了仍旧尤法获取锁，则返IP丨

<center>Lock是一个接口，它定义了锁获取和释放的基本操作， Lock的API如表5-2所示。</center>

|方法名称|描述|
|--|--|
|voidlock() |获取锁，凋用该方法当前线程将会获取锁，约锁获得后，从该方法返回|
|voidlockliiterruptibly() throwsIntemiptedException() |可中断地获取锁，和lock〇方法的不同之处在于该方法会响应中断，即在锁的获取中可以中断当前线程|
|booleantryLock()|尝试非阻塞的获取锁，调用该方法后立刻返回，如果能够获取则返回tme，否则返回false|
|booleantryLock(long time.TimeUnitunit)throws IntemiptedException| 超时的获取锁，当前线程在以下3种情况下会返回：①当前线程在超时时间内获得了锁 ②.当前线程在超时时间内被中断 ③超时时间结束，返Mfalse|
|voidunlock()|释放锁|
|ConditionnewCondition()|获取等待通知组件，该组件和当前的锁绑定，当前线程只有获得了锁，才能凋用该组件的wait()方法，而调用后，当前线程将释放锁|

这里先简单介绍一下Lock接口的API，随后的章节会详细介绍同步器AbstractQueuedSynchronizer以及常用Lock接口 的实现ReentrantLock。Lock接口的实现基本都是通过聚合了一个同步器的子类来完成线程访问控制的。
