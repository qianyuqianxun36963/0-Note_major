# Condition接口

任意一个Java对象，都拥有一组监视器方法（ 定义在java.lang.Object上），主要包括wait()、wait(long timeout)、 notify()以及notifyAll()方法，这些方法与synchronized同步关键字配合，可以实现等待/通知模式。 Condition接口也提供了类似Object的监视器方法，与Lock配合可以实现等待/通知模式，但是这两者在使用方式以及功能特性上还是有差别的。

通过对比Object的监视器方法和Condition接口，可以更详细地了解Condition的特性，对比项与结果如表5-12所示。

表5-12Object的监视器方法与Condition接口的对比

|对比项|ObjectMonitorMethods|Condition|
|--|--|--|
|前置条件|获取对象的锁|调用用Lock.lock()获取锁，调用Lock.newCoiidition()获取Condition对象|
|调用方式|直接调用，如：object.wait()|直接调用，如：condition.await()||
|等待队列个数|一个|多个|
|当前线程释放锁并进入等待状态|支持|支持|
|当前线程释放锁并进入等待状态，在等待状态中不响应中断|不支持|支持|
|$前线程释放锁并进人超时等待状态|支持|支持|
|当前线程释放锁并进入等待状态到将来的某个时间|不支持|支持|
|唤醒等待队列中的一个线程|支持|支持|
|唤醒等待队列中的全部线程|支持|支持|

## Condition接口与示例

Condition定义了等待/通知两种类型的方法，当前线程调用这些方法时，需要提前获取到Condition对象关联的锁。 Condition对象是由Lock对象(调用Lock对象的newCondition()方法)创建出来的，换句话说， Condition是依赖Lock对象的。

Condition的使用方式比较简单，需要注意在调用方法前获取锁，使用方式如代码清单5-20所示。

代码清单5-20 ConditionUseCase.java

    public class ConditionUseCase {
        Lock      lock      = new ReentrantLock();
        Condition condition = lock.newCondition();
    
        public void conditionWait() throws InterruptedException {
            lock.lock();
            try {
                condition.await();
            } finally {
                lock.unlock();
            }
        }
    
        public void conditionSignal() throws InterruptedException {
            lock.lock();
            try {
                condition.signal();
            } finally {
                lock.unlock();
            }
        }
    }
