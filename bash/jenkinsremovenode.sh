#!/bin/bash

JENKINS_URL="http://<your_jenkins_server>"
JENKINS_USERNAME="<your_jenkins_username>"
JENKINS_API_TOKEN="<your_jenkins_api_token>"
NODE_NAME="<node_name_to_remove>"

# Remove the Jenkins node remotely using cURL
curl -X POST -u "$JENKINS_USERNAME:$JENKINS_API_TOKEN" "$JENKINS_URL/computer/$NODE_NAME/doDelete"
