# docker-django-install
## 说明

该项目用于docker环境下的django容器内环境部署。

由于容器内系统默认为debian，并已默认安装git、wget，此脚本仅适用于debian系统。
此脚本将：
- 换源并安装apt
- 安装openssh-server（用于远程与pycharm建立ssh连接，当前pycharm还不支持docker容器远程管理）
- 安装系统环境依赖
- 安装python3.7及环境依赖
- 安装部分python包：mysqlclient、tesseract-ocr
- 设定全局命令，将python3改为python（方便pycharm管理）
- 安装django2.0及环境依赖
- 更换bash为zsh，并安装oh-my-zsh

## 使用方式


```shell
wget -c https://raw.githubusercontent.com/Cocean001/docker-django-install/main/django-install.sh
sudo bash django-install.sh
```
