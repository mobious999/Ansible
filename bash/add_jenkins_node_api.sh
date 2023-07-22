#!/bin/bash

JENKINS_URL="http://<your_jenkins_server>"
JENKINS_USERNAME="<your_jenkins_username>"
JENKINS_API_TOKEN="<your_jenkins_api_token>"
NODE_NAME="<new_node_name>"
NODE_DESCRIPTION="<node_description>"
REMOTE_FS_ROOT="<path_to_remote_fs_root>"  # e.g., /home/jenkins
NUM_EXECUTORS="<number_of_executors>"  # e.g., 2
LABELS="<node_labels>"  # Optional, e.g., linux, docker

# Add the Jenkins node remotely using cURL
curl -X POST -u "$JENKINS_USERNAME:$JENKINS_API_TOKEN" -H "Content-Type: application/x-www-form-urlencoded" "$JENKINS_URL/computer/doCreateItem" --data-urlencode "name=$NODE_NAME" --data-urlencode "type=hudson.slaves.DumbSlave\$DescriptorImpl" --data-urlencode "json={\"name\":\"$NODE_NAME\",\"nodeDescription\":\"$NODE_DESCRIPTION\",\"numExecutors\":\"$NUM_EXECUTORS\",\"remoteFS\":\"$REMOTE_FS_ROOT\",\"labelString\":\"$LABELS\",\"mode\":\"NORMAL\"}"
