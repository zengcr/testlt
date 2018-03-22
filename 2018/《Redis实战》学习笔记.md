# 一、《Redis实战》学习笔记

## 第1章 初识Redis
- Redis数据结构简介：
    - 字符串 STRING    # 注意：可以是字符串、整数或浮点数
    - 列表 LIST
    - 集合 SET
    - 散列 HASH
    - 有序集合 ZSET






# 二、Redis菜鸟教程
### 1. 安装
- Windows和Linux安装方式不一样
	- Windows安装方式参考菜鸟教程
	- Linux安装方式参考官网

- 连接到远程服务器

         $ redis-cli -h host -p port -a password

### 2. Redis命令
- Redis键

        DEL key
        DUMP key
        EXISTS key
        KEYS pattern
        MOVE key db
        PERSIST key
        RANDOMKEY
        TYPE key

        EXPIRE key seconeds
        EXPIREAT key timestamp
        PEXPIRE key milliseconds
        PEXPIREAT key milliseconds-timestamp

        PTTL key
        TTL key

        RENAME key newkey
        RENAMENX key newkey

- Redis字符串

        STRLEN key
        APPEND key value
        
        SET key value
        SETNX key value
        SETEX key seconds value
        PSETEX key milliseconds value
        GET key
        GETSET key value

        GETRANGE key start end
        SETRANGE key offset value

        GETBIT key offset
        SETBIT key offset value

        MGET key1 [key2...]
        MSET key value [key value ...]
        MSETNX key value [key value ...]

        INCR key
        INCRBY key increment
        INCRBYFLOAT key increment
        DECR key
        DECRBY key decrement

- Redis哈希

        HDEL key field1 [field2]
        HEXISTS key field
        HLEN key
        HSCAN key cursor [MATCH pattern] [COUNT count]

        HGET key field
        HGETALL key
        HMGET key field1 [field2 ...]
        HMSET key field1 value1 [field2 value2 ...]
        HSET key field value
        HSETNX key field value

        HINCRBY key field increment
        HINCRBYFLOAT key field increment

        HKEYS key
        KVALS key

- Redis列表

        BLPOP key1 [key2 ...] timeout
        BRPOP key1 [key2 ...] timeout
        BRPOPLPUSH source destination timeout

        LINDEX key index
        LINSERT key BEFORE|AFTER pivot value
        LLEN key

        LPOP key
        RPOP key
        LPUSH key value1 [value2]
        LPUSHX key value
        LRANGE key start stop
        LREM key count value
        LSET key index value
        LTRIM key start stop
        RPOPLPUSH source destination
        RPUSH key value1 [value2 ...]
        RPUSHX key value

- Redis发布订阅命令
		
		SUBSCRIBE channel [channel ...]
		UNSUBSCRIBE [channel [channel ...]]
		PUBLISH channel message
		
		PSUBSCRIBE pattern [pattern ...]
		PUNSUBSCRIBE [pattern [pattern ...]]

		PUBSUB subcommand [argument [argument ...]]

- Redis事务命令
	- 开始事务
	- 命令入队
	- 执行事务
	- 注意：单个 Redis 命令的执行是原子性的，但 Redis 没有在事务上增加任何维持原子性的机制，所以 Redis 事务的执行并不是原子性的。

			MULTI
			EXEC

			DISCARD
			UNWATCH
			WATCH key [key ...]

- Redis连接

		PING
		QUIT
		AUTH password
		SELECT index
		ECHO message

### 3. 高级教程
- Redis数据备份与恢复
	- SAVE 创建当前数据库的备份，在redis安装目录中创建dump.rdb文件
	- 恢复数据：只需将备份文件dump.rdb移到redis安装目录并启动服务即可
		- CONFIG GET dir 获取安装目录
	- BGSAVE 创建备份文件，该命令在后台执行

- Redis安全
	
		# 查看是否设置了密码
		CONFIG get requirepass
		# 设置密码
		CONFIG set requirepass 'password'	# 注意：设置密码后，客户端连接 redis 服务就需要密码验证，否则无法执行命令。接着需要执行AUTH password

- Redis性能测试

		redis-benchmark [option] [option value]

- Redis客户端连接

		# 获取最大连接数
		CONFIG get maxclients
		# 设置最大连接数
		CONFIG set maxclients 100000

- Redis管道技术
	- Redis 管道技术可以在服务端未响应时，客户端可以继续向服务端发送请求，并最终一次性读取所有服务端的响应。
			
		

