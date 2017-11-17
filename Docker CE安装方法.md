## Docker官网 Ubuntu系统下Docker CE 安装方法
    $ sudo apt-get remove docker docker-engine docker.io
    $ sudo apt-get update
    $ sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
    $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    amd64:
       $ sudo add-apt-repository \
               "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
               $(lsb_release -cs) stable"
    armhf:
        $ sudo add-apt-repository \
               "deb [arch=armhf] https://download.docker.com/linux/ubuntu \
               $(lsb_release -cs) stable"
    $ sudo apt-get update
    $ sudo apt-get install docker-ce

## 清华大学开源软件镜像站 Ubuntu系统下Docker CE 安装方法
    sudo apt-get remove docker docker-engine docker.io
    sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common # 多了一个gnupg2
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 
    amd64:
        sudo add-apt-repository \
               "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
               $(lsb_release -cs) stable"
    
    arm:
        echo "deb [arch=armhf] https://download.docker.com/linux/ubuntu \
                 $(lsb_release -cs) stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list
    sudo apt-get update
    sudo apt-get install docker-ce

## 阿里云提供的安装方法
    # step 1: 安装必要的一些系统工具
    sudo apt-get update
    sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
    # step 2: 安装GPG证书
    curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
    # Step 3: 写入软件源信息
    sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
    # Step 4: 更新并安装Docker-CE
    sudo apt-get -y update
    sudo apt-get -y install docker-ce

    # 安装指定版本的Docker-CE:
    # Step 1: 查找Docker-CE的版本:
    # apt-cache madison docker-ce
    #   docker-ce | 17.03.1~ce-0~ubuntu-xenial | http://mirrors.aliyun.com/docker-ce/linux/ubuntu xenial/stable amd64 Packages
    #   docker-ce | 17.03.0~ce-0~ubuntu-xenial | http://mirrors.aliyun.com/docker-ce/linux/ubuntu xenial/stable amd64 Packages
    # Step 2: 安装指定版本的Docker-CE: (VERSION例如上面的17.03.1~ce-0~ubuntu-xenial)
    # sudo apt-get -y install docker-ce=[VERSION]