# Python安装包或模块的多种方式汇总
windows下安装python第三方包、模块汇总如下(部分方式同样适用于其他平台)：

1. windows下最常见的*.exe,*msi文件，直接运行安装即可；

2. 安装easy_install,可以去官网下载：http://peak.telecommunity.com/dist/ez_setup.py，使用python 执行`ez_setup.py`文件，如：`python ez_setup.py`,此后会下载安装相应版本的easy_install.exe至python安装目录下的Scripts目录下.

3. easy_install.exe可安装*.egg格式的包,如：`easy_install *.egg`

4. 在3的基础上得到的easy_install.exe，安装pip，如：`easy_install pip`；可得到pip.exe和pip对应版本的exe文件；

5. 通过4得到的pip.exe可安装*whl格式的包；如： `pip install *.whl`

6. 一些第三方模块，gzip、tar、zip等解压后有setup.py文件，可以直接通过python安装,如：python2或python3 setup.py install

 

以下可以通过编写脚步安装所有需要的工具（easy_install，pip）， onekeyinstall.py：

    import os
    file_name = ‘ez_setup.py‘
    from urllib import urlopen
    data = urlopen(‘http://peak.telecommunity.com/dist/ez_setup.py‘)
    with open(file_name, ‘wb‘) as file:
        file.write(data.read() )
    os.system(‘python %s‘ % (os.path.join(os.getcwd(),file_name) ) )
    os.system('easy_install pip')

执行：`python onekeyinstall.py`  
注意：执行该脚步或是以上步骤需要预先设置好python路径至系统环境变量中，否则可能无法正确执行，此外通过网络下载ez_setup.py的文件通过python执行安装easy_install，并通过其再安装pip，新版本的python3
已自带pip工具，不需要再单独下载安装。

补充：  
　　Linux平台下还有apt-get，yum等安装工具安装；此外目前比较流行的是pip，安装pypi(即Python包索引网站的各个上传的包)，安装方法：pip2或pip3 install packagename；最后pip还可以有其他参数选项。比如下载的版本控制、下载多个包列表等。