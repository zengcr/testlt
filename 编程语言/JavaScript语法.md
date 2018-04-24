# JavaScript语法
## 一、廖雪峰JavaScript教程
1. 比较运算符
    - 第一种是==比较，它会自动转换数据类型再比较，很多时候，会得到非常诡异的结果；  
    - 第二种是===比较，它不会自动转换数据类型，如果数据类型不一致，返回false，如果一致，再比较。  
     由于JavaScript这个设计缺陷，不要使用==比较，始终坚持使用===比较。

2. NaN这个特殊的Number与所有其他值都不相等
    - 唯一能判断NaN的方法是通过isNaN()函数

3. 变量
    - 变量名是大小写英文、数字、$和_的组合，且不能用数字开头
    - 同一个变量可以反复赋值，而且可以是不同类型的变量，但是要注意只能用var申明一次

4. strict模式
    - 使用var申明的变量则不是全局变量
    - 启用strict模式的方法
        - 'use strict';
        - **使用strict模式，还可以定义全局变量吗？**  答：在函数体外通过var定义的就是全局变量

5. false
    - JavaScript把null、undefined、0、NaN和空字符串''视为false，其他值一概视为true，因此上述代码条件判断的结果是true


## 二、疯狂JavaScript讲义
- 变量
	1. 定义变量的方式：
		- 隐式定义：直接给变量赋值
		- 显式定义：使用var关键字定义变量
	2. 变量作用域：
		- 全局变量：在全局范围定义的变量（不管是否使用var）；在函数内不使用var定义的变量
		- 局部变量：在函数内使用var定义
- 基本数据类型
	- 数值类型
		- Infinity、-Infinity
	- 字符串类型
	- 布尔类型：true、false
	- undefined
	- null
- 复合类型
	- Object：对象
	- Array：数组：元素可以为不同的类型
	- Function：函数
- 运算符
- 函数的实例属性和类属性：JavaScript中的实例对象不能访问类属性
	- 在函数中以this前缀修饰的变量
	- 在函数中以函数名前缀修饰的变量

## 三、菜鸟教程
- 输出方式
	- 使用windows.alert() 弹出警告框
	- 使用document.write()将内容写到HTML文档中
	- 使用innerHTML写入到HTML元素
	- 使用console.log()写入到浏览器的控制台


## 浏览器工作原理：
1. User Interface 用户界面，我们所看到的浏览器
2. Browser engine 浏览器引擎，用来查询和操作渲染引擎
3. Rendering engine 用来显示请求的内容，负责解析HTML、CSS
4. Networking 网络，负责发送网络请求
5. JavaScript Interpreter(解析者) JavaScript解析器，负责执行JavaScript的代码
6. UI Backend UI后端，用来绘制类似组合框和弹出窗口
7. Data Persistence(持久化) 数据持久化，数据存储 cookie、HTML5中的sessionStorage
![](https://i.imgur.com/JZoUwVt.png)
![](https://i.imgur.com/QJaCuHM.png)

## 内建方法

		isNaN()
		hasOwnProperty()