# java考试题集

## 判断题

一个子类可以重新定义从父类那里继承来的同名方法,但是允许它们返回值是父类返回值的类型或者其子类。
True	

Arrays.asList方法返回java.util.ArrayList对象。
False	


明确方法功能，精确（而不是近似）地实现方法设计。一个方法仅完成一件功能，即使简单功能也应该编写方法实现。
True	

在Java中，高优先级的可运行线程会抢占低优先级线程。
True	

JUnit工具，可以用测试套（suite）组织测试用例。
True

参数作为表名、字段名传递给mybatis配置的sql语句，需要进行校验。
True	

程序块要采用缩进风格编写，缩进的空格数为4个，允许使用TAB缩进。
False	

应该尽量直接捕获受检异常的基类Exception。
False	

HasMap可以将空值null作为key和value。
True

禁止调用System.dc()
True

## 单选题

不加编译参数，javac默认编译版本为 
debug版本
release版本
都有
正确答案：A

javaDoc里面注释格式为
```
/** */
// 
/** **/
```
正确答案：A

以下程序运行结果:( )
```
public class Dispatch
{
private static class A
{
}

private static class B
{
}

public static class Father
{
public void t(final A a)
{
System.out.println("Father:t(A a)");
}

public void t(final B a)
{
System.out.println("Father:t(B a)");
}
}

public static class Child extends Father
{
@Override
public void t(final A a)
{
System.out.println("Child:t(A a)");
}

@Override
public void t(final B a)
{
System.out.println("Child:t(B a)");
}
}

public static void main(final String[] args)
{
Father father = new Father();
Father child = new Child();

father.t(new B());
child.t(new A());
}
}
```
A. Father:t(B a) Child:t(A a)	
B. Father:t(B a) Father:t(A a)	
C. Child:t(B a) Father:t(A a)	
D. Child:t(B a) Child:t(A a)	
正确答案：A

如下代码的运行结果是：
```
public class TwoThread extends Thread
{
public void run()
{
for(int i=0;i<10;i++)
{
System.out.print(i);
}
}

public static void main(String[] args)
{
TwoThread tt=new TwoThread();
tt.run();

for(int i=0;i<10;i++)
{
System.out.print(i);
}
}
} 

```
A. 两个0~9的序列间插,运行结果可能不同	
B. 编译错误	
C. 01234567890123456789	
D. 00112233445566778899	

正确答案：C


如果试图编译、运行下面的类，会发生什么情况？
```
class Test 
{
public int a = 1;
public void run(int a)
{
int a;
System.out.println(a);
}
public static void main(String[] args ) 
{
Test t = new Test();
t.run(t.a);
}
}
```
A. 编译错误， 因为局部变量在初始化之前使用	
B. 运行结果输出为0	
C. 运行结果输出为1	
D. 编译错误， 因为局部变量不能和函数输入参数名称相同	
正确答案：D

以下代码输出什么？
```
public class Test1 
{
public static void changeStr(String str) 
{
str = "welcome";
}

public static void main(String[] args) 
{
String str = "1234";
changeStr(str);
System.out.println(str);
}
}
```
A. 编译错误	
B. welcome	
C. 运行是抛出异常	
D. 1234	
正确答案：D

在频繁操作下，查找字符串性能由快到慢排序正确的是：

A. indexOf 正则表达式工具 matches	
B. 正则表达式工具 indexOf matches	
C. matches indexOf 正则表达式工具	
D. indexOf matches 正则表达式工具	
正确答案：A

下列描述正确的是：

A. 上面说法都正确	
B. 一个接口可以继承多个接口	
C. 一个接口可以继承一个类，但是可以继承多个接口	
D. 一个Java类可以实现多个接口，或者继承多个类	
正确答案：B


以下哪一个是用于设置虚拟机的最大堆内存值?

A. -Dmx	
B. -Xmx	
C. -Xmax	
D. -Dmax

正确答案：B


下面关于I/O操作说法不正确的是：

