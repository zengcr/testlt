# 《Redis实战》学习笔记

## 第1章 初识Redis
- Redis数据结构简介：
    - 字符串 STRING    # 注意：可以是字符串、整数或浮点数
    - 列表 LIST
    - 集合 SET
    - 散列 HASH
    - 有序集合 ZSET






# Redis菜鸟教程
### 安装
- Windows和Linux安装方式不一样
	- Windows安装方式参考菜鸟教程
	- Linux安装方式参考官网

- 连接到远程服务器

         $ redis-cli -h host -p port -a password

### Redis命令
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


