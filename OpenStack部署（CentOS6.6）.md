# OpenStack部署
- 环境准备 
	- 首先需要准备3台linux的机器，配置IP地址，关闭防火墙，修改主机名

			• Controller Node: 1 processor, 2 GB memory, and 5 GB storage	192.168.44.147
			• Compute01: 1 processor, 512 MB memory, and 5 GB storage 		192.168.44.148
			• Compute02 Node: 1 processor, 2 GB memory, and 10 GB storage	192.168.44.149

### 基本环境配置
在controller机器上配置

- 数据库

		# 安装
		yum install mysql mysql-server MySQL-python
		# 配置
		编辑/etc/my.cnf文件，在里面添加如下内容，主要意思就是设置编码为utf-8
		default-storage-engine = innodb
		innodb_file_per_table
		collation-server = utf8_general_ci
		init-connect = 'SET NAMES utf8'
		character-set-server = utf8

		service mysqld start
		chkconfig mysqld on
		mysql_install_db
		mysql_secure_installation
		
		# 赋权，使其可以远程登录。
		GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'a';
- openstack基本包安装

		yum install yum-plugin-priorities
		yum install http://repos.fedorapeople.org/repos/openstack/openstackicehouse/rdo-release-icehouse-3.noarch.rpm

		yum install http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.
		noarch.rpm
		
		yum install openstack-utils
		
		yum install openstack-selinux
- 安装消息队列

		yum install qpid-cpp-server
		service qpidd start
		chkconfig qpidd on
### 权限认证服务(keystone)

		# 安装
		yum install openstack-keystone python-keystoneclient -y

		# 创建用户，写入到配置文件中
		openstack-config --set /etc/keystone/keystone.conf \
		database connection mysql://keystone:KEYSTONE_DBPASS@controller/keystone

		# 创建keystone数据库表
		$ mysql -u root -p
			mysql> CREATE DATABASE keystone;
			mysql> GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
			IDENTIFIED BY 'KEYSTONE_DBPASS';
			mysql> GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
			IDENTIFIED BY 'KEYSTONE_DBPASS';
			mysql> exit

		# 自动生成表
		su -s /bin/sh -c "keystone-manage db_sync" keystone

		# 设置用户环境变量
		ADMIN_TOKEN=$(openssl rand -hex 10)
		echo $ADMIN_TOKEN
		openstack-config --set /etc/keystone/keystone.conf DEFAULT \
		admin_token $ADMIN_TOKEN
		
		keystone-manage pki_setup --keystone-user keystone --keystone-group  keystone
		chown -R keystone:keystone /etc/keystone/ssl
		chmod -R o-rwx /etc/keystone/ssl

		# 启动keystone服务
		service openstack-keystone start
		chkconfig openstack-keystone on

		# 将admin_token设置到环境变量中去
		export OS_SERVICE_TOKEN=$ADMIN_TOKEN
		export OS_SERVICE_ENDPOINT=http://controller:35357/v2.0

		# 创建管理员用户
		keystone user-create --name=admin --pass=ADMIN_PASS --email=ADMIN_EMAIL
		keystone role-create --name=admin
		keystone tenant-create --name=admin --description="Admin Tenant"
		keystone user-role-add --user=admin --tenant=admin --role=admin
		keystone user-role-add --user=admin --role=_member_ --tenant=admin

		# 创建一个权限认证服务
		keystone service-create --name=keystone --type=identity \
		--description="OpenStack Identity"

		keystone endpoint-create \
		--service-id=$(keystone service-list | awk '/ identity / {print $2}') \
		--publicurl=http://controller:5000/v2.0 \
		--internalurl=http://controller:5000/v2.0 \
		--adminurl=http://controller:35357/v2.0

		keystone user-create --name=demo --pass=DEMO_PASS --email=DEMO_EMAIL
		keystone tenant-create --name=demo --description="Demo Tenant"
		keystone user-role-add --user=demo --role=_member_ --tenant=demo

				






















# 以Ubuntu12.04 为例部署最小化的 openstack 环境
### 部署基础服务
- 部署 RabbitMQ

		# 安装
		apt-get install rabbitmq-server 
		service rabbitmq-server start
		# 配置
		RabbitMQ 默认的管理员账户和密码是 guest/guest 。但可以通过下面的命令修改 guest 账户的密码
		rabbitmqctl change_password guest openstack 	# 修改密码为openstack
		# 验证
		rabbitmqctl status 			# 若有状态输出则表示 RabbitMQ 启动成功了。
- 部署 MySQL
		
		# 安装
		由于后面需要编译 python 对 mysql 的支持模块。这里需要一并安装 libmysql++-dev
		apt-get install mysql-server mysql-client libmysql++-dev 
		service mysql start 
		# 配置
		mysqladmin -u root password openstack 	# 配置管理员(root)的密码
		# 验证
		mysql -h localhost -u root -p -e 'select version();' 
