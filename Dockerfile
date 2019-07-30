FROM centos:latest

RUN ["/bin/bash", "-c", " yum -y update"]
RUN ["/bin/bash", "-c", "  yum -y install java-1.8.0-openjdk git"]
RUN ["/bin/bash", "-c", " curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | tee /etc/yum.repos.d/jenkins.repo  && rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key"]
RUN ["/bin/bash", "-c", " yum  -y install jenkins"]

RUN ["/bin/bash", "-c", " rm -rf /var/lib/jenkins"]
RUN ["bin/bash", "-c", " yum -y install git && mkdir /tmp/jenkins && git clone https://github.com/manrodri/jenkinsUseCase.git /tmp/jenkins"]

RUN ["/bin/bash", "-c", " cp -r /tmp/jenkins/jenkins /var/lib &&  chown -R  jenkins:jenkins /var/lib/jenkins && chmod 755 /var/lib/jenkins"]
RUN ["/bin/bash", "-c", " systemctl enable jenkins"]

EXPOSE 8080
ENTRYPOINT ["/sbin/init"]
