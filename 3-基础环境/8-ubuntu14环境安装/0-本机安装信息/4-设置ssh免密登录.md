SSH设置

SSH安装

安装软件
SSH分客户端openssh-client和openssh-server
如果你只是想登陆别的机器的SSH只需要安装openssh-client（ubuntu有默认安装，如果没有则sudo apt-get install openssh-client），如果要使本机开放SSH服务就需要安装openssh-server
sudo apt-get install openssh-server
然后确认sshserver是否启动了：
ps -e |grep ssh
如果看到sshd那说明ssh-server已经启动了。
如果没有则可以这样启动：sudo /etc/init.d/ssh start

修改配置
ssh-server配置文件位于/ etc/ssh/sshd_config，在这里可以定义SSH的服务端口，默认端口是22，你可以自己定义成其他端口号，如222。
然后重启SSH服务：
sudo /etc/init.d/ssh stop
sudo /etc/init.d/ssh start

SSH登录
然后使用以下方式登陆SSH：
ssh tuns@192.168.0.100 tuns为192.168.0.100机器上的用户，需要输入密码。
断开连接：exit

SSH设置需要在集群上做不同的操作，如启动，停止，分布式守护shell操作。认证不同的Hadoop用户，需要一种用于Hadoop用户提供的公钥/私钥对，并用不同的用户共享。

下面的命令用于生成使用SSH键值对。复制公钥形成 id_rsa.pub 到authorized_keys 文件中，并提供拥有者具有authorized_keys文件的读写权限。

$ ssh-keygen -t rsa 
$ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys 
$ chmod 0600 ~/.ssh/authorized_keys 
设置SSH无密码登录
Hadoop集群中的各个机器间会相互地通过SSH访问，每次访问都输入密码是不现实的，所以要配置各个机器间的

SSH是无密码登录的。

1、 在master上生成公钥(这里以hadoop用户登录)

hadoop# ssh-keygen -t rsa
一路回车，都设置为默认值，然后再当前用户的Home目录下的.ssh目录中会生成公钥文件（id_rsa.pub）和私钥文件（id_rsa）。

2、 分发公钥

# ssh-copy-id hadoop@master
# ssh-copy-id hadoop@slaveA
# ssh-copy-id hadoop@slaveB
这里注意：ssh-copy-id 是将当前用户的公钥分发到指定机器上的指定用户。

例如在master机器上，当前用户执行ssh-copy-id hadoop@slaveA。

当前用户就能通过ssh hadoop@master用hadoop免密账号登录master。

3、 设置slaveA、slaveB到其他机器的无密钥登录

同样的在slaveA、slaveB上生成公钥和私钥后，将公钥分发到三台机器上。