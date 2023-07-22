#!/bin/bash

# Variables
S3_BUCKET_NAME="your-s3-bucket-name"
JENKINS_HOME="/var/lib/jenkins"   # Modify this path to the desired Jenkins home directory on the new server

# Download the Jenkins backup file from S3
aws s3 cp "s3://$S3_BUCKET_NAME/jenkins_backup.tar.gz" .

# Extract the backup file to the Jenkins home directory
tar -zxvf jenkins_backup.tar.gz -C "$JENKINS_HOME"

# Remove the local backup file
rm jenkins_backup.tar.gz

echo "Jenkins restore completed from S3 bucket: $S3_BUCKET_NAME to $JENKINS_HOME"
