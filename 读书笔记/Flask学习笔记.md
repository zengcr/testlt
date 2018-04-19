## Flask学习笔记

        Flask-Script
        Flask-Bootstrap
        Flask-Moment
        Flask-WTF
        Flask-SQLAlchemy
        Flask-Migrate
        Flask-Email
        Flask-Login
		Flask-Pagedown
		markdown
		bleach
		faker
		Flask-HTTPAuth
		Flask-Restful

		flask-openid
		sqlalchemy-migrate
		flask-whooshsqlalchemy
		guess-language
		flipflop
		coverage
		passlib

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



### 《Flask Web开发》学习笔记
- Flask支持在路由中使用int、float和path类型。path类型也是字符串，但不把斜线视作分隔符，而将其当作动态片段的一部分。
- 在app.run(debug=True)中传入参数debug，启用调试模式会带来一些便利，比如说激活调试器和重载程序。
- 在程序实例上调用app.app_context()可获得一个程序上下文
- 重定向，状态码302
- 默认情况下，Flask在程序文件夹中的templates子文件夹中寻找模板
- 默认设置下，Flask在程序根目录中名为static的子目录中寻找静态文件











### 常见问题：
1. flask 如何获取全部 GET 查询字符串参数？
[https://segmentfault.com/q/1010000000449384](https://segmentfault.com/q/1010000000449384 "flask 如何获取全部 GET 查询参数？")

		# 获取一条参数
		request.args.get('abc')
		# 获取所有参数
		request.args.items().__str__()












## Python3面向对象编程

        >>> type(abs)
        <class 'builtin_function_or_method'>
        >>> type(foo)
        <class 'function'>
        >>> type(os)
        <class 'module'>
        >>> type(type)
        <class 'type'>