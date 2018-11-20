# Rsync Script

Version:0.7
status: N/A

## 下载

需要安装git

CentOS
```sh
sudo yum install git -y
```

Gentoo
```sh
sudo emerge --ask 'dev-vcs/git'
```
openSUSE
```sh
sudo zypper in git
```

下载mirrors脚本


```sh
git clone https://github.com/slmoby/script
```

需要的其他软件

- rsync

- createrepo

- httpd



  ##  环境预设



默认变量

| 变量名称   | 位置                                 | 定义                     |
| ---------- | ------------------------------------ | ------------------------ |
| Config_DIR | ./config                             | 所需要用到的配置文件目录 |
| DATA_DIR   | /data/mirrors                        | 镜像站的存放位置         |
| rsync_tuna | rsync://mirrors.tuna.tsinghua.edu.cn | 同步的镜像源位置         |
| REPO       | $DATA_DIR/repo                       | 生成的repo位置           |
|            |                                      |                          |

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

44 directories, 0 files
```



在`env.sh` 中使用了`_check_command_and_yum_install`这个函数这个函数位于 `lib/libs.so`这个库文件中，如果你使用的是非redhat系发行版你可以手动解决软件依赖`rsync,createrepo`来去解决这个问题



项目目录树

```
├── ChangeLog
├── README.md
├── add.sh
├── config
│   ├── centos6.list
│   ├── centos7.list
│   ├── epel6.list
│   ├── epel7.list
│   ├── gilbc-2.15-wget-list
│   ├── glibc2.17_for_6-wget-list
│   ├── mariadb.list
│   ├── mongodb3.6.list
│   ├── mysql.list
│   ├── nginx-wget-list
│   ├── remi.list
│   ├── zabbix-for-centos6.list
│   └── zabbix-for-centos7.list
├── include
│   ├── env.sh
│   ├── run.sh
│   ├── stack.sh
│   └── static-repo.sh
├── lib
│   └── libs.so
└── mirros.sh

3 directories, 22 files
```



## 库文件函数方法

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





## 使用



1. 环境检查

   初次运行你可以按照你的环境来决定你的镜像目录修改`DATA_DIR`变量

   检查环境

   ```sh
   cd script/mirror_project
   ./mirros.sh check
   ```

   运行过程中会去检查环境并且创建目录

2. 同步第一个镜像

   在这里我增加了几个按钮，这个文件位于`include/env.sh`，你也可以通过 `./mirros.sh list `来查看默认支持哪些镜像，或者是直接同步目前所有的镜像，同步时间非常的长，同时也会消耗很大一部分的带宽请留意：）

   ```
   ./mirrors.sh all
   ```

3. 创建一个repo文件

   更新镜像站完毕之后你可以在服务端生成一些配置文件来使局域网内的机器更加容易使用，这里内置了一个参数`createrepos`来去生成所有的repo文件

   ```
   ./mirros.sh creatrepos
   ```

4. 增加一个镜像源

   因为内置库的缘故你可以非常简单的添加一个镜像，例子Docker的镜像站点

   首先在`env.sh` 中添加你的镜像站点存放位置

   ```bash
   DOCKER-CE=$DATA_DIR/docker
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
       status )
           ;;
   
       check )
       _check_path
       Check_directory
           ;;
       list )
           List
           ;;
         test )
           _mongodb_3.6
   
         ;;
         docker )
         _rsync_docker_for_centos7
         
         ;;
       * )
       RUN
   
       ;;
   esac
   ```

   运行

   ```
   ./mirros.sh docker
   ```




## 局域网中的机器使用源



1. 发布

   这里可以使用httpd服务器发布，`mirrors.sh`预制了一个安装httpd的功能

   ```
   ./mirros.sh httpd 
   ```

   即可安装并运行httpd，如果你的防火墙是开启的状态你可以运行

   ```
   ./mirrors.sh httpd_firewalld
   ```

发布目前yum源的repo静态文件至web服务器

```
./mirrors.sh creatrepos
```




1. 使用

   其他节点的服务器可以通过以下命令一键配置yum源

   ```
   curl -o $SERVER/repo/add.sh | sudo  bash 
   ```

   $SERVER 为你的yum源服务器