A. 如果直接通过IO进行读写，不使用缓冲区的话，会导致严重的性能问题	
B. 基于字节的IO读写比基于字符的IO读写要慢很多，所以我们应尽量基于字符IO进行读写操作	
C. 使用NIO或IO批量读写，性能比较好	
D. 使用IO Buffer读写文件，性能比NIO、IO批量读写性能要差些	
正确答案：B

下列方法不是Collection通用方法的有：

A. remove()	
B. iterator()	
C. get()	
D. add()	
正确答案：C

如果你被要求写一段代码读取一个文本文件，那么一般使用哪种Stream？

A. ObjectInputStream	
B. FileReader	
C. DataInputStream	
D. FileInputStream	
正确答案：D

下列哪个场景可以使用java.util.Random类产生的随机数：

A. 挑战算法中的随机数生成	
B. Web应用会话标识符	
C. 验证码的随机数生成	
D. 随机选取路由	
正确答案：D

下列正则表达式中描述有误的是：

A. [] ：匹配范围内的任意一个字符	
B. \w：匹配任意字母、数字、下划线、符号	
C. \d：匹配0-9之间的任意数字	
D. {n}：匹配n次	
正确答案：B

在Java中下列关于自动类型转换说法正确的是：

A. double类型可以自动转换为int	
B. char类型和int类型相加结果一定是字符	
C. char + int + double + "" 结果一定是double	
D. 基本数据类型和String相加结果一定是字符串型	
正确答案：D

关于构造函数，下列说法正确的有：

A. constructor在一个对象被new时执行	
B. constructor必须与class同名，但方法不能与class同名	
C. class中的constructor不可省略	
D. 一个class只能定义一个constructor	
正确答案：A

关于枚举类型说法不正确的？

A. 枚举可以用于switch	
B. 枚举可以继承其他类	
C. 枚举可以自定义构造函数	
D. 枚举可以实现某个接口	
正确答案：B

过滤器使用（）才能继续传递到下一个过滤器。

A. doPut()	
B. doChain()	
C. doFilter()	
D. request.getRequestDispatcher().forward(request,response);	
正确答案：C 两一个是责任链里面的dochain。

以下对产品“接口”定义正确的是：

A. 一个类可以实现多个接口	
B. 接口的关键字为interface	
C. 接口是指修改后影响到该部件向前兼容或修改后对升级有影响的文件，“接口”包括配置文件、证书、DB表结构和软件接口等	
D. 接口是一系列方法的声明，是一些方法特征的集合，一个接口只有方法的特征没有方法的实现，因此这些方法可以在不同的地方被不同的类实现，而这些实现可以具有不同的行为	
正确答案：C

以下用来表示JVM内部异常的是：

A. Exception	
B. RuntimeException	
C. Throwable	
D. Error	
正确答案：D

如下程序运行结果( )
public static void main(final String[] args)
{
Integer a = 1;
Integer b = 2;
Integer c = 3;
Integer d = 3;
Integer e = 321;
Integer f = 321;
Long g = 3L;

System.out.print(c == d);
System.out.print(" ");
System.out.print(e == f);
System.out.print(" ");
System.out.print(c == (a + b));
System.out.print(" ");
System.out.print(c.equals(a + b));
System.out.print(" ");
System.out.print(g == (a + b));
System.out.print(" ");
System.out.print(g.equals(a + b));
}
分值

A. true false true true true true	
B. true false true true true false	
C. false false false true false true	
D. false false false false false false	
正确答案：B

下列程序输出结果为:
public class test {
public static void main(String args[]) {
int a=0;
outer: for(int i=0;i<2;i++) {
for(int j=0;j<2;j++) {
if(j>i) {
continue outer;
}
a++;
}
}
System.out.println(a);
}
}

A. 2	
B. 4	
C. 3	
D. 0	
正确答案：C


下列关于继承的说法哪个是正确的?

A. 子类只继承父类public方法和属性；	
B. 子类将继承父类的所有的属性和方法。	
C. 子类只继承父类的方法，而不继承父类的属性；	
D. 子类继承父类的非私有属性和方法；	
正确答案：B 

假设test类运行于多线程环境下，那么关于A处的同步下面描述正确的是：
public class Test {
List list= new java.util.ArrayList();
public void test() {
synchronized ( list) { //----A
list.add( String.valueOf(System.currentTimeMillis()));
}
}
}

