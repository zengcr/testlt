# Python3环境部署总结（CentOS7.4-Mini）
## 安装Python3.6
- 配置CentOS源	

		http://mirrors.ustc.edu.cn/help/centos.html
- 安装常用工具包


		yum install net-tools wget vim bash-completion gcc -y
- 安装python3.6可能使用的依赖

		yum install openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel -y
		yum -y  install  zlib*

- 准备工作

		# 创建安装目录
		$ sudo mkdir /usr/local/python3 
		# 下载 Python 源文件
		$ wget --no-check-certificate https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz -P /usr/local/src 下载文件放到指定目录/usr/local/src
		或者自己去官网下载上传至服务器/usr/local/src
		# 注意：wget获取https的时候要加上：--no-check-certificate
		# 解压缩包
		tar -zxvf Python-3.6.0.tgz 
		# 进入解压目录
		cd Python-3.6.0 

- 编译安装

		# 指定创建的目录
		$ sudo ./configure --prefix=/usr/local/python3 # 注意：要安装gcc编译器，不然会失败
		$ sudo make
		$ sudo make install

- 配置
	- 两个版本共存
	
			# 创建 python3 的软链接
			sudo ln -s /usr/local/python3/bin/python3 /usr/bin/python3
			# 这样就可以通过 python 命令使用 Python2，python3 来使用 Python3。
	- 修改默认为 Python3

- 安装pip
	- yum安装pip2
	
			# 首先安装 epel 扩展源
			$ sudo yum -y install epel-release
			# 安装 python-pip
			$ sudo yum -y install python-pip
			# 清除 cache
			$ sudo yum clean all
			# 通过这种方式貌似只能安装 pip2，想要安装 Python3的 pip，可以通过以下的源代码安装方式。
	- 源码安装pip3
			
			# 下载源代码
			$ wget --no-check-certificate https://github.com/pypa/pip/archive/9.0.1.tar.gz
			$ tar -zxvf 9.0.1 -C pip-9.0.1    # 解压文件
			$ cd pip-9.0.1
			# 使用 Python 3 安装
			$ python3 setup.py install
	- 创建软链接
	
			$ sudo ln -s /usr/local/python3/bin/pip /usr/bin/pip3
	- 升级
	
			# 升级pip3			
			$ pip3 install --upgrade pip
			# 升级pip			
			$ pip install --upgrade pip


## 安装Mariadb
- 如果是 CentOS 7 版本，由于 MySQL数据库已从默认的程序列表中移除，可以使用 mariadb 代替
- 配置MariaDB源 	
 
		http://mirrors.ustc.edu.cn/help/mariadb.html 
		注意：此页面中如下两条命令有错误，实际修改文件路径地址为/etc/yum.repos.d/mariadb.repo
		sudo sed -i 's#yum\.mariadb\.org#mirrors.ustc.edu.cn/mariadb/yum#' /etc/yum.repos.d/mariadb
		sudo sed -i 's#http://mirrors\.ustc\.edu\.cn#https://mirrors.ustc.edu.cn#g' /etc/yum.repos.d/mariadb
		正确命令为:
		sudo sed -i 's#yum\.mariadb\.org#mirrors.ustc.edu.cn/mariadb/yum#' /etc/yum.repos.d/mariadb.repo
		sudo sed -i 's#http://mirrors\.ustc\.edu\.cn#https://mirrors.ustc.edu.cn#g' /etc/yum.repos.d/mariadb.repo
		
		yum源配置完成后，执行以下命令
		yum clean all; yum makecache
- 安装mariadb数据库

		yum install -y mariadb-server mariadb-client

- 启动数据库及设置mariadb开机启动

		systemctl enable mariadb.service 
		systemctl restart mariadb.service
		systemctl status mariadb.service
- 配置mariadb，给mariadb设置密码
		
		mysql_secure_installation	# 通过此命令也可以更改数据库root的密码

- 创建新用户和数据库

		# 授权root用户远程登陆
		grant all privileges on *.* to 'root'@'%' identified by 'anyun100'; 
		# 创建新用户并设置密码
		create user metadata identified by 'anyun100';
		# 授权新用户权限
		grant all privileges on *.* to 'metadata'@'%' identified by 'anyun100'; 
		# 刷新mysql用户权限相关表
		flush privileges ;
		# 注意：新创建用户后要分配权限；如果授权后失败，检查防火墙的状态
		
		常用操作
		# 查看用户情况
		select Host,User,Password from mysql.user;
		# 删除用户
		use mysql;
		delete from user where User='test' and Host='localhost';
		


## 配置部署环境
- 创建用户及密码

		useradd metadata
		passwd anyun100
- 设置环境变量PYTHONPATH

		# 假定以root用户权限部署
		vi /root/.bash_profile
		# 在文件中新增以下内容
		PYTHONPATH=$PYTHONPATH:/home/metadata/metadataserver
		export PYTHONPATH
		# 不退出当前账户立即生效
		source /root/.bash_profile


## 其他操作
- 使用pstree

		yum install psmisc -y
		


