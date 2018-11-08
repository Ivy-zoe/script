# Rsync Script

Version:0.6
status: N/A

## 局域网中的机器使用源

方便使用可以使用1个repo文件或者多个repo文件去管理（多个可以灵活使用yum去管理）

例子 这个脚本所同步的所有源，`10.0.0.100` 替换你的镜像服务器ip。

首先需要备份原有的yum源

```
mkdir ~/repos && mv /etc/yum.repos.d/* ~/repos
```

然后创建并编辑 `/etc/yum.repos.d/mirrors.repo` 内容如下 （OS:CentOS7）

```sh
[centos7]
name = centos7
baseurl = http://10.0.0.100/mirrors/centos/7
enable = 1
gpgcheck = 0

[epel]
name = epel
baseurl = http://10.0.0.100/mirrors/epel/7/x86_64
enbale = 1
gpgcheck = 0

[epel-srpm]
name = epel-srpm
basruel = http://10.0.0.100/mirrors/epel/7/SRPMS
enable = 1
gpgcheck = 0

[zabbix7]
name = zabbix7
baseurl = http://10.0.0.100/mirrors/zabbix/7
enable = 1
gpgcheck = 0

[zabbix-non-supported]
name = zabbix-non-supported
baseurl = http://10.0.0.100/mirrors/zabbix/7/non-supported
enable = 1
gpgcheck = 0

[zabbix-non-supported-srpm]
name = zabbix-non-supproted-srpm
baseurl = http://10.0.0.100/mirrors/zabbix/7/non-supported/SRPMS
enable = 1
gpgcheck = 0

[zabbix-srpm]
name = srpm
baseurl = http://10.0.0.100/mirrors/zabbix/7/SRPMS 
enable = 1
gpgcheck = 0

[mariadb]
name = mariadb
baseurl = http://10.0.0.100/mirrors/mariadb/7
enable = 1
gpgcheck = 0

[influxdata]
name = influxdata
baseurl = http://10.0.0.100/mirrors/influxdata/7
enable = 1
gpgcheck = 0

[mysql57]
name = mysql57
baseurl = http://10.0.0.100/mirrors/mysql57/7
enable = 1
gpgcheck = 0


```

OS:CentOS6

```sh
[epel6]
name = epel6
baseurl = http://10.0.0.100/mirrors/epel/6
enbale = 1
gpgcheck = 0

[centos6]
name = centos6
baseurl = http://10.0.0.100/mirrors/centos/6
enable = 1
gpgcheck = 0

[nginx]
name = nginx
baseurl = http://10.0.0.100/mirrors/nginx/6
enable = 1
gpgcheck = 0

[zabbix]
name = zabbix
baseurl = http://10.0.0.100/mirrors/zabbix/6
enable = 1
gpgcheck = 0

[zabbix-deprecated]
name = zabbix-deprecated
baseurl = http://10.0.0.100/mirrors/zabbix/6/deprecated
enable = 1
gpgcheck = 0

[zabbix-srpm]
name = zabbix-srpm
baseurl = http://10.0.0.100/mirrors/zabbix/6/SRPMS
enable = 1
gpgcheck = 0

[zabbix-non-supported]
name = zabbix-non-supported
baseurl = http://10.0.0.100/mirrors/zabbix/6/non-supported
enable = 1
gpgcheck = 0

[zabbix-non-supported-srpm]
name = zabbix-non-supported-srpm
baseurl = http://10.0.0.100/mirrors/zabbix/6/non-supported/SRPMS
enable = 1
gpgcheck = 0


[remi56]
name = remi
baseurl = http://10.0.0.100/mirrors/remi/6/php56
enable = 1
gpgcheck = 0


[remi72]
name = remi
baseurl = http://10.0.0.100/mirrors/remi/6/php72
enable = 1
gpgcheck = 0

[glibc]
name = glibc
baseurl = http://10.0.0.100/mirrors/glibc/6
enabel = 1
gpgcheck = 0

[mongodb]
name = mongodb
baseurl = http://10.0.0.100/mirrors/mongodb/6
enable = 1
gpgcheck = 0

[influxdata]
name = influxdata
baseurl = http://10.0.0.100/mirrors/influxdata/6
enable = 1
gpgcheck = 0

[pmm]
name = pmm
baseurl = http://10.0.0.100/mirrors/pmm/6
enbale = 1
gpgcheck = 0

```

然后运行 `yum makecache` 生成缓存


