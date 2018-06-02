## Docker
### 基础知识
- Docker三剑客：Machine、Compose、Swarm
- 容器化应用集群平台：Kubernetes、Mesos、CoreOS
- Docker仓库和仓库注册服务器
    - 仓库注册服务器是存放仓库的地方，仓库里存放着镜像
- 国内仓库的本地源配置方法：？
- Docker只能运行在64位平台上
- 配置Docker服务
    - Docker在安装过程中会自动创建docker用户组
        - `sudo usermod -aG docker USER_NAME`
    - 默认配置文件：`/etc/default/docker`
    - 重启Docker服务：`sudo service docker restart`
    - 管理脚本：`/etc/init.d/docker`

- 阿里云容器镜像服务
    - docker登录时使用的用户名为阿里云账户全名，密码即为现在您设置的密码

            1. $ sudo docker login --username=litiandlut@gmail.com registry.cn-shenzhen.aliyuncs.com
            2. $ sudo docker pull registry.cn-shenzhen.aliyuncs.com/bigrabbit/ubuntu:[镜像版本号]
            3. $ sudo docker login --username=litiandlut@gmail.com registry.cn-shenzhen.aliyuncs.com
               $ sudo docker tag [ImageId] registry.cn-shenzhen.aliyuncs.com/bigrabbit/ubuntu:[镜像版本号]
               $ sudo docker push registry.cn-shenzhen.aliyuncs.com/bigrabbit/ubuntu:[镜像版本号]

### Docker镜像
- 默认使用Docker Hub公共注册服务器中的仓库，可以通过配置使用自定义的镜像仓库

        格式:docker pull NAME[:TAG]
        1. docker pull ubuntu:14.04
        2. docker pull registry.hub.docker.com/ubuntu:14.04
        3. docker pull hub.c.163.com/public/ubuntu:14.04

- 查看镜像信息

        1. docker images                                # 列出镜像
        2. docker tag ubuntu:latest myubuntu:latest     # 添加镜像标签
        3. docker inspect ubuntu:14.04                  # 查看详细信息
        4. docker history ubuntu:14.04                  # 查看镜像历史

- 搜寻镜像

        1. docker search --automated -s 3 nginx

- 删除镜像
    - 当同一个镜像拥有多个标签时，只是删除指定的标签
    - 当镜像只有一个标签时，会彻底删除镜像
    - 当镜像创建的容器存在时，镜像文件默认是无法删除的

            1. docker rmi myubuntu:latest
            2. docker ps -a             # 查看本机上存在的所有容器

- 创建镜像
    - 基于已有镜像的容器创建
    - 基于本地模版导入
    - 基于Dockerfile创建

            1. docker commit -m 'some message' -a 'author information' CONTAINER_ID CONTAIN_Name:xxx
            2. docker import xxx

- 存出和载入镜像

        1. docker save -o ubuntu_14.04.tar ubuntu:14.04         # 存出镜像
        2. docker load --input ubuntu_14.04.tar                 # 载入镜像

- 上传镜像

        docker push NAME[:TAG]
        1. docker tag test:latest user/test:latest
           docker push user/test:latest

### 操作Docker容器
- 容器是镜像的一个运行实例，镜像是静态的只读文件，而容器带有运行时需要的可写文件层
- 创建容器
    - 新建容器
    - 启动容器
    - 新建并启动容器
    - 守护态运行
    - 退出容器

            1. docker create -it ubuntu:latest      # 新建容器但处于停止状态
            2. docker start CONTAINER_NAME          # 启动容器
            3. docker ps                            # 查看运行中的容器
            4. docker run ubuntu /bin/echo 'Hello'  # 直接新建并启动容器，之后自动终止
            5. docker run -it ubuntu:14.04 /bin/bash    # 启动bash终端，允许交互
            6. docker run -d ubuntu /bin/sh -c 'xxx'
            7. docker logs CONTAINER_NAME           # 获取容器的输出信息
            8. exit

- 终止容器

        1. docker stop CONTAINER_NAME

