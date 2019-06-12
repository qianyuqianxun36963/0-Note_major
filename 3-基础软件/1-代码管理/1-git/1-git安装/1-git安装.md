# git 安装

## 基础软件安装

首先安装命令行工具和git的小乌龟

## ssh配置

### 生成ssh公钥

首次使用的话，需要配置ssh

打开 git bash 窗口执行：`ssh-keygen -t rsa -C "wangyajun14@huawei.com"`

会生成相应的秘钥文件等，路径为如下位置：`C:\Users\currentUser\.ssh`

打开id_rsa.pub文件，并复制其内容。

### 复制ssh key到github：

On the GitHub site Click “Account Settings” > Click “SSH Keys” > Click “Add SSH key”

打开github网站，点击右上角扳手图标，然后点击左边菜单的 ssh key， 然后右边页面的 add ssh key，将复制的内容粘贴到github的key中，title可以不填，直接保存即可。
