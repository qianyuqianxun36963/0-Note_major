# springboot 项目 与 docker

首先部署环境上，预定义的环境需要安装好。**jdk、maven、docker**

## 新建简单的springboot项目

这里我们使用maven新建基础项目：使用mvn脚手架。

`mvn archetype:generate -DgroupId=com.wang.ustc -DartifactId=SpringbootCMDgenerate -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false [-DarchetypeCatalog=local]  [-X] `

### 上面这条初始语句有几点需要注意：

- -X 是用来看输出的，第一次执行时很慢，就是通过它来定位错误

- -DarchetypeCatalog=local 是指定使用本地模板目录。本地模板目录为：**~/.M2/archetype-catalog.xml**
可以用迅雷下载之，路径：https://repo.maven.apache.org/maven2/archetype-catalog.xml

使用 Spring Boot 仅仅需要在pom文件中声明使用 Spring Boot，并添加 spring-boot-starter-web 的依赖即可

## 修改配置文件

### 添加spring boot 主配置

添加如下内容，使项目变成springboot项目

```
<parent>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-parent</artifactId>
  <version>2.0.0.RELEASE</version>
</parent>
```

### 添加依赖

因为我们搭建的是 Web 应用，必须添加 spring-boot-starter-web 依赖

spring-boot-starter-web 中包含了**tomcat**等的依赖！
```
<dependencies>
  <dependency>
     <groupId>org.springframework.boot</groupId>
     <artifactId>spring-boot-starter-web</artifactId>
  </dependency>
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
  </dependency>
</dependencies>
```

### 添加构建配置

如果不加下面这个配置，打包成功，但是运行时报错："**SpringbootCMDgenerate-1.0-SNAPSHOT.jar中没有主清单属性**"
```
<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
    </plugins>
</build>
```

### 另外还可以加的一些配置 非必须的

```
<properties>
  <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  <java.version>1.8</java.version>
</properties>
```

### 这样，我们就得到了最简单的springboot项目的pom文件，如下：

```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.wang.ustc</groupId>
  <artifactId>SpringbootCMDgenerate</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>SpringbootCMDgenerate</name>
  <url>http://maven.apache.org</url>

  <parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>2.0.0.RELEASE</version>
  </parent>

  <dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
  </dependencies>
  <build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
    </plugins>
  </build>

</project>

```

## 编写java类

**注意：这里，java文件放置的位置没有强制要求，实际尝试了下，主类和控制类可以放在src下任意位置，注释都能生效！**

在src/main 目录下 新建目录 java

然后根据包名依次创建com/wang/ustc/

### 启动类 SpringBootApp.java

```
package com.wang.ustc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SpringBootApp {
    public static void main(String[] args) {
        SpringApplication.run(SpringBootApp.class, args);
    }
}
```

#### 注意！ 其中的 @SpringBootApplication 注释

有些示例上面，这里写的是**SpringBootConfiguration** 但是此处不行。。

说明：@SpringBootApplication是Spring Boot的核心注解，也是一个组合注解。主要组合了@Configuration、@EnableAutoConfiguration、@ComponentScan。

如果不使用组合注解@SpringBootApplication则可以直接使用@Configuration、@EnableAutoConfiguration、@ComponentScan。

### 控制类 TestController.java

```
package com.wang.ustc;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {
    @RequestMapping("test")
    public String test(){
        return "test";
    }
}
```

## 启动并验证项目

### 打包 运行 项目

在pom所在文件夹，shift + 右击，打开命令行

mvn package

cd target

java -jar SpringbootCMDgenerate-1.0-SNAPSHOT.jar

### 验证项目

