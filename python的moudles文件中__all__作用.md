#

	Python的moudle是很重要的一个概念，我看到好多人写的moudle里都有一个__init__.py文件。有的__init__.py中是空白，有的却会有__all__参数。搜索了下总结下__all__参数的作用。
	
	如果其他页面import *的时候如果__init__.py是空白的，可以直接import到moudle的所有函数。而如果__init__.py中定义了__all__，则import *的时候只会导入__all__部分定义的内容。
	
	例如，我们可以这样组织一个package:
	
	package1/
	
	__init__.py
	
	subPack1/
	
	__init__.py
	
	module_11.py
	
	module_12.py
	
	module_13.py
	
	subPack2/
	
	__init__.py
	
	module_21.py
	
	module_22.py
	
	……
	
	__init__.py可以为空，只要它存在，就表明此目录应被作为一个package处理。当然，__init__.py中也可以设置相应的内容，下文详细介绍。
	
	好了，现在我们在module_11.py中定义一个函数：
	
	def funA():
	
	print "funcA in module_11"
	
	return
	
	在顶层目录（也就是package1所在的目录，当然也参考上面的介绍，将package1放在解释器能够搜索到的地方）运行python:
	
	>>>from package1.subPack1.module_11 import funcA
	
	>>>funcA()
	
	funcA in module_11
	
	这样，我们就按照package的层次关系，正确调用了module_11中的函数。
	
	细心的用户会发现，有时在import语句中会出现通配符*，导入某个module中的所有元素，这是怎么实现的呢？
	
	答案就在__init__.py中。我们在subPack1的__init__.py文件中写
	
	__all__ = ['module_13', 'module_12']
	
	然后进入python
	
	>>>from package1.subPack1 import *
	
	>>>module_11.funcA()
	
	Traceback (most recent call last):
	
	File "", line 1, in
	
	ImportError: No module named module_11
	
	也就是说，以*导入时，package内的module是受__init__.py限制的。
	
	好了，最后来看看，如何在package内部互相调用。
	
	如果希望调用同一个package中的module，则直接import即可。也就是说，在module_12.py中，可以直接使用
	
	import module_11
	
	如果不在同一个package中，例如我们希望在module_21.py中调用module_11.py中的FuncA，则应该这样：
	
	from module_11包名.module_11 import funcA