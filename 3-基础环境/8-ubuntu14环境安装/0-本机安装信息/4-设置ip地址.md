# 本机修改步骤总结：

## 虚拟机ip设置：

分布式相关 150-200

master:168  
slaveA:151 slaveB:152  
slaveC:153 slaveD:154   
slaveE:155 slaveF:156  

服务器配置 200-250  
 
client:211   
portal:212  
middle:213  
file:219   
serverA:201 serverB:202 

## 1.本机通过虚拟机查看的信息如下：

	thinkpadW541的网：

	本机上面IP信息如下：
	- 子网IP可用范围：192.168.175.128~192.168.175.254
	- 子网掩码：255.255.255.0
	- 网关: 192.168.175.2
	通过实体机cmd查看的信息如下：
	DNS 180.76.76.76

	thinkpadS5的网：

	本机上面IP信息如下：
	- 子网IP可用范围：192.168.221.128~192.168.221.254
	- 子网掩码：255.255.255.0
	- 网关: 192.168.221.2
	通过实体机cmd查看的信息如下：
	DNS 192.168.1.1

下面是西桥那边搭建过程：

## 2.Root登录

	sudo passwd root
	su root
	
## 3.设置IP

	vi /etc/network/interfaces
	修改内容如下，记得修改ip地址！本机的slave机器，ip结尾：151,152,153,154,155,156
	# interfaces(5) file used by ifup(8) and ifdown(8)
	auto lo
	iface lo inet loopback
	
	# The primary network interface
	auto eth0
	iface eth0 inet static
	address  192.168.175.***  151,152,153,154,155,156
	netmask 255.255.255.0
	gateway 192.168.175.2
	dns-nameservers 180.76.76.76    
	//这个地址，通过实体机的ipconfig/all查看。
	
	IP设置好以后，需要重启，其他机器才能ping通

## 4.修改DNS

	vi /etc/resolv.conf
	
	nameserver 180.76.76.76
	
## 5.配置持久化

	vi /etc/resolvconf/resolv.conf.d/base，如图：
	
	nameserver 180.76.76.76
	
## 6.完成后步骤

	修改完成需要执行2个命令如下：
	$resolvconf -u  (关于 resolvconf 服务更多信息，可以用man查看：man resolvconf )
	$/etc/init.d/networking restart

