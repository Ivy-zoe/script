#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# debug
#set -x

# incloude
. include/list.sh
. include/main.sh
. include/stack.sh



case "$1" in
    all)
        all 2>&1 | tee /root/all-download.log
        ;;
    list)
        List
        ;;
    *)
        RUN
        redcolor "Usage: $0 {check|all|list}"
        ;;
esac

exit