A. 没有必要增加synchronized	
B. Test类为singleton时没有必要增加synchronized	
C. 必须增加synchronized	
D. Test类为singleton时有必要增加synchronized	
正确答案：C 

下列关于继承的说法哪个是正确的?

A. 子类只继承父类public方法和属性；	
B. 子类将继承父类的所有的属性和方法。	
C. 子类只继承父类的方法，而不继承父类的属性；	
D. 子类继承父类的非私有属性和方法；	
正确答案：B 

第31/45题单选题 尝试键盘方向键，切换上下题吧 
下面哪个是推荐使用的对称密码算法？

A. SHA	
B. RSA	
C. AES	
D. DES	
正确答案：C 

如下哪项是负责检查JVM加载的class文件的合法性：

A. ByteCode Verifier	
B. Classloader	
C. AccessController	
D. SecurityManager	
正确答案：A 

假设logger是Log4J的日志对象，logger.error(ia)正确的输出是：
try{
throw new IOException();
}
catch (IOException e)
{
IllegalArgumentException ia = new IllegalArgumentException(e);
logger.error(ia); 
}

A. java.lang.IllegalArgumentException: java.io.IOException	
B. "java.lang.IllegalArgumentException<br/> at Main.main(Main.java:101)"	
C. "java.lang.IllegalArgumentException: java.io.IOException<br/> at Main.main(Main.java:101)<br/>Caused by: java.io.IOException at Main.main(Main.java:97)"	
D. java.lang.IllegalArgumentException	
正确答案：A 


## 多选题

关于以下的代码片断，说法正确的有：
public class A
{
int a;

protected final int b = 1;
//...
}

A. b对于与A在同一个包的类是可见的	
B. a对于A的子类是可见的	
C. a对于与A在同一个包的类是可见的	
D. b对于A的子类是可见的	
正确答案：ACD

下面关于JUnit的测试用例实现，描述正确的是：

A. 测试用例必须实现setup(@Before)和tearDown（@After）方法。	
B. 测试方法可以通过throws声明异常	
C. 测试方法不能有返回值	
D. 用@Test标注的测试方法不能有参数	
E. 测试结果的Errors和Failures是有区别的，Failures一般指的是用例执行失败，如实际值不等于预期值，而Errors一般是指功能代码本身抛出了异常	
正确答案：BCDE

java中wait和sleep方法，以下说法正确的是：

A. 执行sleep方法不会释放锁	
B. 执行sleep方法会释放锁	
C. 执行wait方法不会释放锁	
D. 执行wait方法会释放锁	
正确答案：AD 可以理解为，wait时候，是清醒的，可以释放锁。

对REST标准操作描述正确的有：

A. 更新资源使用：POST	
B. 更新资源使用：PUT	
C. 所请求的URL不支持该请求操作，返回状态码405	
D. 获取资源使用：GET	
E. 删除资源使用：DELETE	
正确答案：BCDE 

在Java中，下面关于构造函数的描述错误的是：

A. 一个类可以定义多个构造函数	
B. 类不一定要显式定义构造函数	
C. 如果构造函数不带任何参数，那么构造函数的名称和类名可以不同	
D. 构造函数的返回类型是void	
正确答案：CD 构造函数不能带有返回类型

关于平台安全，如下说法正确的有：

A. 禁止特权块向非信任域泄漏敏感信息	
B. 避免完全依赖URLClassLoader和java.util.jar提供的默认自动签名认证机制	
C. 防止特权区域内出现非法的数据	
D. 禁止基于不信任的数据源做安全检查	
E. 编写自定义类加载器时应调用超类的getPermission()函数	
F. 使用安全管理器来保护敏感操作	
正确答案：ABCF

方法重载必须的条件为：

A. 参数不同	
B. 参数顺序不同	
C. 参数类型不同	
D. 返回值不同	
正确答案：AC

针对以下单例模式的实现代码，下列描述正确的是：
public class Singleton {
private static Singleton instance = null;

public Singleton() {
}

public static synchronized Singleton getInstance() {
if (instance == null) {
instance = new Singleton();
}
return instance;
}
}

