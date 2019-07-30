#!/bin/bash

# install java
sudo yum -y install java-1.8.0-openjdk

if [ $? -ne 0 ]; then
    echo "Command: yum -y install java-1.8.0-openjdk failed "
fi

# add repo and install jenkins
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

sudo yum  -y install jenkins

if [ $? -ne 0 ]; then
    echo "add repo and install jenkins failed "
fi

# remove default jenkins location
sudo rm -rf /var/lib/jenkins
if [ $? -ne 0 ]; then
    echo "rm command failed "
fi


# clone repo with fresh install of jenkins which meets requirements
sudo yum -y install git && mkdir /tmp/jenkins && git clone https://github.com/manrodri/jenkinsUseCase.git /tmp/jenkins

if [ $? -ne 0 ]; then
    echo "clone repo failed"
fi

# copy to /var/lib/jenkins and give appropiate permissions
sudo cp -r /tmp/jenkins/jenkins /var/lib
if [ $? -ne 0 ]; then
    echo "cp jenkins failed"
fi
sudo chown -R  jenkins:jenkins /var/lib/jenkins
sudo chmod 755 /var/lib/jenkins
if [ $? -ne 0 ]; then
    echo "permissions failed"
fi



# enable and start service
sudo systemctl enable jenkins && sudo systemctl start jenkins
if [ $? -ne 0 ]; then
    echo "systemct start failed"
fi