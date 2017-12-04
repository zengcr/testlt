# 《MySQL必知必会》学习笔记
- 数据对象 SCHEMA\ TABLE\ VIEW\ INDEX  
- 数据查询 SELECT  
- 数据定义 CREATE\ DROP\ ALTER  
- 数据操纵 INSERT\ DELETE\ UPDATA  
- 数据控制 GRANT\ REVOKE

### 第1章 数据库常用概念介绍

### 第2章 MySQL简介

### 第3章 使用MySQL
- 选择数据库

        USE databasename;
        SHOW DATABASES;
        SHOW TABLES;
        SHOW COLUMNS FROM tablename; # 显示表列
        DESCRIBE tablename;
        SHOW STATUS; # 显示服务器状态信息
        HELP SHOW；

### 第4章 检索数据
- 检索单个列
- 检索多个列
    - 一般在显示数据的应用程序中规定数据的显示格式
- 检索所有列 *
- 检索不同的行
    `DISTINCT` 应用于所有的列
- 限制结果
    `LIMIT`

        SELECT prod_name
        FROM products
        LIMIT 5;
        LIMIT 3, 4; LIMIT 4 OFFSET 3; 从第3行开始取4行

### 第5章 排序检索数据
    ORDER BY
    DESC # 降序 只应用到直接位于其前面的列名，如果想在多个列上进行降序排列，必须对每个列指定DESC关键字
- 利用`ORDER BY`和`LIMIT`的组合，能够找出一个列中最高或最低的值

### 第6章 过滤数据
    WHERE 
    IS NULL
- 在同时使用`ORDER BY`和`WHERE` 子句时，`ORDER BY`应位于`WHERE`子句之后

### 第7章 数据过滤
    AND OR IN NOT

### 第8章 用通配符进行过滤
- 在搜索子句中使用通配符，必须使用`LIKE`操作符
- `%` 任何字符出现任意次数，可以匹配0个字符，不能匹配`NULL`
- `_` #只匹配单个字符

### 第9章 用正则表达式进行搜索
    REGEXP

### 第10章 创建计算字段
- 拼接字段 `Concat()`
- `RTrim()`去掉值右边的所有空格，`LTrim()`去掉左边的空格，`Trim()`去掉左右两边的空格
- 使用别名 `AS`
- 执行算术运算

### 第11章 使用数据处理函数
- 文本处理函数 `Upper()、Soundex()`
- 日期和时间处理函数

### 第12章 汇总数据

### 第13章 分组数据
- `GROUP BY`
- `HAVING` 过滤分组，而`WHERE`只能过滤行

### 第14章 使用子查询



### 第18章 全文本搜索
- `MyISAM`支持全文本搜索，`InnoDB`不支持全文本搜索
- `FULLTEXT`
- `Match()`,`Against()`,传递给`Match()`的值必须与`FULLTEXT()`定义中的相同
- 使用查询扩展 `WITH QUERY EXPANSION()`
- 布尔文本搜索 `IN BOOLEAN MODE`

### 第19章 插入数据
- 插入完整的行 `INSERT INTO`，为了提高整体性能，可以添加关键字`LOW_PRIORITY`
- 插入多个行
- 插入检索出的数据 `INSERT SELECT`

### 第20章 更新和删除数据
- 更新数据 千万不能省略`WHERE`子句，为了删除某个列的值，可设置它为`NULL`
- 删除数据 千万不能省略`WHERE`子句
- 如果删除表中的所有行，可使用`TRUNCATE TABLE`语句

### 第21章 创建和操纵表
- 创建表 `CREATE TABLE`
- 