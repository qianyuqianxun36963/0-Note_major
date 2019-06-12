# HDFS操作总结文档
## 一、简介
  分布式系统(Distributed Systems)是指支持分布式处理的软件系统,是在由通信网络互联的多处理机体系结构上执行任务的系统。它包括分布式操作系统、分布式程序设计语言及其编译(解释)系统、分布式文件系统和分布式数据库系统等。分布式文件系统(DFS)是通过计算机网络将多个节点相连，进行物理存储管理的软件系统。

  Hadoop分布式文件系统(HDFS)是Apache Hadoop的核心组成部分，设计目标是为了把超大数据集存储到分布在网络中的多台普通商用计算机上。HDFS是一个高度容错性的系统，适合部署在廉价的机器上。HDFS能提供高吞吐量的数据访问，非常适合大规模数据集上的应用。
## 二、HDFS架构
  HDFS采用主/从架构，由一个NameNode和若干DataNode组成，其结构如下图所示：
![avatar](img/hdfs01.PNG)
  NameNode是统一的资源管理调度中心，管理文件系统中文件和目录的组织结构、访问操作以及客户端对文件的访问，它也负责确定数据块到具体DataNode节点的映射。DataNode是实际的物理存储节点，一般来说，通常设置一台服务器为一个节点。文件在DataNode节点上被分成一个或多个数据块，这些数据块存储在一组DataNode上。对于大型数据中心来说，节点的数量可能很多，因此，服务器需要被分放在不同的Rack上，Rack与Rack之间通过交换设备进行连接。关于HDFS的介绍，Hadoop官方文档写的非常详细，包括数据备份的策略，备份选择、硬件容错、元数据的持久化、数据的组织和访问，安全模式和权限等。建议操作之前，先阅读文档，了解原理架构。[(http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/HdfsDesign.html)](http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/HdfsDesign.html)

## 三、HDFS操作
 &esmp;HDFS操作命令主要通过hadoop安装目录下的/bin/hdfs命令执行，配置hadoop环境变量之后，我们可以直接执行命令：
``` bash
SZV1000096805:/opt/newbigdata/hadoop-2.9.0/bin # hdfs -help
```

命令行的基本执行格式为：
```bash
hdfs [SHELL_OPTIONS] COMMAND [GENERIC_OPTIONS] [COMMAND_OPTIONS]
```
| 命令 | 操作 |
|-----------|----------------|
| dfs | 执行文件系统操作的命令 |
| classpath | 输出所需要的jar和库文件路径 |
| namenode -format | 格式化文件系统 |
| secondarynamenode | 运行HDFS的secondarynamenode |
| namenode | 名称节点管理，进行备份，格式化，升级，回滚，恢复等等至关重要的操作 |
| journalnode | 做namenode高可用，使用该命令启动journalnode |
| zkfc | 该命令在启动Zookeeper高可用的时候使用 |
| datanode | 数据节点管理，用于启动数据节点和滚动升级中进行回滚 |
| debug | 执行调试命令,verifyMeta用于检验hdfs的元数据和块文件，computeMeta通过块文件计算元数据， recoverLease恢复特定路径的租约|
| dfsadmin | 文件系统管理 |
| dfsrouteradmin | 用于管理基于路由器的联合的命令 |
| haadmin | 高可靠管理 |
| fsck | 检查整个文件系统的健康状况 |
| balancer | 运行集群均衡,非常重要命令,由于各种原因，需要重新均衡数据节点。例如添加了新节点之后 |
| jmxget | 从服务中Dump JMX信息 |
| mover | 运行数据迁移。用于迁移压缩文件。类似于均衡器。定时均衡有关数据 |
| oiv | 离线映像编辑查看器 |
| oiv_legacy | 用于旧版本的Hadoop离线image文件查看器 |
| oev | 离线编辑查看器 |
| fetchdt | hdfs脚本支持fetchdt命令来获取DelegationToken（授权标识），并存储在本地文件系统的一个文件中。这样“非安全”的客户端可以使用该标识去访问受限的服务器（例如NameNode）。可以采用RPC或HTTPS(over Kerberos)方式获取该标示，在获取之前需要提交Kerberos凭证（运行kinit来获得凭证）。当你获得授权标识后，通过指定环境变量HADOOP_TOKEN_FILE_LOCATION为授权标识文件名，你就可以运行HDFS命令，而不需要Kerberros凭证了。 |
| getconf | 从配置文件目录获取配置信息 |
| groups | 获取用户的组信息 |
| snapshotDiff | 比较不同快照的差异 |
| lsSnapshottableDir | 获取快照表目录 |
| portmap | 和nfs服务器一起使用 |
| nfs3 | 启动一个nfs3网关，能够以类似操作系统文件浏览方式来浏览hdfs文件 |
| cacheadmin | 缓存管理 |
| storagepolicies | 压缩存储策略管理 |
| version | 查看版本信息 |

