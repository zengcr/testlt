# Python中的定时器总结

		# 1 （5秒后执行，只输出一次） 	/test_timer6.py
		import threading
		def print_timer():
		    print('Hello timer')
		
		timer = threading.Timer(5, print_timer)
		timer.start()

		# 2							/test_timer6.py
		import threading
		def print_timer():
		    print('Hello timer')
		    global timer
		    timer = threading.Timer(5, print_timer)
		    timer.start()

		timer = threading.Timer(5, print_timer)
		timer.start()

		# 3 类似于2					/test_timer7.py
		import threading
		def print_timer():
		    print('Hello timer')
		    timer = threading.Timer(5, print_timer)
		    timer.start()
		
		print_timer()

		# 4 类似于1					/test_timer8.py
		import threading
		import time
		def print_timer():
		    while True:
		        print('Hello timer')
		        time.sleep(5)
		
		t = threading.Thread(target=print_timer) 
		t.start()
		** 如果此时用定时器会是什么样的情况？ **
		timer = threading.Timer(0, print_timer)
		timer.start()

		# 5							/test_timer9.py
		import threading
		def print_timer():
		    print('Hello timer')
		
		while True:
		    timer = threading.Timer(5, print_timer) 在循环中启动定时器
		    timer.start()
		    timer.join()