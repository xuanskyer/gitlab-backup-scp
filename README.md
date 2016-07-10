# gitlab-backup-scp

## 一个简单的gitlab数据自动备份到远程备份机器的脚本。

调用 gitlab-rake gitlab:backup:create 创建备份
并 scp 发送的备份机器上。 因为调用scp 请设置双机互信
