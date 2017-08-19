例子：
update students set sId = 4 where sId = 1;

	UPDATE [LOW_PRIORITY] [IGNORE] tbl_name
    SET col_name1=expr1 [, col_name2=expr2 ...]
    [WHERE where_definition]
    [ORDER BY ...]
    [LIMIT row_count]
Multiple-table语法：

UPDATE [LOW_PRIORITY] [IGNORE] table_references
    SET col_name1=expr1 [, col_name2=expr2 ...]
    [WHERE where_definition]
UPDATE语法可以用新值更新原有表行中的各列。SET子句指示要修改哪些列和要给予哪些值。WHERE子句指定应更新哪些行。如果没有WHERE子句，则更新所有的行。如果指定了ORDER BY子句，则按照被指定的顺序对行进行更新。LIMIT子句用于给定一个限值，限制可以被更新的行的数目。

UPDATE语句支持以下修饰符：

·         如果您使用LOW_PRIORITY关键词，则UPDATE的执行被延迟了，直到没有其它的客户端从表中读取为止。

·         如果您使用IGNORE关键词，则即使在更新过程中出现错误，更新语句也不会中断。如果出现了重复关键字冲突，则这些行不会被更新。如果列被更新后，新值会导致数据转化错误，则这些行被更新为最接近的合法的值。

如果您在一个表达式中通过tbl_name访问一列，则UPDATE使用列中的当前值。例如，以下语句把年龄列设置为比当前值多一：

mysql> UPDATE persondata SET age=age+1;
UPDATE赋值被从左到右评估。例如，以下语句对年龄列加倍，然后再进行增加：

mysql> UPDATE persondata SET age=age*2, age=age+1;
如果您把一列设置为其当前含有的值，则MySQL会注意到这一点，但不会更新。

如果您把被已定义为NOT NULL的列更新为NULL，则该列被设置到与列类型对应的默认值，并且累加警告数。对于数字类型，默认值为0；对于字符串类型，默认值为空字符串('')；对于日期和时间类型，默认值为“zero”值。

UPDATE会返回实际被改变的行的数目。Mysql_info() C API函数可以返回被匹配和被更新的行的数目，以及在UPDATE过程中产生的警告的数量。

您可以使用LIMIT row_count来限定UPDATE的范围。LIMIT子句是一个与行匹配的限定。只要发现可以满足WHERE子句的row_count行，则该语句中止，不论这些行是否被改变。

如果一个UPDATE语句包括一个ORDER BY子句，则按照由子句指定的顺序更新行。

您也可以执行包括多个表的UPDATE操作。table_references子句列出了在联合中包含的表。该语法在13.2.7.1节，“JOIN语法”中进行了说明。以下是一个例子：

UPDATE items,month SET items.price=month.price
WHERE items.id=month.id;
以上的例子显示出了使用逗号操作符的内部联合，但是multiple-table UPDATE语句可以使用在SELECT语句中允许的任何类型的联合，比如LEFT JOIN。

注释：您不能把ORDER BY或LIMIT与multiple-table UPDATE同时使用。

在一个被更改的multiple-table UPDATE中，有些列被引用。您只需要这些列的UPDATE权限。有些列被读取了，但是没被修改。您只需要这些列的SELECT权限。

如果您使用的multiple-table UPDATE语句中包含带有外键限制的InnoDB表，则MySQL优化符处理表的顺序可能与上下层级关系的顺序不同。在此情况下，语句无效并被 回滚。同时，更新一个单一表，并且依靠ON UPDATE功能。该功能由InnoDB提供，用于对其它表进行相应的修改。请参见15.2.6.4节，“FOREIGN KEY约束”。

目前，您不能在一个子查询中更新一个表，同时从同一个表中选择。

注意：
	在students表里面，主键是sId, 可以直接更新主键的值！！
	update students set sId = "001" where sId = "1";