现在可以在浏览器输入[http://localhost:8080/test](http://localhost:8080/test)访问项目。

## springboot项目部署到docker

Spring Boot 项目添加 Docker 支持

### 添加 Docker 镜像名称
在 pom.xml-properties中添加 Docker 镜像名称
```
<properties>
    <docker.image.prefix>springboot</docker.image.prefix>
</properties>
```
### 添加 Docker 构建插件
plugins 中添加 Docker 构建插件：
```
<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
        <!-- Docker maven plugin -->
        <plugin>
            <groupId>com.spotify</groupId>
            <artifactId>docker-maven-plugin</artifactId>
            <version>1.0.0</version>
            <configuration>
                <imageName>${docker.image.prefix}/${project.artifactId}</imageName>
                <dockerDirectory>src/main/docker</dockerDirectory>
                <resources>
                    <resource>
                        <targetPath>/</targetPath>
                        <directory>${project.build.directory}</directory>
                        <include>${project.build.finalName}.jar</include>
                    </resource>
                </resources>
            </configuration>
        </plugin>
        <!-- Docker maven plugin -->
    </plugins>
</build>
```
### 创建 Dockerfile 文件
在目录src/main/docker下创建 Dockerfile 文件，Dockerfile 文件用来说明如何来构建镜像。
```
FROM openjdk:8-jdk-alpine
VOLUME /tmp
ADD spring-boot-docker-1.0.jar app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
```
这个 Dockerfile 文件很简单，构建 Jdk 基础环境，添加 Spring Boot Jar 到镜像中，简单解释一下:

- FROM ，表示使用 Jdk8 环境 为基础镜像，如果镜像不是本地的会从 DockerHub 进行下载
- VOLUME ，VOLUME 指向了一个/tmp的目录，由于 Spring Boot 使用内置的Tomcat容器，Tomcat 默认使用/tmp作为工作目录。这个命令的效果是：在宿主机的/var/lib/docker目录下创建一个临时文件并把它链接到容器中的/tmp目录
- ADD ，拷贝文件并且重命名，**记得将jar包名替换成你自己的**。
- ENTRYPOINT ，为了缩短 Tomcat 的启动时间，添加java.security.egd的系统属性指向/dev/urandom作为 ENTRYPOINT

这样 Spring Boot 项目添加 Docker 依赖就完成了。

## Docker 部署 Spring Boot 项目
将项目 spring-boot-docker 拷贝服务器中，进入项目路径下进行打包测试。

### 验证springboot项目可用

#### 打包
`mvn package`
#### 启动
`java -jar target/spring-boot-docker-1.0.jar`
看到 Spring Boot 的启动日志后表明环境配置没有问题，接下来我们使用 DockerFile 构建镜像。
#### 访问
访问地址：http://192.168.146.168:8080/test

### 开始docker构建

`mvn package docker:build`

实际使用的是下面这个：
`/all/maven/apache-maven-3.3.9/bin/mvn package  -Dmaven.test.skip=true docker:build`

#### 修改docker配置提快docker:build速度

1、修改配置文件

`vi /usr/lib/systemd/system/docker.service`

2、配置文件在ExecStart后添加 --registry-mirror=https://navyf335.mirror.aliyuncs.com

`ExecStart ... --registry-mirror=https://navyf335.mirror.aliyuncs.com`


第一次构建可能有点慢，当看到以下内容的时候表明构建成功：
```
...
Step 1 : FROM openjdk:8-jdk-alpine
 ---> 224765a6bdbe
Step 2 : VOLUME /tmp
 ---> Using cache
 ---> b4e86cc8654e
Step 3 : ADD spring-boot-docker-1.0.jar app.jar
 ---> a20fe75963ab
Removing intermediate container 593ee5e1ea51
Step 4 : ENTRYPOINT java -Djava.security.egd=file:/dev/./urandom -jar /app.jar
 ---> Running in 85d558a10cd4
 ---> 7102f08b5e95
Removing intermediate container 85d558a10cd4
Successfully built 7102f08b5e95
[INFO] Built springboot/spring-boot-docker
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 54.346 s
[INFO] Finished at: 2018-03-13T16:20:15+08:00
[INFO] Final Memory: 42M/182M
[INFO] ------------------------------------------------------------------------
```
使用docker images命令查看构建好的镜像：

docker images
|REPOSITORY                      |TAG                 |IMAGE ID            |CREATED             |SIZE|
|:-|:-|:-|:-|:-|
|springboot/spring-boot-docker   |latest              |99ce9468da74        |6 seconds ago       |117.5 MB|

springboot/spring-boot-docker 就是我们构建好的镜像，下一步就是运行该镜像

### 运行镜像
`docker run -p 8080:8080 -t springboot/spring-boot-docker`

启动完成之后我们使用docker ps查看正在运行的镜像：

docker ps
|CONTAINER ID        |IMAGE                           |COMMAND                  |CREATED             |STATUS              |PORTS                    |NAMES|
|:-|:-|:-|:-|:-|:-|:-|
|049570da86a9        |springboot/spring-boot-docker   |"java -Djava.security"   |30 seconds ago      |Up 27 seconds       |0.0.0.0:8080->8080/tcp   |determined_mahavira|
可以看到我们构建的容器正在在运行，访问浏览器：http://192.168.0.x:8080
`Hello Docker!`
说明使用 Docker 部署 Spring Boot 项目成功！
