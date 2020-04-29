
# Centos

```sh
yum install -y java
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y java
yum install -y jenkins
service jenkins start
chkconfig jenkins
```

Admin password

```sh
cat /var/lib/jenkins/secrets/initialAdminPassword
```

# Docker

```sh
docker stack deploy -c jenkins.yaml jenkins
```


# Plugins

AnsiColor, Copy Artifact Plugin, Docker Slave, Docker Pipeline Plugin, Docker Build and Publish plugin, Fingerprint Plugin, Git Plugin, and NodeJS Plugin.

# Jenkins Slave

```s
ssh-copy-id <DESTINO>
wget https://releases.hashicorp.com/packer/1.2.4/packer_1.2.4_linux_amd64.zip
```