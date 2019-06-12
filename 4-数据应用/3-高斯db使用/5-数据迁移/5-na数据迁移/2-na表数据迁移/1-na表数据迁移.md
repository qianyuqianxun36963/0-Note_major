# na 表数据迁移

这个是一开始这样做的，建议用工具直接导。数据量不是很大的话，没必要区分处理。

## 小&简单表

可以直接用navcat导出oracle格式语句的方法导出。保存里面的insert语句即可。

## 处理特殊表

- 数据内容包含特殊字符等的表。 考虑使用工具转移。

## 数据内容包含特殊字符等的表

下面两张表内容格式较复杂。
```
scene_devinfo
scene_usecase_param_form
```
考虑通过导出工具进行处理：

## 通过工具导出数据到文件

### 配置 cfg.ini
```
{
"flow_type":1,
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
"database_type":2,
"db":{
"ip":"",
"username":"",
"password":"",
"port":1888
},
"server":{
"ip":"",
"username":"",
"password":"",
"port":22
}
},

"data_path":{
"export_local_path":"H:\\naportal\\gaussdba\\dbdatas",
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

"column_separator":"~##~",
"row_separator":"@#\n#@",
"data_check_type":1,
"compression_before_translate":false,
"disable_foreign_key":true,
"check_ddl":true,
"delete_file":true,
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

```
na_data_uat.scene_devinfo
na_data_uat.scene_usecase_param_form
```

### 保存 ddlResult 文件夹

在迁移软件的jar包所在目录，将ddlResult文件夹备份下。 
此文件里记录了 导出时记录的表结构信息。 
在下一步，进行数据导入时，会根据这个来导数据。

### 运行程序
```
java -jar DSS.jar -i G:\9-work\7-高斯数据库\高斯\高斯100\数据迁移工具\DataMigration\config\exp_obj.ini
```

## 通过工具导入数据到高斯库

### 1、事先将上一步导出的文件拷贝到高斯所在机器

比如idata导出的数据文件在下面路径：
`H:\naportal\gaussdba\dbdatas\dataMigration\naportal`

将 dataMigration 整个文件夹拷到服务器上，如：
`/data/gaussdba/dbdatas/nainput/dataMigration/naportal` 
cfg.ini里面的路径就写这个路径里 dataMigration 的上一层：
`/data/gaussdba/dbdatas/nainput` 

### 配置 cfg.ini

**注意，这里虽然是导入到gaussdb，不涉及原始的数据库类型。但其实还是要配置 export_db：database_type：3 指定数据文件来自于 mysql**

```
{
"flow_type":2,
"export_db":{
"database_type":3,
"db":{
"ip":"",
"username":"",
"password":"",
"port":1888,
"db_name":"",
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
```
na_data_uat:NAPORTAL
```
### 编辑ddlResult文件夹

在allDDL中，编辑对应的json文件，保留需要导入的两张表的数据。
{
"scene_usecase_param_form":{"dbName":"na_data_uat","tableName":"scene_usecase_param_form","columnInfo":{"id":{"colName":"id","colType":"varchar","colLength":32,"colLimitation":"NOT NULL"}}},
"scene_devinfo":{"dbName":"na_data_uat","tableName":"scene_devinfo","columnInfo":{"id":{"colName":"id","colType":"varchar","colLength":32,"colLimitation":"NOT NULL"}}}
}

### 运行程序
```
java -jar DSS.jar -i G:\9-work\7-高斯数据库\高斯\高斯100\数据迁移工具\DataMigration\config\exp_obj.ini
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

修改后再运行jar包。
