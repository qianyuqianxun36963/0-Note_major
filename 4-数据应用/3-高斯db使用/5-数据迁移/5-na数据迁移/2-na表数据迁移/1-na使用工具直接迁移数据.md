# na 通过工具直接导出&导入

### 配置 cfg.ini
从export_db数据库将数据导入到import_db数据库。
配置两个库类型及连接信息。

"flow_type":3 代码先导出再导入 
"database_type":3 代表mysql 
"database_type":6 代表gauss100 
"import_local_path"： 高斯数据库上的路径，用于放置导出的数据文件

[参数说明](http://rnd-isourceb.huawei.com/w00466247/Note_share/tree/master/3-%E9%AB%98%E6%96%AFdb%E4%BD%BF%E7%94%A8/5-%E6%95%B0%E6%8D%AE%E8%BF%81%E7%A7%BB/2-%E6%95%B0%E6%8D%AE%E8%BF%81%E7%A7%BB%E5%B7%A5%E5%85%B7%E4%BD%BF%E7%94%A8/1-%E5%B7%A5%E5%85%B7%E7%94%A8%E6%88%B7%E6%8C%87%E5%8D%97.md#cfg-ini-%E5%8F%82%E6%95%B0%E8%AF%B4%E6%98%8E)
```
{
"flow_type":3,
"export_db":{
"database_type":3,
"db":{
"ip":"127.0.0.1",
"username":"root",
"password":"q3UsQ/ux6eBW9xmU9b7mSA==",
"port":3306,
"db_name":"na_data_uat",
"server_name":""
}
},

"import_db":{
"database_type":6,
"db":{
"ip":"10.247.26.39",
"username":"naportal",
"password":"NRrR23MHADcKY8OFLCzGRA==",
"port":1888
},
"server":{
"ip":"10.247.26.39",
"username":"gaussdba",
"password":"Ddb/O+9tcexTpTWKoYWktw==",
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
"import_local_path":"/data/gaussdba/dbdatas/nainput",
"import_remote_path":{
"ip":"",
"username":"",
"password":"",
"port":22,
"path":""
}
},


"option":{

"column_separator":"~##~",
"row_separator":"@#\n#@",
"data_check_type":1,
"compression_before_translate":false,
"disable_foreign_key":true,
"check_ddl":true,
"delete_file":false,
"ignore_lost_table":2,
"disable_trigger":true,

"import_nologging":false,
"import_threads_per_obj":10,
"import_total_task":5,
"import_allow_max_errors":0,
"import_force":false,
"import_check_row_count":false,
"truncate_before_import_db_data":true,

"export_total_task":10,
"export_allow_max_errors":0,
"export_force":false,
"export_check_row_count":false,
"export_append_on":false,
"export_max_rownum":-1
}
}
```

### 配置exp_obj.ini
从mysql的na_data_uat库全量导入到高斯数据库的NAPORTAL用户下。
```
na_data_uat:NAPORTAL
```

### 字段不兼容处理

在第一次运行程序时，工具校验了mysql与高斯字段的兼容情况。

查看logs -> 日期文件夹 -> DDLReport.csv 文件。

提示类型下面这些不兼容字段：

|源表名|	目标表名|	源字段名|	目标字段名|	源类型|	目标类型
|--|:--:|:--:|:--:|:--:|--|
|scene_devinfo|SCENE_DEVINFO|sort_num|sort_num|int|NUMBER|
|scene_devinfo|SCENE_DEVINFO|if_intbound|if_intbound|tinyint|NUMBER|
|scene_devinfo|SCENE_DEVINFO|comment|comment|varchar|CLOB|


#### 编辑 TypeMappers 文件夹中映射关系

添加校验没过的类型对应：

- "TINYINT":["INTEGER", "BINARY_INTEGER", "BINARY_BIGINT", "BOOLEAN", **"NUMBER"**], 
- "INT":["INTEGER", "BINARY_INTEGER", "BINARY_BIGINT", **"NUMBER"**], 
- "VARCHAR":["VARCHAR", **"CLOB"**],
