#!/bin/bash

# Configuration
JENKINS_HOME="/var/lib/jenkins"  # Update with your Jenkins home path
BACKUP_DIR="/tmp/jenkins_backup"
REPO_NAME="your-codecommit-repo-name"
AWS_PROFILE="your-aws-profile"

# Create backup
mkdir -p "$BACKUP_DIR"
cp -r "$JENKINS_HOME" "$BACKUP_DIR"

# Commit and push to CodeCommit
cd "$BACKUP_DIR"
git init
git add .
git commit -m "Jenkins Home Backup $(date +%Y-%m-%d_%H-%M-%S)"
aws codecommit create-repository --repository-name "$REPO_NAME" --profile "$AWS_PROFILE"
git remote add origin "https://git-codecommit.region.amazonaws.com/v1/repos/$REPO_NAME"
git push -u origin master

# Clean up
rm -rf "$BACKUP_DIR"
