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
- 创建容器
    - 新建容器
    - 启动容器
    - 新建并启动容器
    - 守护态运行

            1. docker create -it ubuntu:latest      # 新建容器但处于停止状态
            2. docker start af                      # 启动容器
            3. docker ps                            # 查看运行中的容器
            4. docker run ubuntu /bin/echo 'Hello'  # 直接新建并启动容器，之后自动终止
            5. docker run -it ubuntu:14.04 /bin/bash    # 启动bash终端，允许交互
            6. docker run -d ubuntu /bin/sh -c 'xxx'
            7. docker logs CONTAINER_NAME           # 获取容器的输出信息

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
- Docker Hub 公共镜像市场