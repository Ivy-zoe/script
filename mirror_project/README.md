# Rsync Script



## 介绍

在本地同步一些下游镜像（国内），这个脚本目前只适用于CentOS.X系统，当然你可以解决所需要的软件也可以使用。:-)

需要的软件
- rsync
- creatrepo
- curl
- git


## 过滤

为了可以方便定制 镜像内容config 文件夹下就是一些过滤的文件可以根据需要自行修改

## 参数设定
可以修改 tools文件夹下的env.sh内容
```
WORK_DIR=/opt/soft/mirror_project
脚本的目录

Config_DIR=/opt/soft/mirror_project/config
配置目录
DATA_DIR=/data/mirrors
镜像数据存放目录可以自定义修改
镜像源存放位置
EPEL6=/data/mirrors/epel/6
EPEL7=/data/mirrors/epel/7
CentOS7=/data/mirrors/centos/7
CentOS6=/data/mirrors/centos/6
MONGODB=/data/mirrors/mongodb/6
Mariadb=/data/mirrors/mariadb/7
Nginx=/data/mirrors/nginx/6
REMI=/data/mirrors/remi/6
站点
TUNA=mirrors.tuna.tsinghua.edu.cn
USTC=mirrors.ustc.edu.cn
```
## 使用方法

如果没有git需要安装git


```
git clone https://github.com/slmoby/script
cd script/mirror_project
./rsync.sh 
```

list 可以查看目前支持的镜像

all 可以直接同步所有镜像

可以修改rsync.sh 菜单来实现管理


## 同步好的源使用方法

这里推荐使用httpd 方式去发布
例子

CentOS 

```
yum install httpd -y
```

添加到开机启动项并启动

```
systemctl enable httpd
systemctl start httpd
```

验证操作
```
curl localhost
```

创建软连接

```
ln -s /data/mirrors /var/www/html
```

## 局域网中的机器使用源

方便使用可以使用1个repo文件或者多个repo文件去管理（多个可以灵活使用yum去管理）

例子使用epel7的源
192.168.1.100 替换你的镜像服务器ip

```
[epel7]
name = epel7
baseurl = http://192.168.1.100/mirrors/epel/7
enable = 1
gpgcheck = 0

```

然后运行 `yum makecache` 生成缓存


## TODO List

- Stack 模式
- Stauts
- 简化拆分脚本
