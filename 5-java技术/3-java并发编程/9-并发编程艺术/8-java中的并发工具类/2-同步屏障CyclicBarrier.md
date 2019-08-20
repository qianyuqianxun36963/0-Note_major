# 同步屏障CyclicBarrier

CyclicBarrier的字面意思是可循环使用（ Cyclic)的屏障(Barrier)。它要做的事情是，让一
组线程到迖一个屏障(也可以叫同步点）时被阻塞，直到最后一个线程到迖屏障时，屏障才会
开门，所有被屏障拦截的线程才会继续运行。

CyclicBarrier简介
CyclicBarrier默认的构造方法是CyclicBarrier (int parties),其参数表示屏障拦截的线程数
量，毎个线程调用await方法告诉CyclicBamer我已经到迖了屏障，然后当前线程被阻塞。示例
代码如代码清单8-3所示。

代码清单8-3 CyclicBarrierTest.java
```

package com.ustc.wang.chapter08;

import java.util.concurrent.CyclicBarrier;

public class CyclicBarrierTest {

    static CyclicBarrier c = new CyclicBarrier(2);

    public static void main(String[] args) {
        new Thread(new Runnable() {


            public void run() {
                try {
                    c.await();
                } catch (Exception e) {

                }
                System.out.println(1);
            }
        }).start();

        try {
            c.await();
        } catch (Exception e) {

        }
        System.out.println(2);
    }
}
```

因为主线程和子线程的调度是由CPU决定的，两个线程都有可能先执行，所以会产生两种
输出，第一种可能输出如下。
12
第二种可能输出如下。
21
如果把new CyclicBarrier(2)修改成new CyclicBarrier(3),则主线程和子线程会永远等待，
因为没有第三个线程执行await方法，即没有第三个线程到迖屏障，所以之前到迖屏障的两个
线程都不会继续执行。
CyclicBarrier还提供一^个更高级的构造函数CyclicBarrier(int parties,Runnable barrierAction),用于在线程到迖屏障时，优先执行barrierAction, 方便处理更复杂的业务场景，如代码
清单8-4所示。

代码清单8-4 CyclicBarrierTest2.java

```
package com.ustc.wang.chapter08;
import java.util.concurrent.CyclicBarrier;

public class CyclicBarrierTest2 {
    static CyclicBarrier c = new CyclicBarrier(2, new A());
    public static void main(String[] args) {
        new Thread(new Runnable() {
            public void run() {
                try {
                    c.await();
                } catch (Exception e) {

                }
                System.out.println(1);
            }
        }).start();

        try {
            c.await();
        } catch (Exception e) {
        }
        System.out.println(2);
    }

    static class A implements Runnable {

        public void run() {
            System.out.println(3);
        }
    }
}

```
因为CyclicBarrier设置了拦截线程的数量是2 , 所以必须等代码中的第一个线程和线程A
都执行完之后，才会继续执行主线程，然后输出2 , 所以代码执行后的输出如下。
31
2

## CyclicBarrier的应用场景
CyclicBarrier可以用于多线程计算数据，最后合并计算结果的场景。例如，用一^个Excel保
存了用户所有银行流水，毎个Sheet保存一个账户近_年的毎笔银行流水，现在需要统计用户
的日均银行流水，先用多线程处理毎个sheet里的银行流水，都执行完之后，得到毎个sheet的日
均银行流水，最后，再用barrierAction用这些线程的计算结果，计算出整个Excel的日均银行流
水，如代码清单8-5所示。

代码清单8-5 BankWaterService.java
```
import java.util.Map.Entry;
import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CyclicBarrier;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

//银行流水处理服务类

public class BankWaterService implements Runnable {

//创建4个屏障，处理完之后执行当前类的run方法

    private CyclicBarrier c = new CyclicBarrier(4, this);

//假设只有4个sheet，所以只启动4个线程

    private Executor executor = Executors.newFixedThreadPool(4);

// 保存每个sheet计算出的银流结果

    private ConcurrentHashMap<String, Integer> sheetBankWaterCount = new
            ConcurrentHashMap<String, Integer>();

    private void count() {
        for (int i = 0; i < 4; i++) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
// 计算当前sheet的银流数据，计算代码省略
                    sheetBankWaterCount
                            .put(Thread.currentThread().getName(), 1);
// 银流计算完成，插入一个屏障
                    try {
                        c.await();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    } catch (BrokenBarrierException e) {
                        e.printStackTrace();
                    }
                }
            });
        }
    }

    @Override
    public void run() {
        int result = 0;
// 汇总每个sheet计算出的结果
        for (Entry<String, Integer> sheet : sheetBankWaterCount.entrySet()) {
            result += sheet.getValue();
        }//将结果输出
        sheetBankWaterCount.put("result", result);
        System.out.println(result);
    }

    public static void main(String[] args) {
        BankWaterService bankWaterCount = new BankWaterService();
        bankWaterCount.count();
    }
}
```
使用线程池创建4个线程，分别计算毎个sheet里的数据，毎个sheet计算结果是1,再由
BankWaterService线程汇总4个sheet计算出的结果，输出结果如下。

## CyclicBarrier和CountDownLatch的区别
CountDownLatch的计数器只能使用一次，而CyclicBarrier的计数器可以使用reset()方法重
置。所以CyclicBarrier能处理更为复杂的业务场景。例如，如果计算发生错误，可以重置计数
器，并让线程重新执行一次。
CyclicBarrier还提供其他有用的方法，比如getNumberWaiting方法可以获得Cyclic-Barrier
阻塞的线程数量。 isBroken()方法用来了解阻塞的线程是否被中断。代码清单8-5执行完之后会
返回true, 其中isBroken的使用代码如代码清单8-6所示。
代码清单8-6 CyclicBarrierTest3.java
```
public class CyclicBarrierTest3 {

    static CyclicBarrier c = new CyclicBarrier(2);

    public static void main(String[] args) throws InterruptedException, BrokenBarrierException {
        Thread thread = new Thread(new Runnable() {


            public void run() {
                try {
                    c.await();
                } catch (Exception e) {
                }
            }
        });
        thread.start();
        thread.interrupt();
        try {
            c.await();
        } catch (Exception e) {
            System.out.println(c.isBroken());
        }
    }
}

```
输出如下所示。
true
