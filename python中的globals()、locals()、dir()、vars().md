python中的globals()、locals()、dir()、vars()、__dict__

- dir()
    1. dir()作用在实例上时，显示实例变量还有在实例变量所在类及所有它的基类中定义的方法和属性
    2. dir()作用在类上时，显示类及所有它的基类中__dict__的内容，不包括元类
    3. dir()作用在模块上时，显示模块的__dict__的内容
    4. dir()不带参数时显示调用者的局部变量，等价于locals()，但返回的不是字典
- vars()
    - 给定的对象必须参数必须有一个__dict__属性，作用在对象上时，返回__dict__字典中的内容，如果没有参数，等价于locals()
- locals()
    - 局部变量，只读
- globals()
    - 全局变量，非只读


## 
http://www.cnblogs.com/paranoia/p/6145387.html

在阅读模块源码里, 常常看到 globals() locals() 的使用, 这两个函数虽然可以从命名中

从外观上知道不同, 但仍然不明白具体使用方式和实际的意义. 带着好奇和疑问, 先看看

文档和搜索相关的博客, 额外还了解到vars() 函数的信息, 在此带着样例代码介绍.

首先参考官方文档对这三个函数的介绍:

2. Built-in Functions – Python3.5

globals()

返回当前全局符号表, 通常在是返回当前模块下的全局符号表, 比如全局内建的函数,

以及模块里的全局符号(定义声明的变量,类, 实例等), 在函数或者类方法中, globals()

返回的模块符号表是其所在模块, 而不是调用模块.

locals() 更新并以字典形式返回当前局部符号表. 自由变量由函数块的locals() 返回, 而

不会由 class 块来返回. 需要注意的是, locals() 字典不应该被修改; 在解释器中对修改行为

可能对 local 值或者自由变量无效.

vars() 返回 __dict__ 属性, 比如模块, 类, 实例, 或者其他 带有 __dict__ 属性的 object.

比如 模块和实例拥有可更新的 __dict__ 属性;然而其他 objects 可能会对 __dict__ 属性

的写操作限制(例如 类使用 dictproxy 阻止直接对字典更新).

vars() 如果不传参数, 那么作用与 locals() 一样. 需要注意的是, locals 字典只在读操作

时使用, 因为对 locals 的更新会被忽略.

翻译完相关文档解释后, 用代码实验:

    #!/usr/bin/env python
    # -*- coding: utf-8 -*-
    #
     
    HELLO = 1
     
    # GLOABLS 字典值包含 __builtins__, __doc__等通用的全局内建函数,模块,
    # 以及刚才定义的 HELLO
    GLOABLS = globals()  
     
    LOCALS = locals()  # 此时与 globals() 是等价的!!
     
    # globals 和 locals 此时是等价的, GLOBALS 和 LOCALS 其实是指向一个引用
    LOCALS['B'] = 1    
     
    # VARS 的引用与 GLOABLS LOCALS 一样, 可用 id() 来证实.
    VARS = vars()      
     
     
    class A(object):
        # 此时的 locals 是 class 块的 locals, 拥有 A_LOCALS A_GLOBALS 值
        A_LOCALS = locals()  
     
        # 与 GLOBALS 等价
        A_GLOBALS = globals() 
     
        def__init__(self):
            self.func_locals = None
            self.func_globals = None
     
        deffunc(self):
            self.func_locals = locals()
            self.func_globals = globals()  #  即 GLOBALS 值
     
    a = A()
    a.func() 
     
    a_vars = vars(a)  # 返回实例的 __dict__, 等价于 a_vars = a.__dict__
    A_DICT = vars(A)  # 返回类的 dictproxy, 不能对其key直接操作赋值.
    a_vars['func_vars'] = "vars"
    print(a.func_vars)  # "vars"
 
 
 
通过代码验证, 反过来理解文档的解释. 也明白了之前阅读他人代码使用的目的.

有另外一人写的文章 Python Does What?!? 介绍了 dict 和 vars 的使用.

文中引用一篇 推特吐槽 , 原文是:

Most folks prefer len(s) to s.__len__(), prefer next(it) to it.next(),but forget to use vars(s) rather than s.__dict__

只能说明 vars 这个函数的命名并不是那么直观, 而且已经有了 dict() 的定义, 也许设计者想出个 vars 命名来使用 233.

其他细节:

* 另外值得一提的是, 直接访问实例 __dict__ 或者其他属性, 比用内建函数访问更高效.

* 在模块里的全局作用域, 调试时会观察到 gloabls() (以及等价的 locals())里的 key

是动态变化的. 那么随着赋值给新变量名后, 字典会动态增加对应的 key.

 