- 安装虚拟化软件
		
		在安装 openstack 之前，还需要安装操作系统对虚拟化支持相关的服务
		apt-get install libvirt-bin libvirt-dev qemu-kvm 
### 部署OpenStack
- 即使是安装最小化的 openstack 需要启动的服务也是非常多的。
- 创建独立的 python 运行环境
		
		apt-get install virtualenv 
		virtualenv openstack-python 
		source openstack-python/bin/activate 
- 部署： keystone
	- keystone 为整个 openstack 系统 AAA (Authentication, Authorization, and Accounting) 服务。keystone 的作用有两个：
		- 提供用户登陆所需的密码验证
		- 通过 keystone 查询各个服务的 endpoint (访问地址)
	- 安装

			git clone https://github.com/openstack/keystone.git 
			cd keystone 
			git checkout stable/grizzly 
			pip install -r tools/pip-requires 
			pip install mysql-python 
	- 配置及初始化

			以源码包中的 keystone.conf.sample 为基础，稍作如下修改。并将修改后的文件保存成 keystone.conf 。
			[DEFAULT] 
			admin_token = openstack 
			debug = True 
			verbose = True 
			 
			[sql] 
			connection = mysql://root:openstack@localhost/keystone 
			 
			[signing] 
			token_format=UUID 
	- 为 keystone 初始化数据库

			mysql  -h localhost -u root -p -e 'create database keystone'; 
			bin/keystone-manage --config-dir etc/ db_sync
	- 启动服务

			bin/keystone-all --config-dir etc/ 
			keystone 服务会监听两个端口。其中 5000 端口用于和其他 openstack 组件和 keystone 的交互，被称作 public_port ;另一个端口 35357 用于对 keystone 本身进行管理，被称作 admin_port 。
			当 keystone-all 进程启动成功后，可以通过 netstat 检查 端口侦听是否正常。
	- 安装 keystone 客户端程序

			pip install python-keystoneclient 
### 创建管理员用户
- openstack 用户体系简介

		openstack 的用户管理是基于 keystone 。也就是说 keystone 的用户体系就是 openstack 的用户体系。
		在这个体系里，最基本的单位是 user/(用户)。 /user 在 openstack 里面可以代表一个实际的人，也可以代表一个程序或是服务，也就是所谓的系统用户。无论代表什么 user 是进行登录验证、资源分配的最小实体。
		user 对资源的访问通过两个维度来控制。第一个维度是 tenant 。 tenant 在 openstack 里面代表用户和资源的集合。一个 tenant 下面可以容纳多个 user ，而这些 user 只有可能访问这个 tenant 里面的资源(虚拟机、镜像、磁盘卷等等)。第二个维度是 role ，role 定义了承载了一组权利。一旦将 role 附加给了一个 user 这个 user 就具备了 role 所具备的权利。两个维度是逻辑与的关系，在一起共同决定 user 是否能访问一个资源。
		service 指的是 openstack 里承载具体功能的服务。例如：
		Compute (Nova)
		Object Storage (Swift)
		Image Service (Glance)
		etc …
		每一个 openstack 服务通常包含一个或多个 endpoint 。 endpoint 是一个网络上可访问的地址，通常是一个 URL 。这个 URL 指出了对应服务的 API 入口。
- 配置 openstack 环境变量

		openstack 所有其他服务的客户端都需要通过环境变量来获知认证服务(也就是 keystone )的位置以及用于认证的用户信息。为了方便使用，需要写一个包含这些环境变量的脚本 openstackrc 并通过 source 命令引入这些环境变量。

		#!/bin/sh 
		export OS_SERVICE_ENDPOINT="http://localhost:35357/v2.0"  # keystone 的管理地址，通常是 35357 端口
		export OS_SERVICE_TOKEN=openstack  # 验证密令
		 
		export OS_AUTH_URL="http://localhost:5000/v2.0/"  # 其他服务调用 keystone 的地址，通常是 5000 端口
		export OS_USERNAME=admin  # 普通用户调用 openstack 接口时用的用户名
		export OS_PASSWORD=admin  # 与上面 OS_USERNAME 配对使用的密码
		export OS_TENANT_NAME=admin  # 用户所要操作 Tenant 的名称
- 创建用户

		第一次使用 keystone 时还没有 tenant 和 role 存在。在执行上述过程之前还需要先通过 keystone tenant-create来创建一个 tenant ;
		通过 keystone role-create 来创建一个 role 。openstack 有一个默认的约定：名为 admin 的 role 具备管理权限。

	- 使用脚本创建用户

			./keystone-add-user.sh --tenant admin --role admin --name admin 

