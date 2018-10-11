#!/bin/bash

function List(){
    clear
    purplecolor "+---------------------------------------------------------------------------------------+"
    redcolor "| Number  Images_Name    Website                      Local_Path           "
    purplecolor "+---------------------------------------------------------------------------------------+"
    greencolor "| 1       nginx         $USTC        $Nginx "
    purplecolor "+---------------------------------------------------------------------------------------+"
    greencolor "| 2       epel6         $TUNA        $EPEL6   "
    purplecolor "+---------------------------------------------------------------------------------------+"
    greencolor "| 3       epel7         $TUNA        $EPEL7"
    purplecolor "+---------------------------------------------------------------------------------------+"
    greencolor "| 4       centos7       $TUNA        $CentOS7"
    purplecolor "+---------------------------------------------------------------------------------------+"
    greencolor "| 5       centos6       $TUNA        $CentOS6"
    purplecolor "+---------------------------------------------------------------------------------------+"
    greencolor "| 6       mariadb   $TUNA        $Mariadb"
    purplecolor "+---------------------------------------------------------------------------------------+"
    greencolor "| 7       remi           $TUNA       $REMI"
    purplecolor "+---------------------------------------------------------------------------------------+"
    greencolor "| 8       mongodb     $TUNA        $MONGODB"
    purplecolor "+---------------------------------------------------------------------------------------+"
    greencolor "| 9       zabbix6       $TUNA        $ZABBIX6"
    purplecolor "+---------------------------------------------------------------------------------------+"
    greencolor "| 10      zabbix7       $TUNA         $ZABBIX7"
    purplecolor "+---------------------------------------------------------------------------------------+"
    redcolor "|                 Curl "
    purplecolor "+---------------------------------------------------------------------------------------+"
    greencolor "| 11      glibc        $REDSLEVE         $GLIBC"
    purplecolor "+---------------------------------------------------------------------------------------+"
}

function RUN(){
    clear
    skybluecolor "+------------------------------------------------------------------------+"
    skybluecolor "|                   Rsync Script          "
    skybluecolor "+------------------------------------------------------------------------+"
    skybluecolor "| This script is only allowed to execute on the CentOS system"
    skybluecolor "+------------------------------------------------------------------------+"
    skybluecolor "|         Rsync base packages mirrors     "
    skybluecolor "+------------------------------------------------------------------------+"
    skybluecolor "|           For more information please visit docs                 "
    skybluecolor "+------------------------------------------------------------------------+"
    skybluecolor "| If you are running for the first time, check your environment with the check option."
    skybluecolor "| You can use the list to see which images can be synchronized."
    skybluecolor "+------------------------------------------------------------------------+"
    skybluecolor "|Use the corresponding image name to sync, or use all to sync all"
    skybluecolor "+------------------------------------------------------------------------+"
}

