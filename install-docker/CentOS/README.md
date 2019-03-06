# 安装Docker脚本

> 环境

Tips：不适用于 CentOS6.x

CentOS7.x
docker-ce.18.09

> 使用

- 安装

```sh
curl -fsSL https://raw.githubusercontent.com/slmoby/script/master/install-docker/CentOS/docker.sh | bash - install
```

- 删除Docker

```sh
curl -fsSL https://raw.githubusercontent.com/slmoby/script/master/install-docker/CentOS/docker.sh | bash -s remove
```

- 配置加速器

```sh
curl -fsSL https://raw.githubusercontent.com/slmoby/script/master/install-docker/CentOS/docker.sh | bash -s config
```


## local docker

这个是我内网的安装脚本，因为虚拟机的源之类的都定义好了，可以直接用
