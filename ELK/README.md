# LAB

## Install Elastic

```sh
yum install java-1.8.0-openjdk -y
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
curl -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.2.3.rpm
rpm --install elasticsearch-6.2.3.rpm
systemctl daemon-reload
systemctl enable elasticsearch
systemctl start elasticsearch
```


## Install Logstash

```sh
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
```

### Add the repo 


```sh
vi /etc/yum.repos.d/logstash.repo

[logstash-6.x]
name=Elastic repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
```

```sh
yum install logstash -y
systemctl enable logstash
systemctl start logstash
```

## Install Kibana

```sh
curl -O https://artifacts.elastic.co/downloads/kibana/kibana-6.2.3-x86_64.rpm
rpm --install kibana-6.2.3-x86_64.rpm
systemctl enable kibana
systemctl start kibana
```

## Install Filebeat

```sh
curl -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.3-x86_64.rpm
rpm --install filebeat-6.2.3-x86_64.rpm
```

```sh
vi  /etc/filebeat/modules.d/system.yml.disabled

Uncomment:

var.convert_timezone: true
```
```sh
filebeat modules enable system
/usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-geoip
systemctl restart elasticsearch
filebeat setup
systemctl enable filebeat
systemctl start filebeat
```


# Tunnel the access through SSH

ssh cloud_user@34.227.53.185 -L 5601:localhost:5601