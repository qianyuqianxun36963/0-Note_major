# 镜像测试数据库表导出-数据结构
## 安装navcat
使用navcat导出表结构 安装包可在共享[文件夹](https://onebox.huawei.com/p/e728cc24ab51e5387736c1c25e5cb1a8)下载:

安装软件名：Navicat+Premium_11.1.8.2简体中文版.zip

## 导出oracle格式建表语句

然后工具 -> 数据传输 -> 在右侧目标：选择文件、指定文件位置、sql格式选择oracle11g release1。

注意，这种方式导出来的数据是结构和数据都在文件里面的了。

## 仅导出表结构

右击数据库连接图标 -> 转储sql -> 仅结构

不过这里导出的结构是mysql格式的ddl语句。

将语句执行到一个临时库，再用前一个方法导出oracle格式的ddl语句。

## 表结构修改：

### 建表语句中，表名用大写

当建表语句小写时，建完表后，查询需要用 select * from "userName"."tableName"; 形式

表名改成大写就好了，建好后，可以不加用户名，直接这样： select * from tableName;

### 在建表语句添加表空间
```
DROP TABLE "sys_user_role";
CREATE TABLE "sys_user_role" (
"id" NVARCHAR2(32) NOT NULL ,
"create_by" NVARCHAR2(64) NOT NULL
)
tablespace naportal
;
```
添加 ** tablespace naportal **

### mysql中字段类型 nclob 修改

将全部的nclob字段类型改为clob
