# Python中while循环使用总结：

		# 1
		import time
		def test_while():
		    while True:
		        print('Hello world!')
		        print(int(time.time()))
		        time.sleep(3)
		        return 10		# 此处的return返回会跳出循环
		
		a = test_while()		# 执行到此处，会睡眠3秒再执行
		print(a)
		print(int(time.time()))	

		执行结果：
			Hello world!
			1520583181		
			10
			1520583184
			
			Process finished with exit code 0


		# 2
		import time
		def test_while():
		    while True:
		        print('Hello world!')
		        print(int(time.time()))
		        time.sleep(3)
		        return			# 不带值或表达式的return语句，相当于返回None，此处会跳出循环
		
		a = test_while()
		print(a)
		print(int(time.time()))

		执行结果：
			Hello world!
			1520583272
			None
			1520583275
			
			Process finished with exit code 0