- 进入容器

        1. docker attach 
        2. docker exec

- 删除容器

        1. docker rm CONTAINER_NAME     # 只能删除处于终止或退出状态的容器

- 导入和导出容器

        1. docker export -o CONTAINER_NAME
        2. docker import test.tar - test/ubuntu:v1.0

### 访问Docker仓库
- Docker Hub 公共镜像市场 `registry.hub.docker.com`
- pull镜像，不需要登陆
- push镜像，需要登陆
    - Docker 可同时登陆很多个账号，账号登陆信息在`/root/.docker/config.json`，可通过`docker logout` 退出登陆。
    - 当退出登陆后，不能再往对应的仓库push 镜像
- 直接从Docker 公共市场下载镜像速度很慢，需要安装阿里云加速器。
    - 安装加速器后，只是pull 速度变快，push 速度依然很慢。
    - 从官方pull镜像，将镜像push 到自己的仓库地址

            sudo mkdir -p /etc/docker
            sudo tee /etc/docker/daemon.json <<-'EOF'
            {
              "registry-mirrors": ["https://i2go2fx6.mirror.aliyuncs.com"]
            }
            EOF
            sudo systemctl daemon-reload
            sudo systemctl restart docker

### Docker数据管理
- 数据卷

        1. 在容器内创建一个数据卷 -v
        docker run -d -P --name web -v /webapp training/webapp python app.py
        2. 挂载一个主机目录作为数据卷
        docker run -d -P --name web -v /src/webapp:/opt/webapp:ro training/webapp python app.py     默认权限是读写rw，ro指定为只读
- 数据卷容器
    - 多个容器之间共享一些持续更新的数据

            1. docker run -it -v /dbdata --name dbdata ubuntu
            2. docker run -it --volumes-from dbdata --name db1 ubuntu
               docker run -it --volumes-from dbdata --name db2 ubuntu
            可以从多个容器挂载多个数据卷

- 利用数据卷容器来迁移数据
- 备份

        docker run --volumes-from dbdata -v $(pwd):/backup --name worker ubuntu tar cvf /backup/backup.tar /dbdata
- 恢复

        1. docker run -v /dbdata --name dbdata2 ubuntu /bin/bash
        2. docker run --volumns-from dbdata2 -v $(pwd):/backup busybox tar xvf /backup/backup.tar

### 端口映射与容器互联
- 端口映射实现访问容器
    - 从外部访问容器应用

            docker run -d -P training/webapp python app.py
    - 映射所有接口地址

            docker run -d -p 5000:5000 -p 3000:80 training/webapp python app.py
    - 映射到指定地址的指定端口

            docker run -d -p 127.0.0.1:5000:5000 training/webapp python app.py
    - 映射到指定地址的任意端口

            docker run -d -p 127.0.0.1::5000/udp training/webapp python app.py
    - 查看映射端口配置

            docker port CONTAINER_NAME 5000

- 互联机制实现便捷互访
    - 自定义容器命名 --name

            docker run -d -P --name web training/webapp python app.py
            --rm    容器在终止后会立即删除 和-d 参数不能同时使用
    - 容器互联 --link name:alias

            docker run -d --name db training/postgres
            docker run -d -P --name web --link db:db training/webapp python app.py

## Docker 常用参数汇总表

        1. run -i -t -d -v -p -P --volumes-from --name --rm --link -h
        2. ps -a -l
        3. search -f stars=3
        4. commit -m -a
        5. rm/rmi -f


## 常用操作
- 配置国内官方镜像仓库[https://blog.csdn.net/zzy1078689276/article/details/77371782](https://blog.csdn.net/zzy1078689276/article/details/77371782 "Docker中配置国内镜像")

		# Linux环境
		1、使用vi修改 /etc/docker/daemon.json 文件并添加上”registry-mirrors”: [“https://registry.docker-cn.com“]
			vi /etc/docker/daemon.json 
			{ 
			“registry-mirrors”: [“https://registry.docker-cn.com“] 
			}
		2、重启Docker
			systemctl daemon-reload 
			systemctl restart docker