A. 构造方法非private，不能达到单例的效果。	
B. 存在可靠性问题，并发调用时，可能导致getIntance获取的实例不是同一个。	
C. 存在性能问题，对getIntance加锁，导致的性能损耗。	
D. 标准的单例实现方法，没有问题。	
正确答案：AC

下列哪个方法可以作为public void add(int a){}的重载方法：

A. public int add(int a)	
B. public void add(float a)	
C. public void add(long a)	
D. public int add(long a)	
正确答案：BCD

以下关于JUnit注解，描述正确的是：

A. 注解@RunWith用于指定测试运行器，如：Parameterized、Suite	
B. 注解@Parameters用于声明一个返回值为Collection的公共静态方法，为参数化测试提供测试数据	
C. 注解@After用于标注每个用例执行后要执行的方法	
D. 注解@Before用于标注每个用例执行前要执行的方法	
正确答案：ABCD

Java平台沙箱安全模型包含以下哪几个安全组件：

A. 类加载器	
B. 类文件校验器	
C. 语法分析器	
D. 安全管理器	

正确答案：ABD

关于以下代码片段说法正确的是？
public class SyncTest
{
public static void main(String[] args)
{
final StringBuffer s1 = new StringBuffer();
final StringBuffer s2 = new StringBuffer();
new Thread()
{
public void run()
{
synchronized (s1)
{
s2.append(""A"");
synchronized (s2)
{
s2.append(""B"");
System.out.print(s1);
System.out.print(s2);
}
}
}

}.start();
new Thread()
{
public void run()
{
synchronized (s2)
{
s2.append(""C"");
synchronized (s1)
{
s1.append(""D"");
System.out.print(s2);
System.out.print(s1);
}
}
}
}.start();
}
}


A. 程序打印"ABABCD"。	
B. 因为可能存在死锁的条件，打印结果不确定。	
C. 打印结果依赖于运行程序的系统的线程模型。	
D. 程序打印"CDDCAB"。	
E. 程序打印"ADCBADBC"	
正确答案：AD

Hibernate采用xml文件来配置对象—关系映射有哪些好处？

A. 软件开发人员可以独立设计域模型，不必强迫遵守任何规范	
B. 数据库设计人员可以独立设计数据模型，不必强迫遵守任何规范	
C. Hibernate既不会渗透到上层域模型中，也不会渗透到下层数据模型中	
正确答案：ABC


关于indexOf(String str)方法查找字符串和matches(String regex)，以下说法正确的是：

A. 直接使用正则表达式工具类来实现匹配，可以支持正则表达式，在频繁操作下性能比matches(String regex)方法要好很多。	
B. matches(String regex)方法性能最差，但支持正则表达式，使用起来简单（该方法性能差的原因是每调用一次时，就重新对正则表达式编译了一次，新建了一个Pattern对象出来，而不是重复利用同一个Pattern对象）。	
C. indexOf(String str)方法运行速度最快，效率最高，但不支持正则表达式。	
D. 使用indexOf(String str)方法查找字符串，不要使用matches(String regex)方法	
正确答案：ABCD 

定义如下的二维数组b，下面的说法正确的是：
int b[][]={{1, 2, 3}, {4, 5},{6, 7, 8}};

A. 二维数组b的第一行有3个元素	
B. b[1].length的值是3	
C. b.length的值是3	
D. b[1][1]的值是5	
正确答案：ACD 


下列说法中错误的是：

A. 不要抑制或者忽略已检查异常	
B. 无需控制不受信任代码对System.exit()方法的调用	
C. 在解压zip文件时无需对zip文件中所包含的每个文件条目的大小做检查与限制	
D. 格式化字符串中可以包含用户输入	
正确答案：BCD 

下列说法中正确的是：
A. stringbuffer.append() 方法效率好于“ +”效率
B. 循环体内，使用stringbuffer.append() 方法效率好于“ +” 
C. String s = "a"+"b" 与StringBuffer s = new StringBuffer("a").append("b")效率一样。
正确答案：BC
