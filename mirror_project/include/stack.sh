#!/bin/bash


function _rsync_CentOS7(){
  _rsync_mirrors $Config_DIR/centos7.list rsync://mirrors.tuna.tsinghua.edu.cn/centos/7.5.1804/ $CentOS7
#  _update_repos  CentOS7

}
