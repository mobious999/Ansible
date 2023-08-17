tar -zxvf jenkins_backup.tar.gz -C /var/lib/
chown -R jenkins:jenkins /var/lib/jenkins
systemctl start jenkins