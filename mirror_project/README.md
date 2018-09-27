# Rsync Script



## 介绍

在本地同步一些下游镜像（国内），这个脚本目前只适用于CentOS.X系统，当然你可以解决所需要的软件也可以使用。:-)

需要的软件
- rsync
- creatrepo
- curl



## 参数设定
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
站点（这里并没有太大的作用后续版本会用到）
TUNA=mirrors.tuna.tsinghua.edu.cn
USTC=mirrors.ustc.edu.cn
```
## 使用方法


```
./rsync list && all
```

list 可以查看目前支持的镜像

all 可以直接同步所有镜像



## TODO List

- Stack 模式
- Stauts
- 简化拆分脚本
