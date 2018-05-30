# python的requests发送/上传多个文件
[https://blog.csdn.net/five3/article/details/74913742/](https://blog.csdn.net/five3/article/details/74913742/ "python的requests发送/上传多个文件")	

	1、需要的环境
	Python2.X
	Requests 库
	
	
	2、单字段发送单个文件
	在requests中发送文件的接口只有一种，那就是使用requests.post的files参数， 请求形式如下：
	[python] view plain copy
	url = "http://httpbin.org/post"  
	data = None  
	files = { ... }  
	r = requests.post(url, data, files=files)  
	
	而这个files参数是可以接受很多种形式的数据，最基本的2种形式为：
	字典类型
	元组列表类型
	
	2.1、字典类型的files参数
	官方推荐使用的字典参数格式如下：
	[python] view plain copy
	{  
	  "field1" : ("filename1", open("filePath1", "rb")),  
	  "field2" : ("filename2", open("filePath2", "rb"), "image/jpeg"),  
	  "field3" : ("filename3", open("filePath3", "rb"), "image/jpeg", {"refer" : "localhost"})  
	}   
	
	这个字典的key就是发送post请求时的字段名， 而字典的value则描述了准备发送的文件的信息；从上面可以看出value可以是2元组，3元组或4元组；
	这个元组的每一个字段代表的意思一次为：
	[python] view plain copy
	("filename", "fileobject", "content-type", "headers")  
	缺省的话则会使用默认值
	
	
	除了上面的使用形式，其实requests还是支持一个更简洁的参数形式，如下
	[python] view plain copy
	{  
	  "field1" : open("filePath1", "rb")),  
	  "field2" : open("filePath2", "rb")),  
	  "field3" : open("filePath3", "rb"))  
	}  
	
	这种形式的参数其等同效果如下, 其中filename是filepath的文件名：
	[python] view plain copy
	{  
	  "field1" : ("filename1", open("filePath1", "rb")),  
	  "field2" : ("filename2", open("filePath2", "rb")),  
	  "field3" : ("filename3", open("filePath3", "rb"))  
	}  
	
	当然，你还可以这样发送一个文件请求
	[python] view plain copy
	{  
	  "field1" : open("filePath1", "rb").read())  
	}  
	
	这里的filename的值为field1
	
	2.2、元组列表类型的files参数
	其实元组列表的形式与字典的形式基本一样，除了最外层的包装不一样；而在requests内部最终会把字典参数形式 转换 为 元组列的形式。官网推荐的用法如下：
	[python] view plain copy
	[  
	  ("field1" : ("filename1", open("filePath1", "rb"))),  
	  ["field2" : ("filename2", open("filePath2", "rb"), "image/jpeg")],  
	  ("field3" : ("filename3", open("filePath3", "rb"), "image/jpeg", {"refer" : "localhost"}))  
	]  
	
	
	列表里面的子项可以是元组，也可以是列表；同样这里也支持简介的形式，如下：
	[python] view plain copy
	[  
	  ("field1" : open("filePath1", "rb"))),  ##filename 使用的是filepath的文件名  
	  ("field2" : open("filePath2", "rb").read())) ##filename 使用的是键值，即 field2  
	]  
	3、单字段发送多个文件【即上传文件时，设置为多选了】
	3.1、字典参数形式
	[python] view plain copy
	{  
	  "field1" : [  
	                 ("filename1", open("filePath1", "rb")),   
	                 ("filename2", open("filePath2", "rb"), "image/png"),   
	                 open("filePath3", "rb"),  
	                 open("filePath4", "rb").read()  
	               ]  
	}  
	3.2、元组列表形式
	[python] view plain copy
	[  
	  ("field1" , ("filename1", open("filePath1", "rb"))),  
	  ("field1" , ("filename2", open("filePath2", "rb"), "image/png")),   
	  ("field1" , open("filePath3", "rb")),  
	  ("field1" , open("filePath4", "rb").read())  
	]  
	
	上面2种形式发送的请求，所有的文件都会在同一个字段下，后台服务只要从field1字段就可以获取全部的文件对象
	
	4、同时发送普通数据字段
	上面介绍的是使用发送文件内容请求，而有时候我们在发送文件的同时还需要发送普通的数据字段，此时普通数据字段直接存在data参数中即可，如下：
	[python] view plain copy
	data = {"k1" : "v1"}  
	files = {  
	  "field1" : open("1.png", "rb")  
	}  
	r = requests.post("http://httpbin.org/post", data, files=files)  