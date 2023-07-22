#!/bin/bash

# Variables
S3_BUCKET_NAME="your-s3-bucket-name"
JENKINS_HOME="/var/lib/jenkins"   # Modify this path if your Jenkins home directory is located elsewhere

# Archive Jenkins home directory to a tar.gz file
JENKINS_BACKUP_FILENAME="jenkins_backup_$(date +"%Y%m%d%H%M%S").tar.gz"
tar -zcvf "$JENKINS_BACKUP_FILENAME" -C "$JENKINS_HOME" .

# Upload the backup file to S3
aws s3 cp "$JENKINS_BACKUP_FILENAME" "s3://$S3_BUCKET_NAME/"

# Remove the local backup file
rm "$JENKINS_BACKUP_FILENAME"

echo "Jenkins backup completed and uploaded to S3 bucket: $S3_BUCKET_NAME"
