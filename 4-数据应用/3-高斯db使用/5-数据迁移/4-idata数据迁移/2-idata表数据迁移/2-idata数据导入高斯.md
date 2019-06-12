# 大数据数据迁移

** 详细步骤参考 5-数据迁移 -> 2-数据迁移工具使用 -> 0-实际使用 **

## 从文件导入数据到高斯数据库

### 1、事先将上一步导出的文件拷贝到高斯所在机器

比如idata导出的数据文件在下面路径：
`H:\idata\gaussdba\dbdatas\dataMigration\C##GALAXY`

将 dataMigration 整个文件夹拷到服务器上，如：
`/data/gaussdba/dbdatas/input/dataMigration/C##GALAXY` 
cfg.ini里面的路径就写这个路径里 dataMigration 的上一层：
`/data/gaussdba/dbdatas/input` 

### 2、配置 cfg.ini

注意事项：
- **database_type 填 6； 对应于高斯100数据库**
- **import_db 里面 db 用户必须是 导入的表 对应的用户 如大数据 idata**
- **import_db 里面 server 用户必须是高斯数据库的安装用户 此处为gaussdba**
- **import_local_path 填的是 Gauss数据库安装机器的路径**

```
{
"flow_type":2,
"export_db":{
"database_type":2,
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
"username":"idata",
"password":"加密后的数据库密码，加密方法在 5-数据迁移 -> 数据迁移工具使用",
"port":1888
},
"server":{
"ip":"10.247.26.39",
"username":"gaussdba",
"password":"加密后的数据库密码，加密方法在 5-数据迁移 -> 数据迁移工具使用",
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
"import_local_path":"/data/gaussdba/dbdatas/input",
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

### 配置 exp_obj.ini

配置映射关系
这里写的是 oracle数据库用户 : 高斯数据库用户
```
C##GALAXY:IDATA
```

### 编辑 ddlResult 文件夹内容

在迁移软件jar包所在的目录里。 
此文件里记录了 导出时记录的表结构信息。 

如上面这样配置，导入程序会根据allDLL下面json文件决定导哪些表 
可以将json文件格式化成下面这样，方便选择。比如这里写了三个表，就导这三张表
```
{
"common_area":{"dbName":"na_data_uat","tableName":"common_area","columnInfo":{"id":{"colName":"id"}}},
"common_data":{"dbName":"na_data_uat","tableName":"common_area","columnInfo":{"id":{"colName":"id"}}},
"common_dict":{"dbName":"na_data_uat","tableName":"common_area","columnInfo":{"id":{"colName":"id"}}}
}
```

### 运行程序
```
java -jar DSS.jar -i G:\9-work\7-高斯数据库\高斯\高斯100\数据迁移工具\DataMigration\config\exp_obj.ini
```
