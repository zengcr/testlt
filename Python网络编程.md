# Python网络编程
- socket模块

        gethostbyname()     # 通过主机名获取ip地址
        getservbyname()     # 通过服务名查询服务的端口号，例如www 由80端口提供
        fileno()            # 查询操作系统维护的套接字标识，是一个整数
        getsockname()       # 获取套接字绑定的的IP地址及端口，是一个二元组
        settimeout()        # 
        getpeername()       # 得到套接字连接的服务器地址
        
        # UDP方法
        recvfrom()          # 返回两个值，一个是以字节表示的数据报内容，第二个是发送数据报的客户端地址
        sendto()            # 要提供两个参数：要发送的数据和目标地址


        # TCP方法
        recv()
        send()

- 需要异常处理的地方：
    - TCP客户端
        - connect
## 心跳包




#
        In [193]: udp_sock = socket(AF_INET, SOCK_DGRAM)

        In [194]: dir(udp_sock)
        Out[194]:
        ['_accept',
         '_check_sendfile_params',
         '_closed',
         '_decref_socketios',
         '_io_refs',
         '_real_close',
         '_sendfile_use_send',
         '_sendfile_use_sendfile',
         'accept',
         'bind',
         'close',
         'connect',
         'connect_ex',
         'detach',
         'dup',
         'family',
         'fileno',
         'get_inheritable',
         'getpeername',
         'getsockname',
         'getsockopt',
         'gettimeout',
         'ioctl',
         'listen',
         'makefile',
         'proto',
         'recv',
         'recv_into',
         'recvfrom',
         'recvfrom_into',
         'send',
         'sendall',
         'sendfile',
         'sendto',
         'set_inheritable',
         'setblocking',
         'setsockopt',
         'settimeout',
         'share',
         'shutdown',
         'timeout',
         'type']

        
         In [195]: tcp_sock = socket(AF_INET, SOCK_STREAM)

        In [196]: dir(tcp_sock)
        Out[196]:
        ['__class__',
         '__del__',
         '__delattr__',
         '__dir__',
         '__doc__',
         '__enter__',
         '__eq__',
         '__exit__',
         '__format__',
         '__ge__',
         '__getattribute__',
         '__getstate__',
         '__gt__',
         '__hash__',
         '__init__',
         '__init_subclass__',
         '__le__',
         '__lt__',
         '__module__',
         '__ne__',
         '__new__',
         '__reduce__',
         '__reduce_ex__',
         '__repr__',
         '__setattr__',
         '__sizeof__',
         '__slots__',
         '__str__',
         '__subclasshook__',
         '__weakref__',
         '_accept',
         '_check_sendfile_params',
         '_closed',
         '_decref_socketios',
         '_io_refs',
         '_real_close',
         '_sendfile_use_send',
         '_sendfile_use_sendfile',
         'accept',
         'bind',
         'close',
         'connect',
         'connect_ex',
         'detach',
         'dup',
         'family',
         'fileno',
         'get_inheritable',
         'getpeername',
         'getsockname',
         'getsockopt',
         'gettimeout',
         'ioctl',
         'listen',
         'makefile',
         'proto',
         'recv',
         'recv_into',
         'recvfrom',
         'recvfrom_into',
         'send',
         'sendall',
         'sendfile',
         'sendto',
         'set_inheritable',
         'setblocking',
         'setsockopt',
         'settimeout',
         'share',
         'shutdown',
         'timeout',
         'type']


### Python网络编程服务器与客户端的几种情况
1. 客户端请求一次成功后，服务器一直处于获取客户端的死循环中
2. 客户端请求一次，服务器端获取一次信息    
3. 单线程的客户端与服务器实现长连接（一直有数据进行通信）    

#### 查阅博客的一些结论（待验证）
- sokcet默认是阻塞的，recv()也是阻塞的，但是当客户端端开连接后，recv()变为非阻塞的，并返回空的字符串

[http://blog.csdn.net/bbg221/article/details/78464051#insertcode](http://blog.csdn.net/bbg221/article/details/78464051#insertcode "python socket.recv() 一直不停的返回空字符串，客户端怎么判断连接被断开？")
[http://blog.csdn.net/xhw88398569/article/details/47102187](http://blog.csdn.net/xhw88398569/article/details/47102187 "python recv在连接断开后会变为非阻塞")
[http://blog.csdn.net/huithe/article/details/5223785](http://blog.csdn.net/huithe/article/details/5223785 "关于 socket.recv 阻塞问题")
[http://blog.csdn.net/flying881114/article/details/4850666](http://blog.csdn.net/flying881114/article/details/4850666 "socket编程 recv()返回值处理")
[http://blog.csdn.net/qq_26399665/article/details/52422865](http://blog.csdn.net/qq_26399665/article/details/52422865 "Socket send函数和recv函数详解")

- 每个UDP socket都有一个接收缓冲区，没有发送缓冲区，从概念上来说就是只要有数据就发，不管对方是否可以正确接收，所以不缓冲，不需要发送缓冲区。


## 问题汇总：
1. selectors模块中`EVENT_READ` 和`EVENT_WRITE`的区别及使用场景？
	- 作为客户端，如何使用selectors模块？


			sock.setblocking(False)
			sel = selectors.DefaultSelector()
	        sel.register(listener, selectors.EVENT_READ, self.accept)	# 此处将listener注册至sel，是表示listener创建完成了就调用accept，还是其他的意思？
			sel.register(conn, selectors.EVENT_READ, self.read)	# 此处将conn注册至sel，是表示conn创建完成了就调用read,还是说内核检测到有数据了就调用read呢？

			网上文档描述：
			当用户进程调用了select，那么整个进程会被block，而同时，kernel会“监视”所有select负责的socket，当任何一个socket中的数据准备好了，select就会返回。这个时候用户进程再调用read操作，将数据从kernel拷贝到用户进程。


2. 多进程多线程的数据库读写解决方案？

3. 网络编程，作为客户端，在一个进程中发查询消息，在另外一个进程中启动线程接收返回消息，是接收不到返回消息的。如何解决这样的问题？
	- 目前最笨的解决方法：在每一个进程中都启动一个线程接收消息