### 注册第一个服务：keystone
- 每一个 openstack 的服务都要向 keystone 注册自己的服务地址即 endpoint/。就连 /keystone 自身也不例外。这个注册的过程需通过 keystone 客户端来完成。

		pip install python-keystoneclient 
		source openstackrc 
		keystone service-create --name=keystone --type=identity --description="Identity Service" 
		export KEYSTONE_SERVICE_ID=$(keystone service-list | awk '/keystone/{print $2}') 
		keystone endpoint-create  
		 --region RegionOne  
		 --service-id=$KEYSTONE_SERVICE_ID  
		 --publicurl=http://localhost:5000/v2.0  
		 --internalurl=http://localhost:5000/v2.0  
		 --adminurl=http://localhost:35357/v2.0 

### 部署计算服务： nova
- 安装Nova

		git clone http://github.com/openstack/nova.git 
		cd nova 
		git checkout stable/grizzly 
		pip install -r tools/pip-requires 
- 配置及初始化
	-  nova 作为一个服务也需要创建一个与之对应的用户，

			./keystone-add-user.sh --tenant service --role admin --name nova 
	- 将用户的登录信息写入配置文件: etc/nova/api-paste.ini

			[filter:authtoken] 
			paste.filter_factory = keystoneclient.middleware.auth_token:filter_factory 
			auth_host = 127.0.0.1 
			auth_port = 35357 
			auth_protocol = http 
			admin_tenant_name = service 
			admin_user = nova 
			admin_password = nova 
			signing_dir = /tmp/keystone-signing 
	- 配置 nova 本身

			下面该配置 nova 本身了。以源码包中的 etc/nova/nova.conf.sample 为基础进行配置。将配置好的文件另存为 etc/nova/nova.conf
			[DEFAULT] 
 
			auth_strategy=keystone 
			 
			compute_driver = libvirt.LibvirtDriver 
			sql_connection=mysql://root:openstack@localhost/nova 
			debug=true 
			verbose=true 
			 
			rabbit_host=localhost 
			rabbit_port=5672 
			rabbit_hosts=$rabbit_host:$rabbit_port 
			rabbit_use_ssl=false 
			rabbit_userid=guest 
			rabbit_password=openstack 
			rabbit_virtual_host=/ 
			 
			rootwrap_config=etc/nova/rootwrap.conf 
	- 修改配置

			nova 中的很多操作需要 root 权限来执行。/nova/ 会使用 sudo 来执行这些操作。
			处于安全考虑 nova 使用被称为 rootwrap 的机制来控制哪些命令可以被 sudo 以 
			root 权限执行。具体的规则源码中的配置文件已经写好，这里只需要修改下规则文件存放
			的路径即可。请对比下列配置修改 etc/nova/rootwrap.conf 。
			[DEFAULT] 
			# List of directories to load filter definitions from (separated by ','). 
			# These directories MUST all be only writeable by root ! 
			filters_path=etc/nova/rootwrap.d,/usr/share/nova/rootwrap 
	- 初始化 nova 的数据库

			mysql -u root -p -e 'create database nova'; 
			bin/nova-manage --config-dir etc/ --config-file etc/nova/nova.conf db sync 
	- 注册 nova 服务

			keystone service-create --name nova --type compute --description 'OpenStack Compute Service' 
			export NOVA_SERVICE_ID=$(keystone service-list | awk '/nova/{print $2}') 
			keystone endpoint-create --region RegionOne --service-id $NOVA_SERVICE_ID --publicurl 'http://127.0.0.1:8774/v2/%(tenant_id)s' --adminurl 'http://127.0.0.1:8774/v2/%(tenant_id)s' --internalurl 'http://127.0.0.1:8774/v2/%(tenant_id)s'
	- 启动服务

			bin/nova-api --config-dir etc/ --config-file etc/nova/nova.conf 
			bin/nova-compute --config-dir etc/ --config-file etc/nova/nova.conf 
			bin/nova-conductor --config-dir etc/ --config-file etc/nova/nova.conf
### 部署 openstack 管理前端：horizon
- 安装

		git clone https://github.com/openstack/horizon 
		cd horizon 
		git checkout stable/grizzly 
		pip install -r tools/pip-requires 
- 配置及初始化
	- horizon 是一个基于 django 写成的前端程序，其配置方式遵循 django 习惯。 horizon 的配置文件位于其源码目录下的openstack_dashboard/local/local_settings.py 。该文件可以基于同目录下的 local_settings.py.example 进行配置。

			cd openstack_dashboard/local 
			cp -v local_settings.py{.example,} 
- 启动服务

		python ./manage.py runserver 0.0.0.0:8000 