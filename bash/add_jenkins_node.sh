#!/bin/bash

JENKINS_URL="http://<your_jenkins_server>"
JENKINS_USERNAME="<your_jenkins_username>"
JENKINS_API_TOKEN="<your_jenkins_api_token>"
NODE_NAME="<new_node_name>"
NODE_DESCRIPTION="<node_description>"
REMOTE_FS_ROOT="<path_to_remote_fs_root>"  # e.g., /home/jenkins
NUM_EXECUTORS="<number_of_executors>"  # e.g., 2
LABELS="<node_labels>"  # Optional, e.g., linux, docker

# Path to the Jenkins CLI JAR file on your local machine
JENKINS_CLI_JAR="/path/to/jenkins-cli.jar"

# Add the Jenkins node remotely
java -jar "$JENKINS_CLI_JAR" -s "$JENKINS_URL" -auth "$JENKINS_USERNAME:$JENKINS_API_TOKEN" create-node "$NODE_NAME" -description "$NODE_DESCRIPTION" -fsroot "$REMOTE_FS_ROOT" -executors "$NUM_EXECUTORS" -labels "$LABELS"
