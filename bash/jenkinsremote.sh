#!/bin/bash

JENKINS_URL="http://<your_jenkins_server>"
JENKINS_USERNAME="<your_jenkins_username>"
JENKINS_API_TOKEN="<your_jenkins_api_token>"
JOB_NAME="<your_job_name>"

# Path to the Jenkins CLI JAR file on your local machine
JENKINS_CLI_JAR="/path/to/jenkins-cli.jar"

# Trigger the Jenkins job remotely
java -jar "$JENKINS_CLI_JAR" -s "$JENKINS_URL" -auth "$JENKINS_USERNAME:$JENKINS_API_TOKEN" build "$JOB_NAME" -s
