#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
SHELL=/bin/bash
export PATH
os=$(egrep -i 'debian|ubuntu|cent' -o -- /etc/issue)
os="${os,,}"
if [ -z "$os" ] && type yum; then os='cent'; fi
if [ "$os" = 'cent' ]; then
  yum update
  yum install -y epel-release
  yum install -y wget git python-pip docker
  systemctl start docker.service
  systemctl enable docker.service
  pip install --upgrade pip
  pip install docker-compose --ignore-installed requests
else
  apt-get update
  apt-get install -y docker
fi
cd zabbixdocker
mv /etc/daemon.json daemon.json.bak
cp daemon.json /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker
cd /root
git clone https://github.com/9018/zabbixdocker.git
cd zabbixdocker
mkdir /home/data
mkdir /home/data/grafana
chown -R 472:472 /home/data/grafana/
docker-compose up -d 
cd /root
git clone https://github.com/deviantony/docker-elk.git
cd docker-elk
docker-compose up -d