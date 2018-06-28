# Python csv模块写入文件出现空行的解决办法：
	

	在用csv.writer写入文件的时候发现中间有多余的空行。
	最早打开方式只是‘w’，会出现多余的空行，网上建议使用binary形式‘wb’打开可以解决问题：
		with open('egg2.csv', 'wb') as cf:

	不过只能在python2下运行，python3报错：
		TypeError: a bytes-like object is required, not 'str'

	有人建议用encode(‘utf-8’)编码转变格式，但是觉得还是比较繁琐，因为list也不支持直接的编码。 
	再找了一圈，找到的最佳解释：
	
	python2.x中写入CSV时，CSV文件的创建必须加上'b'参数，即csv.writer(open('test.csv','wb'))，不然会出现隔行的现象。
	网上搜到的解释是：python正常写入文件的时候，每行的结束默认添加'\n'，即0x0D，而writerow命令的结束会再增加一个0x0D0A，
	因此对于windows系统来说，就是两行，而采用'b'参数，用二进制进行文件写入，系统默认是不添加0x0D的。
	
	而python3.x中换成采用newline=''这一参数来达到这一目的。

	这里python2和3的问题和解决方法都给出了。
	最后
	python3下的正确代码：
	
		with open('egg2.csv', 'w', newline='') as cf: