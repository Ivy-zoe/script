# Rsync Script

Version:0.2
status: N/A

## 介绍

在本地同步一些下游镜像（国内），这个脚本目前只适用于CentOS.X系统，当然你可以解决所需要的软件也可以使用。:-)

需要的软件
- rsync
- creatrepo
- curl
- git


## 使用方法

如果没有git需要安装git


```
git clone https://github.com/slmoby/script
cd script/mirror_project
./rsync.sh 
```

list 可以查看目前支持的镜像

all 可以直接同步所有镜像（注意nginx 和glibc 是使用curl的）

可以修改rsync.sh 菜单来实现管理


## 过滤

为了可以方便定制 镜像内容 config文件夹下就是一些过滤的文件可以根据需要自行修改

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


## 增加自定义源

可以在 include 文件夹下的`stack.sh` 脚本中增加你需要同步的镜像
例子

```sh
function Rsync_Centos6(){
        rsync -avz --exclude-from=$Config_DIR/centos6.list rsync://$TUNA/centos/6.10/os/x86_64/  $CentOS6
        if [ -d $CentOS6/repodata ];then
            createrepo --update $CentOS6
        else
            createrepo $CentOS6
        fi
}
```
## 同步好的源使用方法

这里推荐使用`httpd`方式去发布 

例子`CentOS`


安装httpd服务

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

这里如果你的机器访问不了请检查你的防火墙规则和selinux状态，这里 我的防火墙处于关闭状态 selinux 为permissive模式。


创建软连接

```
ln -s /data/mirrors /var/www/html
```

## 局域网中的机器使用源

方便使用可以使用1个repo文件或者多个repo文件去管理（多个可以灵活使用yum去管理）

例子 这个脚本所同步的所有源，`192.168.1.100` 替换你的镜像服务器ip。

首先需要备份原有的yum源

```
mkdir ~/repos && mv /etc/yum.repos.d/* ~/repos
```

然后创建并编辑 `/etc/yum.repos.d/mirrors.repo` 内容如下 （OS:CentOS7）

```sh
[epel7]
name = epel7
baseurl = http://192.168.1.100/mirrors/epel/7
enable = 1
gpgcheck = 0

[centos7]
name = centos7
baseurl = http://192.168.1.100/mirrors/centos/7
enable = 1
gpcheck = 0

[zabbix7]
name = zabbix7
baseurl = http://192.168.1.100/mirrors/zabbix/7
enable = 1
gpcheck = 0

[zabbix-non-supported]
name = zabbix-non-supported
baseurl = http://192.168.1.100/mirrors/zabbix/7/non-supported
enable = 1
gpgcheck = 0

[zabbix-non-supported-srpm]
name = [zabbix-non-supproted-srpm]
baseurl = http://192.168.1.100/mirrors/zabbix/7/non-supported/SRPMS
enable = 1
gpcheck = 0

[zabbix-srpm]
name = srpm
baseurl = http://192.168.1.100/mirrors/zabbix/7/SRPMS 

[mariadb]
name = mariadb
baseurl = http://192.168.1.100/mirrors/mariadb/7
enable = 1
gpgcheck = 0

```

OS:CentOS6

```sh
[epel6]
name = epel6
baseurl = http://192.168.1.100/mirrors/epel/6
enbale = 1
gpgcheck = 0

[centos6]
name = centos6
baseurl = http://192.168.1.100/mirrors/centos/6
enable = 1
gpgcheck = 0

[nginx]
name = nginx
baseurl = http://192.168.1.100/mirrors/nginx/6
enable = 1
gpcheck = 0

[zabbix]
name = zabbix
baseurl = http://192.168.1.100/mirrors/zabbix/6
enable = 1
gpgcheck = 0

[zabbix-deprecated]
name = zabbix-deprecated
baseurl = http://192.168.1.100/mirrors/zabbix/6/deprecated
enable = 1
gpgcheck = 0

[zabbix-srpm]
name = zabbix-srpm
baseurl = http://192.168.1.100/mirrors/zabbix/6/SRPMS
enable = 1
gpgcheck = 0

[zabbix-non-supported]
name = zabbix-non-supported
baseurl = http://192.168.1.100/mirrors/zabbix/6/non-supported
enable = 1
gpgcheck = 0

[zabbix-non-supported-srpm]
name = zabbix-non-supported-srpm
baseurl = http://192.168.1.100/mirrors/zabbix/6/non-supported/SRPMS
enable = 1
gpgcheck = 0


[remi56]
name = remi
baseurl = http://192.168.1.100/mirrors/remi/6/php56
enable = 1
gpgcheck = 0


[remi72]
name = remi
baseurl = http://192.168.1.100/mirrors/remi/6/php72
enable = 1
gpgcheck = 0

[glibc]
name = glibc
baseurl = http://192.168.1.100/mirrors/glibc/6
enabel = 1
gpgcheck = 0

[mongodb]
name = mongodb
baseurl = http://192.168.1.100/mirrors/mongodb/6
enable = 1
gpgcheck = 0

```

然后运行 `yum makecache` 生成缓存

## 更新脚本

```sh
cd script && git pull
```

## TODO List

- Stauts

