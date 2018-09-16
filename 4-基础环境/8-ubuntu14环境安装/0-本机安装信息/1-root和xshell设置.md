# 设置root用户

Ubuntu刚安装后，不能在terminal中运行su命令，因为root没有默认密码，需要手动设定。

	以安装ubuntu时输入的用户名登陆，该用户在admin组中，有权限给root设定密码。

	给root用户设置密码的具体步骤：
	1. 打开一个terminal，然后输入下面的命令
	sudo passwd [root]

	回车后会出现让你输入原始密码，新密码和确认密码，
	[sudo] password for you ：---> 输入你的密码（你现在这个用户的密码），不回显  本机root密码即**root**！
	Enter new UNIX password: --- > 设置root 密码
	Retype new UNIX password: --> 重复这样
	这样你的root的密码设置好了。
	注：root可以省略，命令为passwd而不是password，我犯过这个错误。

	2. 在terminal中利用su命令就可以切换到root用户了。

	注：su和sudo的区别是：1). su的密码是root的密码，而sudo的密码是用户的密码；

	2). su直接将身份变成root，而sudo是以用户登录后以root的身份运行命令，不需要知道root密码；

修改用名： 

	虚拟机slaveB 在安装的时候，用户名设置成了 ubuntuslaveb 太长了。（在/home下查看用户名）

	
# xshell 登录虚拟机的设置

## 问题现象1：

使用用Xshell访问ubuntu服务器，无法连接

解决Xshell无法使用root远程登录Ubuntu16服务器

在ubuntu服务器安装ssh服务

更新源列表  
sudo apt-get update  

安装openssh-server  
sudo apt-get install openssh-server  

启动ssh服务  
sudo service ssh start


## 问题现象2：

解决Xshell无法使用root远程登录Ubuntu16服务器

xshell测试非root用户，可以正常连接，但是root用户仍旧无法访问

- 修改vi /etc/ssh/sshd_config文件

  把PermitRootLogin Prohibit-password 添加#注释掉

  新添加：PermitRootLogin yes


- 重启ssh服务/etc/init.d/ssh restart；

- 重新使用root连接，ok！