关于命令的详细信息，可在官网帮助文档中查询：[(http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/HDFSCommands.html#dfs)](http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/HDFSCommands.html#dfs)

使用命令hdfs dfs 进行文件操作：
### mkdir
```bash
#创建目录 /home
SZV1000096805:~ # hdfs dfs -mkdir /home

#创建目录 /temp/sub1/sub2 父目录不存在也创建
SZV1000096805:~ # hdfs dfs -mkdir -p /temp/sub1/sub2
````
### ls
```bash
# 查看hdfs根目录
SZV1000096805:~ # hdfs dfs -ls /
Found 1 items
drwxr-xr-x - root supergroup 0 2018-08-18 03:33 /home
```
### put 
```bash
# 将/opt/newbigdata/hadoop-2.9.0/README.txt文件put到hdfs的/home文件夹中
SZV1000096805:~ # hdfs dfs -put /opt/newbigdata/hadoop-2.9.0/README.txt /home
SZV1000096805:~ # hdfs dfs -ls /home
Found 1 items
-rw-r--r-- 1 root supergroup 1366 2018-08-18 03:38 /home/README.txt

# 如果文件存在，可以使用-f参数进行覆盖
hdfs dfs -put -f /opt/newbigdata/hadoop-2.9.0/README.txt /home
```
### get
```bash
# 将hdfs的/home/READMe.txt复制到本地
SZV1000096805:~ # hdfs dfs -get /home/README.txt /opt/newbigdata/
SZV1000096805:~ # cd /opt/newbigdata/
SZV1000096805:/opt/newbigdata # ls -l
total 20
-rw-r--r-- 1 root root 1366 Aug 18 11:44 README.txt
drwxr-xr-x 10 1000 1000 4096 Aug 16 19:00 hadoop-2.9.0
drwxr-xr-x 4 root root 4096 Aug 16 17:22 hdfs
drwxr-xr-x 62 root root 4096 Aug 16 20:11 software
drwxr-xr-x 4 root root 4096 Aug 16 16:25 test
SZV1000096805:/opt/newbigdata #
```
### copyFromLocal
```bash
#与put命令相似，只是限制源文件必须为本地文件
```
### copyToLocal
```bash
#与get命令相似，只是限制目标文件必须为本地文件
```

### touchz
```bash
#创建文件/home/test.txt , 如果文件存在且文件有内容会返回失败
SZV1000096805:~ # hdfs dfs -touchz /home/test.txt

#查看一下
SZV1000096805:~ # hdfs dfs -ls /home
Found 2 items
-rw-r--r-- 1 root supergroup 1366 2018-08-18 03:38 /home/README.txt
-rw-r--r-- 1 root supergroup 0 2018-08-18 05:55 /home/test.txt
SZV1000096805:~ #
```
### text
```bash
#把文件内容以文本格式输出
SZV1000096805:~ # hdfs dfs -text /home/README.txt
For the latest information about Hadoop, please visit our website at:

http://hadoop.apache.org/core/

and our wiki, at:

http://wiki.apache.org/hadoop/

This distribution includes cryptographic software. The country in
which you currently reside may have restrictions on the import,
possession, use, and/or re-export to another country, of 
.........
```
### appendToFile
```bash
**
//将本地文件系统的一个或多个文件追加到hdfs中
SZV1000096805:~ # hdfs dfs -appendToFile /opt/newbigdata/hadoop-2.9.0/LICENSE.txt /home/LICENSE.txt
SZV1000096805:~ # hdfs dfs -ls /home
Found 3 items
-rw-r--r-- 1 root supergroup 106210 2018-08-18 06:13 /home/LICENSE.txt
-rw-r--r-- 1 root supergroup 1366 2018-08-18 03:38 /home/README.txt
-rw-r--r-- 1 root supergroup 0 2018-08-18 05:55 /home/test.txt
SZV1000096805:~ #
**
```
### cat
```bash
#与linux命令一直
SZV1000096805:~ # hdfs dfs -cat /home/README.txt
```
### checksum
```bash
#返回文件checksum信息
SZV1000096805:~ # hdfs dfs -checksum /home/README.txt
/home/README.txt MD5-of-0MD5-of-512CRC32C 00000200000000000000000017970719be16d1071635fa381b95f957
```
### chgrp
```bash
#改变文件的group
SZV1000096805:~ # hdfs dfs -chgrp group1 /home/README.txt
SZV1000096805:~ # hdfs dfs -ls /home
Found 3 items
-rw-r--r-- 1 root supergroup 106210 2018-08-18 06:13 /home/LICENSE.txt
-rw-r--r-- 1 root group1 1366 2018-08-18 03:38 /home/README.txt
-rw-r--r-- 1 root supergroup 0 2018-08-18 05:55 /home/test.txt
SZV1000096805:~ #
```
### chmod
```bash
#改变文件的权限
SZV1000096805:~ # hdfs dfs -chmod 777 /home/README.txt
SZV1000096805:~ # hdfs dfs -ls /home
Found 3 items
-rw-r--r-- 1 root supergroup 106210 2018-08-18 06:13 /home/LICENSE.txt
-rwxrwxrwx 1 root group1 1366 2018-08-18 03:38 /home/README.txt
-rw-r--r-- 1 root supergroup 0 2018-08-18 05:55 /home/test.txt
SZV1000096805:~ #
```
### chown
```bash
#改变文件的ower
```
### count
```bash
#统计hdfs对应路径下的目录个数，文件个数，文件总计大小
SZV1000096805:~ # hdfs dfs -count -q -h /home/
#显示为目录个数，文件个数，文件总计大小，输入路径
none inf none inf 1 3 105.1 K /home
```
### cp
```bash
#复制文件
SZV1000096805:~ # hdfs dfs -cp /home/README.txt /temp/sub1/sub2
SZV1000096805:~ # hdfs dfs -ls /temp/sub1/sub2
Found 1 items
-rw-r--r-- 1 root supergroup 1366 2018-08-18 06:45 /temp/sub1/sub2/README.txt
```
### df
```bash
#显示剩余空间
SZV1000096805:~ # hdfs dfs -df /home
Filesystem Size Used Available Use%
hdfs://localhost:9000 317068410880 165225 285433483264 0%

```
### du
```bash
#显示目录下文件的大小和子目录
SZV1000096805:~ # hdfs dfs -du /home
106210 /home/LICENSE.txt
1366 /home/README.txt
0 /home/test.txt
SZV1000096805:~ #
```
### expunge
```bash
#清空回收站
```
### find
```bash
#查找文件或目录
SZV1000096805:~ # hdfs dfs -find / -name README.txt
/home/README.txt
/temp/sub1/sub2/README.txt
```

### getfacl
```bash
#查询文件的访问控制权限
SZV1000096805:~ # hdfs dfs -getfacl /home/README.txt
# file: /home/README.txt
# owner: root
# group: group1
user::rwx
group::rwx
other::rwx
```
### setfacl
```bash
#设置文件访问控制信息
```
### getfattr
```bash
#查询文件或目录扩展的属性值
SZV1000096805:~ # hdfs dfs -getfattr -d /home/README.txt
# file: /home/README.txt
```
### setfattr
```bash
#设置文件或目录扩展的属性值
```

### getmerge
```bash
#将多个文件合并到一个文件中
SZV1000096805:~ # hdfs dfs -getmerge /temp/sub1/sub2/README.txt /home/LICENSE.txt /opt/newbigdata/my.txt
SZV1000096805:~ # cat /opt/newbigdata/my.txt
For the latest information about Hadoop, please visit our website at:

http://hadoop.apache.org/core/

and our wiki, at:

http://wiki.apache.org/hadoop/
......
```
### moveFromLocal
```bash
//将本地文件导入hdfs中，然后删除本地源文件
SZV1000096805:~ # hdfs dfs -moveFromLocal /opt/newbigdata/my.txt /home
SZV1000096805:~ # hdfs dfs -ls /home
Found 4 items
-rw-r--r-- 1 root supergroup 106210 2018-08-18 06:13 /home/LICENSE.txt
-rwxrwxrwx 1 root group1 1366 2018-08-18 03:38 /home/README.txt
-rw-r--r-- 1 root supergroup 107576 2018-08-18 07:17 /home/my.txt
-rw-r--r-- 1 root supergroup 0 2018-08-18 05:55 /home/test.txt
```
### mv
```bash
#移动文件，把/home/my.txt移动到/temp目录下
SZV1000096805:~ # hdfs dfs -mv /home/my.txt /temp
```
### rm
```bash
#删除文件
SZV1000096805:~ # hdfs dfs -rm /temp/my.txt
Deleted /temp/my.txt

```
### rmdir
```bash
#删除非空目录
SZV1000096805:~ # hdfs dfs -rmdir /temp/sub1/sub2
```
### setrep
```bash
#设置文件的备份量
SZV1000096805:~ # hdfs dfs -setrep -w 2 /home/README.txt
Replication 2 set: /home/README.txt
```
### stat
```bash
#选择性查看文件或目录的信息
SZV1000096805:~ # hdfs dfs -stat "type:%F perm:%a %u:%g size:%b mtime:%y atime:%x name:%n" /home
type:directory perm:755 root:supergroup size:0 mtime:2018-08-18 07:18:35 atime:1970-01-01 00:00:00 name:home
```
### tail
```bash
#显示文件最后1kb的内容
SZV1000096805:~ # hdfs dfs -tail /home/README.txt
try, of
encryption software. BEFORE using any encryption software, please
check your country's laws, regulations and policies concerning the
import, possession, or use, and re-export of encryption software, to
see if this is permitted. See <http://www.wassenaar.org/> for more
information.

The U.S. Government Department of Commerce, Bureau of Industry and
Security (BIS), has classified this software as Export Commodity
Control Number (ECCN) 5D002.C.1, which includes information security
software using or performing cryptographic functions with asymmetric
algorithms. The form and manner of this Apache Software Foundation
distribution makes it eligible for export under the License Exception
ENC Technology Software Unrestricted (TSU) exception (see the BIS
Export Administration Regulations, Section 740.13) for both object
code and source code.

The following provides more details on the included cryptographic
software:
Hadoop Core uses the SSL libraries from the Jetty project written
by mortbay.org.

```
### truncate
```bash
#截断指定长度匹配的所有文件内容
SZV1000096805:~ # hdfs dfs -truncate -w 100 /home/README.txt
Waiting for /home/README.txt ...
Truncated /home/README.txt to length: 100
```
