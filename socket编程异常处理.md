# socket编程异常处理

	一个健壮的程序应该有完善的对于异常中断的处理功能，那么在socket编程中常见的异常有哪些，该如何处理呢？
	我们知道socket通信的进行，无非就是绑定主机，端口，监听，接收连接，发送接收数据等等，这些行为如果出错，系统都会返回错误的，为了使得我们的程序有错误检查的功能，我们可以在程序内部加入异常处理，使程序运行到错误处就中断程序运行并打印出出错的地方和具体错误，使程序变得友好。
	Socket模块常见的异常有：
	Socket.error 与一般I/O和通信问题有关的
	Socket.gaierror 与查询地址有关的
	Socket.herror 与其他地址错误有关
	Socket.timeout 与一个socket上调用settimeout()后，超时处理有关
	
	举2个常见错误的例子：其中socket.error比较常见
	1 socket.error
	import socket
	try:
		s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
	except socket.error,e:
		print 'Strange error creating socket:%s' %e
	创建套接字，接收发送信息数据时候的异常一般由socket.error来处理 

	2 scoket.gaierror 错误
	>>> import socket
	>>> s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
	>>> s.connect(('wang',71625))
	
	Traceback (most recent call last):
	File "<pyshell#6>", line 1, in <module>
	s.connect(('wang',71625))
	File "<string>", line 1, in connect
	gaierror: (11001, 'getaddrinfo failed')
	这里我们尝试连接一个主机，但是返回了错误。但是不能连接错误代码数字会有不同，我们可以加入下面的代码。
	import socket,sys
	s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
	try:
		s.connect(('wang',71625))
	except socket.gaierror,e:
		print 'Error connecting to server: %s' % e
	结果为：
	>>>
	Error connecting to server: (11001, 'getaddrinfo failed')
	>>> 
	我们知道，服务器要力求稳定，所以如果一个服务器存在没有被捕获的异常，那么这个异常将会终止您的程序，这是非常不好的，特别是对于接受服务的客户端来说是不可以接受的，所以一个服务器端应该能试图捕获所有可能的错误，并以一种保证不会终止服务器的方法来处理这些错误，