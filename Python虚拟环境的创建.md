# Python 虚拟环境的创建

## Python3自带的venv模块

        python -m venv myenv    # myenv为创建虚拟环境的目录
        myenv/Scripts/activate  # 激活虚拟环境	
        myenv/Scripts/deactivate# 退出虚拟环境
        

## 使用第三方模块virtualenv

        pip install virtualenv
        virutalenv venv        # venv为创建虚拟环境的目录
        venv/bin/activate       # 激活虚拟环境
        venv/bin/deactivate     # 退出虚拟环境

- 注意事项：在Windows环境下为Scripts目录，在Linux环境下为bin目录