#!/bin/bash

# Replace these variables with your Jenkins server details
JENKINS_URL="http://your-jenkins-server"
JENKINS_USER="your_jenkins_admin_user"
JENKINS_TOKEN="your_jenkins_api_token"

# Node details
NODE_NAME="new-node"
NODE_DESCRIPTION="My new node description"
NODE_LABELS="linux java"

# SSH connection details
SSH_USER="your_remote_ssh_user"
SSH_HOST="your_remote_ssh_host"
SSH_PORT="22"

# Create node via Jenkins CLI
java -jar jenkins-cli.jar -s $JENKINS_URL -auth $JENKINS_USER:$JENKINS_TOKEN create-node $NODE_NAME <<EOF
<slave>
  <name>${NODE_NAME}</name>
  <description>${NODE_DESCRIPTION}</description>
  <remoteFS>/home/${SSH_USER}</remoteFS>
  <numExecutors>2</numExecutors>
  <launcher class="hudson.plugins.sshslaves.SSHLauncher" plugin="ssh-slaves">
    <host>${SSH_HOST}</host>
    <port>${SSH_PORT}</port>
    <credentialsId>jenkins-ssh-key</credentialsId>
    <jvmOptions></jvmOptions>
    <javaPath></javaPath>
  </launcher>
  <label>${NODE_LABELS}</label>
</slave>
EOF
