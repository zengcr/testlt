# Python中的异常总结：

		# 1
		def test_except():
		    try:
		        b = 10 / 2
		        print(b)
		        a = 10 / 0
		        print('我不会被执行')			# 由于异常发生，本条语句不会被执行
		    except ZeroDivisionError as e:
		        print('我捕捉到了异常')
		        print('具体的异常信息为：', e)
		        # return 5					# 注意：此行被注释了，不会执行
		    else:
		        print('我没有被执行！')
		        return 10
		
		a = test_except()		由于没有return语句执行，默认返回为None
		print(a)
		
		执行结果：
			5.0
			我捕捉到了异常
			具体的异常信息为： division by zero
			None
			
		# 2
		def test_except():
		    try:
		        b = 10 / 2
		        print(b)
		        a = 10 / 0
		        print('我不会被执行')
		    except ZeroDivisionError as e:
		        print('我捕捉到了异常')
		        print('具体的异常信息为：', e)
		        return 5				# 异常发生，执行这里的return				
		    else:
		        print('我没有被执行！')
		        return 10			
		
		a = test_except()
		print(a)

		执行结果：
			5.0
			我捕捉到了异常
			具体的异常信息为： division by zero
			5


		# 3
		def test_except():
		    try:
		        b = 10 / 2
		        print(b)
		        a = 10 / 0
		        print('我不会被执行')
		    except ZeroDivisionError as e:
		        print('我捕捉到了异常')
		        print('具体的异常信息为：', e)
		        return 5				# 异常发生，执行这里的return
		    else:
		        print('我没有被执行！')
		    return 10				# 注意：此处的缩进没有在else子句中

		执行结果：	# 与2一样
			5.0
			我捕捉到了异常
			具体的异常信息为： division by zero
			5

		# 4
		def test_except():
		    try:
		        b = 10 / 2
		        print(b)
		        a = 10 / 0
		        print('我不会被执行')
		    except ZeroDivisionError as e:
		        print('我捕捉到了异常')
		        print('具体的异常信息为：', e)
		        # return 5
		    else:
		        print('我没有被执行！')
		    return 10				# 执行这里的return
		
		a = test_except()
		print(a)

		执行结果：
			5.0
			我捕捉到了异常
			具体的异常信息为： division by zero
			10