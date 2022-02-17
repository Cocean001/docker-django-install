# django-installation-script，用于部署docker版django的一些基本环境配置
#!/bin/bash
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

echo "正在换源并更新apt"
cat > /etc/apt/sources.list << EOF
deb http://mirrors.aliyun.com/debian bullseye main contrib
deb-src http://mirrors.aliyun.com/debian bullseye main contrib
EOF

# 163源会造成ssh无法安装等问题
# cat > /etc/apt/sources.list << EOF
# deb http://mirrors.163.com/debian/ buster main non-free contrib
# deb http://mirrors.163.com/debian/ buster-updates main non-free contrib
# deb http://mirrors.163.com/debian/ buster-backports main non-free contrib
# deb-src http://mirrors.163.com/debian/ buster main non-free contrib
# deb-src http://mirrors.163.com/debian/ buster-updates main non-free contrib
# deb-src http://mirrors.163.com/debian/ buster-backports main non-free contrib
# deb http://mirrors.163.com/debian-security/ buster/updates main non-free contrib
# deb-src http://mirrors.163.com/debian-security/ buster/updates main non-free contrib
# EOF

apt update -y
apt-get update -y
green "apt更新完成"

echo "正在配置openssh-server环境"
apt install sudo -y
apt install openssh-server -y
green "sshserver安装完成"
green "请输入ssh新密码"
passwd

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config 
sed 's@sessions*requireds*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
echo "export VISIBLE=now" >> /etc/profile
green "sshserver配置写入完成"

echo "正在安装环境依赖"
sudo apt-get install default-libmysqlclient-dev -y
sudo apt install libcrypto++-dev -y
sudo apt install libssl-dev -y
sudo apt-get install libboost-dev -y
sudo apt install vim -y
green "环境依赖安装完成"

echo "正在安装python3.7 环境依赖"
apt-get install python3.7-dev -y	#安装python3.7的依赖，如果是其他版本，就需要安装相应版本依赖
green "python3.7环境依赖已安装完成"

echo "正在安装python包-mysqlclient"
pip3 install mysqlclient -y
green "mysqlclient 已安装完成"

echo "正在安装python包-tesseract-ocr"
apt install tesseract-ocr -y
pip3 install pillow -y
echo "正在安装django2.0环境"
pip3 install django==2.0

echo "即将创建django-project项目文件并将python3全局命令变更为python"
cd /opt
django-admin startproject djangoproject
cd /opt/django-project
echo "正在配置virtualenv"
pip3 install virtualenv -y
green "virtualenv 安装完成"
cd env/bin
source /tmp/django-project/env/bin/activate
green "全局变更已完成"

echo "即将安装zsh并配置环境"
apt install zsh -y
apt install git -y
chsh -s /bin/zsh

cd /opt/

# wget -c https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh 由于此地址经常无法访问，此处使用gitee的zsh

echo "即将安装oh-my-zsh"
curl -O https://gitee.com/pocmon/ohmyzsh/raw/master/tools/install.sh
bash install.sh
green "oh-my-zsh已安装完成"

cd /opt && rm install.sh
green "环境配置完成，退出程序"







