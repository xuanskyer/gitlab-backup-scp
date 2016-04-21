#!/bin/bash

################################################
# 调用 gitlab-rake gitlab:backup:create 创建备份
# 并 scp 发送的备份机器上。 因为调用scp 请设置双机互信
# @author xuanskyer <xuanskyer@163.com>
# @time 2016-4-21 14:55:04
################################################

backup_dir="/var/opt/gitlab/backups"
rakeBackup="gitlab-rake gitlab:backup:create"
remote_host="192.168.3.222"
remote_user="root"
remote_backup_dir="/var/opt/gitlab/backups/"

# 创建备份

echo $rakeBackup ...

$rakeBackup

# 进入备份目录
cd $backup_dir

ls -ltr > /tmp/test_gitlab.log

# 读取一天内新创建的文件，发送到备份机

echo 发送文件到备份机...

find ./ -ctime -1 | while read line
do

    if [ -f $line ]; then
        cmd="scp -rp $line $remote_user@$remote_host:$remote_backup_dir$remote_host"
        echo $cmd
        $cmd
   fi
   count=$[ $count + 1 ]

done

echo 发送完成！

exit 0
