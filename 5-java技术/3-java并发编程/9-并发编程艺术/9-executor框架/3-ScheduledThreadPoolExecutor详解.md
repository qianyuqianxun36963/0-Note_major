# ScheduledThreadPoolExecutor详解

ScheduledThreadPoolExecutor继承自ThreadPoolExecutor。它主要用来在给定的延迟之后运行任务，或者定期执行任务。ScheduledThreadPoolExecutor的功能与Timer类似，但ScheduledThreadPoolExecutor功能更强大、更灵活。Timer对应的是单个后台线程，而ScheduledThreadPoolExecutor可以在构造函数中指定多个对应的后台线程数。

## ScheduledThreadPoolExecutor的运行机制

ScheduledThreadPoolExecutor的执行示意图（本文基于JDK 6）如图10-8所示。

![](assets/markdown-img-paste-20190703232908230.png)

DelayQueue是一个无界队列，所以ThreadPoolExecutor的maximumPoolSize在ScheduledThreadPoolExecutor中没有什么意义（设置maximumPoolSize的大小没有什么效果）。

ScheduledThreadPoolExecutor的执行主要分为两大部分。

1）当调用ScheduledThreadPoolExecutor的scheduleAtFixedRate()方法或者scheduleWithFixedDelay()方法时，会向ScheduledThreadPoolExecutor的DelayQueue添加一个实现了RunnableScheduledFutur接口的ScheduledFutureTask。

2）线程池中的线程从DelayQueue中获取ScheduledFutureTask，然后执行任务。

ScheduledThreadPoolExecutor为了实现周期性的执行任务，对ThreadPoolExecutor做了如下的修改。
- 使用DelayQueue作为任务队列。
- 获取任务的方式不同（后文会说明）。
- 执行周期任务后，增加了额外的处理（后文会说明）。

## ScheduledThreadPoolExecutor的实现

前面我们提到过，ScheduledThreadPoolExecutor会把待调度的任务（ScheduledFutureTask）放到一个DelayQueue中。

ScheduledFutureTask主要包含3个成员变量，如下。
- long型成员变量time，表示这个任务将要被执行的具体时间。
- long型成员变量sequenceNumber，表示这个任务被添加到ScheduledThreadPoolExecutor中的序号。
- long型成员变量period，表示任务执行的间隔周期。

DelayQueue封装了一个PriorityQueue，这个PriorityQueue会对队列中的ScheduledFutureTask进行排序。排序时，time小的排在前面（时间早的任务将被先执行）。如果两个ScheduledFutureTask的time相同，就比较sequenceNumber，sequenceNumber小的排在前面（也就是说，如果两个任务的执行时间相同，那么先提交的任务将被先执行）。

首先，让我们看看ScheduledThreadPoolExecutor中的线程执行周期任务的过程。图10-9是ScheduledThreadPoolExecutor中的线程1执行某个周期任务的4个步骤。

![](assets/markdown-img-paste-20190703233123743.png)

下面是对这4个步骤的说明。

1）线程1从DelayQueue中获取已到期的ScheduledFutureTask（DelayQueue.take()）。到期任务是指ScheduledFutureTask的time大于等于当前时间。
2）线程1执行这个ScheduledFutureTask。
3）线程1修改ScheduledFutureTask的time变量为下次将要被执行的时间。
4）线程1把这个修改time之后的ScheduledFutureTask放回DelayQueue中（DelayQueue.add()）。

接下来，让我们看看上面的步骤1）获取任务的过程。下面是DelayQueue.take()方法的源代码实现。

```
public E take() throws InterruptedException {
	final ReentrantLock lock = this.lock;
	lock.lockInterruptibly(); // 1
	try {
		for (;;) {
			E first = q.peek();ScheduledThreadPoolExecutor
			if (first == null) {
				available.await(); // 2.1
			} else {
				long delay = first.getDelay(TimeUnit.NANOSECONDS);
				if (delay > 0) {
					long tl = available.awaitNanos(delay); // 2.2
				} else {
					E x = q.poll(); // 2.3.1
					assert x != null;
					if (q.size() != 0)
					available.signalAll(); // 2.3.2
					return x;
				}
			}
		}
	} finally {
		lock.unlock(); // 3
	}
}
```

图10-10是DelayQueue.take()的执行示意图。

![](assets/markdown-img-paste-20190703233611971.png)

如图所示，获取任务分为3大步骤。
1）获取Lock。

2）获取周期任务。

- 如果PriorityQueue为空，当前线程到Condition中等待；否则执行下面的2.2。
- 如果PriorityQueue的头元素的time时间比当前时间大，到Condition中等待到time时间；否则执行下面的2.3。
- 获取PriorityQueue的头元素（2.3.1）；如果PriorityQueue不为空，则唤醒在Condition中等待的所有线程（2.3.2）。

3）释放Lock。

ScheduledThreadPoolExecutor在一个循环中执行步骤2，直到线程从PriorityQueue获取到一个元素之后（执行2.3.1之后），才会退出无限循环（结束步骤2）。

最后，让我们看看ScheduledThreadPoolExecutor中的线程执行任务的步骤4，把ScheduledFutureTask放入DelayQueue中的过程。下面是DelayQueue.add()的源代码实现。
```
public boolean offer(E e) {
	final ReentrantLock lock = this.lock;
	lock.lock(); // 1
	try {
		E first = q.peek();
		q.offer(e); // 2.1
		if (first == null || e.compareTo(first) < 0)
			available.signalAll(); // 2.2
		return true;
	} finally {
		lock.unlock(); // 3
	}
}
```
图10-11是DelayQueue.add()的执行示意图。

![](assets/markdown-img-paste-20190703234757715.png)

如图所示，添加任务分为3大步骤。

1）获取Lock。

2）添加任务。

- 向PriorityQueue添加任务。
- 如果在上面2.1中添加的任务是PriorityQueue的头元素，唤醒在Condition中等待的所有线程。

3）释放Lock。
