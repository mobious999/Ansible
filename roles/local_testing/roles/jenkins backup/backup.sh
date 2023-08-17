tar -zcvf jenkins_backup.tar.gz /var/lib/jenkins
scp jenkins_backup.tar.gz user@new_server_ip:/path/to/backup/
