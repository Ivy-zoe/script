#!/bin/bash

set -x 

function Rsync_CentOS6(){
    rsync -avz --exclude-from=$Config_DIR/centos6.list rsync://$TUNA/centos/6.10/ $CentOS6

}


function Rsync_CentOS7(){
    rsync -avz --exclude-from=$Config_DIR/centos7.list rsync://$TUNA/centos/7.5.1804/ $CentOS7

}

function Rsync_epel6(){
    rsync -avz --exclude-from=$Config_DIR/epel6.list rsync://$TUNA/epel/6 $EPEL6
}


function Rsync_epel7(){
    rsync -avz --exclude-from=$Config_DIR/epel7.list rsync://$TUNA/epel/7  $EPEL7
}




