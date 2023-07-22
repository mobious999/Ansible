#!/bin/bash

# Variables
JENKINS_USER="jenkins"
JENKINS_GROUP="jenkins"
JENKINS_HOME="/var/lib/jenkins"   # Modify this path to the desired Jenkins home directory on the new server

# Create Jenkins user and group
sudo groupadd "${JENKINS_GROUP}"
sudo useradd -g "${JENKINS_GROUP}" -d "${JENKINS_HOME}" -m -s /bin/bash "${JENKINS_USER}"

# Assign permissions
sudo chown -R "${JENKINS_USER}:${JENKINS_GROUP}" "${JENKINS_HOME}"

# Allow the Jenkins user to access the Jenkins home directory
sudo usermod -aG "${JENKINS_GROUP}" "${USER}"

# Run Jenkins setup script (jenkins_service.sh)
./jenkins_service.sh
