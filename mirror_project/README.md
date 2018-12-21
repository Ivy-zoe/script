---
title:
- Mirrors Script
author:
- by chaos
---

# 版本

Version: 0.8-alpine

# 项目说明
mirrors_project是为了安全考虑在局域网内部建立一个镜像站的项目，它包含了一下功能。

- 更新同步
- 生成repodata文件
- 一件配置yum源


# 下载

需要安装git

CentOS
```sh
sudo yum install git -y
```

下载mirrors脚本


```sh
git clone https://github.com/slmoby/script
```

> 需要的软件列表

- rsync

- createrepo

- httpd

- wget 

# 环境预设



默认变量

| 变量名称   | 位置                                 | 定义                     |
| ---------- | ------------------------------------ | ------------------------ |
| Config_DIR | ./config                             | 所需要用到的配置文件目录 |
| DATA_DIR   | /data/mirrors                        | 镜像站的存放位置         |
| rsync_tuna | rsync://mirrors.tuna.tsinghua.edu.cn | 同步的镜像源位置         |
| REPO       | $DATA_DIR/repo                       | 生成的repo位置           |

你可以自定义修改`DATA_DIR`的位置来存放整个镜像站

DATA_DIR变量位于`include/env.sh`

一般来说只需要修改`DATA_DIR`即可

默认的目录树结构如下

```
mirrors/
├── centos
│   ├── 6
│   │   ├── extras
│   │   │   └── x86_64
│   │   ├── os
│   │   │   └── x86_64
│   │   └── updates
│   │       └── x86_64
│   └── 7
│       ├── extras
│       │   └── x86_64
│       ├── os
│       │   └── x86_64
│       └── updates
│           └── x86_64
├── epel
│   ├── 6
│   │   └── x86_64
│   └── 7
│       └── x86_64
├── glibc
│   └── 6
├── mariadb
│   └── 7
│       └── x86_64
├── mongodb
│   └── 6
├── nginx
│   └── 6
├── remi
│   └── 6
│       ├── 56
│       │   └── x86_64
│       └── 72
│           └── x86_64
├── repo
└── zabbix
    ├── 6
    │   ├── non-supported
    │   │   └── x86_64
    │   └── x86_64
    └── 7
        ├── non-supported
        │   └── x86_64
        └── x86_64

44 directories
```


在`env.sh` 中使用了`_check_command_and_yum_install`这个函数去安装需要的软件包这个函数位于 `lib/libs.so`这个库文件中，如果你使用的是非redhat系发行版你可以手动解决软件依赖`rsync,createrepo`来去解决这个问题

# 库文件函数方法

这里只介绍需要用到的函数

| 函数名称                       | 参数  | 使用方法                                |
| ------------------------------ | ----- | --------------------------------------- |
| _wget_url                      | 1     | _wget_url url                           |
| _check_dir_file_exist          | 1     | _check_dir_file_exist files             |
| _rsync_mirrors                 | 1,2,3 | _rsync_mirrors file.list rsync_url path |
| _source_file_exist             | 1     | _source_file_exist files                |
| _check_command_and_yum_install | 1     | _check_command_and_yum_install command  |
| _update_repos                  | 1     | _update_repos path                      |
| _wget_incloud_file             | 1,2   | _wget_incloud_file wget-list-file path  |
|                                |       |                                         |
|                                |       |                                         |


# 使用

> 环境检查

初次运行你可以按照你的环境来决定你的镜像目录修改`DATA_DIR`变量

检查环境

```sh
cd script/mirror_project
./mirros.sh check
```

运行过程中会去检查环境并且创建目录

> 同步第一个镜像

在这里我增加了几个按钮，这个文件位于`include/env.sh`，你也可以通过 `./mirros.sh list `来查看默认支持哪些镜像，或者是直接同步目前所有的镜像，同步时间非常的长，同时也会消耗很大一部分的带宽请留意：）

```
./mirrors.sh all
```

创建一个repo文件

更新镜像站完毕之后你可以在服务端生成一些配置文件来使局域网内的机器更加容易使用，这里内置了一个参数`createrepos`来去生成所有的repo文件

```
./mirros.sh creatrepos
```

> 增加一个镜像源

因为内置库的缘故你可以非常简单的添加一个镜像，例子Docker的镜像站点

首先在`env.sh` 中添加你的镜像站点存放位置，和web站点访问位置

```bash
DOCKER-CE=$DATA_DIR/docker
WEB_DOCKER=$MIRRORS_WEB/docker
```

再在`include/stack.sh`中添加以下内容

```bash
function _rsync_docker_for_centos7(){
	_rsync_mirrors $Config_DIR/docker.list $rsync_tuna/docker-ce/linux/centos/7/x86_64/stable/ $DOCKER
	_update_repos $DOCKER
    
}
```

添加按钮`mirrors.sh`

```sh
case $1 in
      docker )
      _rsync_docker_for_centos7
esac
```

运行

```
./mirros.sh docker
```

> 增加repo文件

​	在`include/static-repo.sh`文件中增加rpeo文件,在这个文件中我定义了一个函数体`_create_repos_file` 直接在里面添加如下

```bash

cat > $REPO/docker-ce-7.repo << EOF
	[docker-ce]
	name = docker-ce
	baseurl = http://$IP/$WEB/$DOCKER
	enable = 1
	gpgcheck = 0
EOF

```

更新repos文件

```sh
./mirros.sh creatrepos
```


# 局域网中的机器使用源

> 发布

这里可以使用httpd服务器发布，`mirrors.sh`预制了一个安装httpd的功能

```
./mirros.sh httpd 
```

即可安装并运行httpd，如果你的防火墙和selinux是开启的状态你可以运行

```
./mirrors.sh httpd_firewalld
```

发布目前yum源的repo静态文件至web服务器

```
./mirrors.sh creatrepos
```

> 使用

> 查看帮助

Tips: $SERVER替换为你的服务器地址

```bash
curl -fsSL http://$SERVER/mirrors/repo/add.sh | bash -s help
```


> 一键配置所有源

```bash
curl -fsSL http://$SERVER/mirrors/repo/add.sh | bash -s all
```

> Base 源配置

Tips: base源包括了 CentOSx.x的源和epel.x的源

```bash
curl -fsSL http://$SERVER/mirrors/repo/add.sh | bash -s init_base
```

> Zabbix 源配置

```bash
curl -fsSL http://$SERVER/mirrors/repo/add.sh | bash -s zabbix
```

> Remi 源配置

```bash
curl -fsSL http://$SERVER/mirrors/repo/add.sh | bash -s remi
```

> mongodb 源配置

```bash
curl -fsSL http://$SERVER/mirrors/repo/add.sh | bash -s mongodb
```

> MariaDB 源配置

```bash
curl -fsSL http://$SERVER/mirrors/repo/add.sh | bash -s mariadb
```

> Nginx 源配置

```bash
curl -fsSL http://$SERVER/mirrors/repo/add.sh | bash -s nginx
```

