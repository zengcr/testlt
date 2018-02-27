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