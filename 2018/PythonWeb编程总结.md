# Python Web编程
### 1. WSGI协议
- 对应用程序的规定：
    1. 应用程序需要是一个可调用的对象
	    - 函数
	    - 实例，它的类实现了`__call__`方法
	    - 类
    2. 可调用对象接收两个参数：environ, start_response
    3. 可调用对象要返回一个值，这个值是可迭代的
- 对服务器程序的规定：
    1. 服务器程序需要调用应用程序
        - 把应用程序需要的两个参数设置好
        - 调用应用程序
        - 迭代访问应用程序的返回结果，并将其传回客户端


				# 应用程序详解
				1. environ是Python内置的dict对象，应用程序可以对这个参数任意修改
				2. environ必须包含WSGI需要的一些变量，也可以包含一些扩展参数
				3. start_response是一个可调用对象，接受两个位置参数，一个可选参数。例如start_response(status, response_headers, exc_info=None),status是状态码，response_headers是一个列表，形式为（header_name, header_value），exc_info参数在错误处理的时候使用

				# 服务器程序详解				
				## environ变量，以下变量必须包含
				1. request_method
				2. script_name
				3. path_info
				4. query_string
				5. content_type
				6. serve_name, server_port
				7. server_protocol

				## 服务器程序还必须提供以下WSGI相关的变量
				1. wsgi.version
				2. wsgi.url_scheme
				3. wsgi.input
				4. wsgi.errors
				5. wsgi.multithread
				6. wsgi.multiprocess
				7. wsgi.run_once



### Windows环境下安装uWSGI出错的解决方案：
[https://blog.csdn.net/PlusChang/article/details/78312134](https://blog.csdn.net/PlusChang/article/details/78312134 " window安装uwsgi 遇到AttributeError: 'module' object has no attribute 'uname' 完美解决")

	因为os.uname()方法在window不可用，导致错误。
	解决方案很简单：
	1.https://pypi.python.org/pypi/uWSGI/下载你想要的uwsgi 压缩文件
	2.在你需要用它的python文件的site-packages文件中解压缩
	3.找到uwsgiconfig.py配置文件
	4.使用任何一款python IDE打开它，在开头输入 import platform，然后启动替换（一般快捷为Ctrl+H）
	5.寻找 os.uname  替换为 platform.uname
	6.replaceall  注意搜索时不要加括号否则没反应（正则）