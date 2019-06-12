# DSS

DSS 是华为使用的离线数据同步工具/平台，实现包括 Sybase，Oracle，MySQL、V1R3、V3R1、SQL Server 等各种异构数据源之间高效的数据同步功能。


# System Requirements

- [Huawei JDK](http://3ms.huawei.com/hi/index.php?app=Group&mod=Wiki&act=detail&id=5306267&gid=3712085)


# Quick Start

* 工具部署

* 方法一、直接下载DSS工具包：[DSS下载地址](http://siasvn07-rd:6801/svn/CRDU_Gauss_Maintenance_SVN/Gauss_Tools_TP/DOC/数据迁移/DSS版本包归档/DataMigration_V1.0.0)

下载后解压至本地某个目录，即可运行同步作业：
``` 
Usage: java [JVM] -jar DataSyncService.jar [options] filePath
JVM: Set jvm parameters if necessary,eg:-Xms1g -Xmx1g -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./log
Options:
-h, -help
Show this help message and exit
-pwd, -password
Enter the clear text password for encryption
-p <basic config file path>
Set basic config file path,use default if not specified
-i <export/import database or table config file path>
Set export database or table config file path,export all if not specified
-e <exclude database or table config file path>
Set exclude database or table config file path,exclude nothing if not specified
-l <log and report path>
Set export log and report path,use default path if not specified
-imp_b <import data failed path>
Set import data failed log file path,use default path if not specified
-exp_b <export data failed path>
Set export data failed log file path,use default path if not specified.
```
DSS包结构如下：

`conf	DSS.jar	TypeMappers	userGuid.md	log4j.properties	readme.txt`



* 配置示例：

* 第一步、创建作业的配置文件（json格式）


{
"flow_type":3,
"sync_type":1,
"export_db":{
"database_type":1,
"db":{
"ip":"",
"username":"",
"password":"",
"port":4100,
"server_name":"",
"owner":""
},
"server":{
"ip":"",
"username":"",
"password":"",
"port":22
}
},

"import_db":{
"database_type":6,
"db":{
"ip":"",
"username":"",
"password":"",
"port":1888,
"server_name":"",
"owner":""
},
"server":{
"ip":"",
"username":"",
"password":"",
"port":22
}
},

"data_path":{
"export_local_path":"",
"export_remote_path":{
"ip":"",
"username":"",
"password":"",
"port":22,
"path":""
},
"import_local_path":"",
"import_remote_path":{
"ip":"",
"username":"",
"password":"",
"port":22,
"path":""
}
},


"option":{
"column_separator":"~\\t",
"row_separator":"@#\n#@",
"date_format":"yyyymmddhh24miss",
"timestamp_format":"yyyymmddhh24missff6",
"nls_lang":"utf8",
"data_check_type":1,
"check_obj_exists":true,
"compression_before_translate":false,
"disable_foreign_key":true,
"truncate_after_export_db_data":false,
"check_ddl":false,
"delete_file":true,
"ignore_lost_table":false,
"disable_trigger":true,
"check_ssl_ca":true,

"import_nologging":true,
"import_threads_per_obj":10,
"import_total_task":5,
"import_allow_max_errors":0,
"import_force":false,
"import_check_row_count":false,
"truncate_before_import_db_data":true,

"export_threads_per_obj":1,
"export_total_task":10,
"export_allow_max_errors":0,
"export_force":false,
"export_check_row_count":false,
"export_enable_sort":false,
"export_max_rownum":-1
}
}


* 第二步：启动DSS

$ cd {YOUR_DSS_DIR}
$ java -jar DSS.jar 

同步结束，显示日志如下：
``` 
任务启动时刻 ： 2015-12-17 11:20:15
任务结束时刻 ： 2015-12-17 11:20:25
任务总计耗时 ： 100s
导出数据总量（行）：50000
导出失败行数（行）：0
导入数据总量（行）：50000
导入失败行数（行）：0
重建索引耗时： 200s
报告详情路径： /home/dss/log/report
```
