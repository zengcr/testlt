## Python知识点笔记
1. `#!/usr/bin/env python`与`#!/usr/bin/python`的区别  

    脚本语言的第一行，目的就是指出，你想要你的这个文件中的代码用什么可执行程序去运行它，就这么简单  
    `#!/usr/bin/Python`是告诉操作系统执行这个脚本的时候，调用`/usr/bin下`的python解释器；  
    `#!/usr/bin/env python`这种用法是为了防止操作系统用户没有将python装在默认的`/usr/bin`路径里。当系统看到这一行的时候，首先会到env设置里查找python的安装路径，再调用对应路径下的解释器程序完成操作。  
    `#!/usr/bin/python`相当于写死了python路径;  
    `#!/usr/bin/env python`会去环境设置寻找python目录,推荐这种写法

2. `__call__`的用法  
    可以在实例身上直接调用方法

3. `__name__`和`__main__`  
    在解释器中,`__name__`的值是`"__main__"`,而当模块作为模块导入的时候,`__name__`的值是模块的名字

4. `locals()`和`globals()` `vars()`

5. 内建模块 内置函数  
    在Python中，有一个内建模块，该模块中有一些常用函数;而该模块在Python启动后、且没有执行程序员所写的任何代码前，Python会首先加载该内建函数到内存。另外，该内建模块中的功能可以直接使用，不用在其前添加内建模块前缀，其原因是对函数、变量、类等标识符的查找是按LE(N)GB法则，其中B即代表内建模块。比如：内建模块中有一个abs()函数，其功能是计算一个数的绝对值，如abs(-20)将返回20。
    - python2 `__builtin__`
    - python3 `buitlins`

6. 查看内置模块的名字  
    - `sys.builtin_module_names`  
    ('_ast', '_bisect', '_blake2', '_codecs', '_codecs_cn', '_codecs_hk', '_codecs_i
    so2022', '_codecs_jp', '_codecs_kr', '_codecs_tw', '_collections', '_csv', '_dat
    etime', '_functools', '_heapq', '_imp', '_io', '_json', '_locale', '_lsprof', '_
    md5', '_multibytecodec', '_opcode', '_operator', '_pickle', '_random', '_sha1',
    '_sha256', '_sha3', '_sha512', '_signal', '_sre', '_stat', '_string', '_struct',
     '_symtable', '_thread', '_tracemalloc', '_warnings', '_weakref', '_winapi', 'ar
    ray', 'atexit', 'audioop', 'binascii', 'builtins', 'cmath', 'errno', 'faulthandl
    er', 'gc', 'itertools', 'marshal', 'math', 'mmap', 'msvcrt', 'nt', 'parser', 'sy
    s', 'time', 'winreg', 'xxsubtype', 'zipimport', 'zlib')

7. `__module__`

        首先python语言的基本组织单位是模块，不像Java是一类一文件，python的类、函数都在模
        块里面，当通过import引入一个函数以后，有时候由于函数签名的同名现象，需要看函数是
        从那个模块导入进来的，就需要看一下定义函数的的模块名称，这个时候，就使用一下语句来得这个模块名称：

        function_name.__module__
        不过需要提醒的是这个module名称不一定和import语句前面的from名称完全一致，os模块的
        open函数的__module__在windows下面是"nt",而django模块的get_version函数的__module__就是"django"