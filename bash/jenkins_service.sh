#!/bin/bash

# Variables
JENKINS_HOME="/var/lib/jenkins"   # Modify this path to the desired Jenkins home directory on the new server
JENKINS_USER="jenkins"   # Jenkins user (modify if needed)
JENKINS_GROUP="jenkins"  # Jenkins group (modify if needed)

# Function to create the Jenkins service file
create_jenkins_service() {
    cat <<EOF | sudo tee /etc/systemd/system/jenkins.service
[Unit]
Description=Jenkins CI Server
After=network.target

[Service]
User=${JENKINS_USER}
Group=${JENKINS_GROUP}
Environment="JENKINS_HOME=${JENKINS_HOME}"
Environment="JENKINS_SLAVE_AGENT_PORT=50000"
Environment="JAVA_OPTS=-Djava.awt.headless=true"
EnvironmentFile=-/etc/default/jenkins
ExecStart=/usr/bin/java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war
ExecReload=/bin/kill -HUP \$MAINPID
WorkingDirectory=${JENKINS_HOME}

[Install]
WantedBy=multi-user.target
EOF
}

# Function to enable and start the Jenkins service
enable_and_start_service() {
    sudo systemctl daemon-reload
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    sudo systemctl status jenkins
}

create_jenkins_service
enable_and_start_service
