## Flask学习笔记

        Flask-Script
        Flask-Bootstrap
        Flask-Moment
        Flask-WTF
        Flask-SQLAlchemy
        Flask-Migrate
        Flask-Email
        Flask-Login

- 常用概念：
   - 程序上下文
   - 请求上下文
   - 蓝图
   - 工厂函数
   - 数据库迁移



## Python高级编程
- 上下文管理器
    - 上下文管理器类似于装饰器


# 源码学习疑问？
    class Local(object):
        __slots__ = ('__storage__', '__ident_func__')

    class LocalStack(object):
        def __init__(self):
            self._local = Local()

        def push(self, obj):
            rv = getattr(self._local, 'stack', None)
            if rv is None:
                self._local.stack = rv = []  ## self._local由Local()对象赋值获得，而类Local在定义的时候设定了__slot__属性，这个stack属性还能绑定对对象上吗？
            rv.append(obj)
            return rv
 
        def pop(self):
            stack = getattr(self._local, 'stack', None)
            if stack is None:
                return None
            elif len(stack) == 1:
                release_local(self._local)   ## 只栈中只有一个对象的时候，为什么要执行release_local()的操作？
                return stack[-1]
            else:
                return stack.pop()




## Python3面向对象编程

        >>> type(abs)
        <class 'builtin_function_or_method'>
        >>> type(foo)
        <class 'function'>
        >>> type(os)
        <class 'module'>
        >>> type(type)
        <class 'type'>