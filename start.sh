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
  sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
else
  apt-get update
  apt-get install -y docker.io
  systemctl start docker
  systemctl enable docker
  pip install --upgrade pip
  pip install docker-compose --ignore-installed requests
fi
cd /root
git clone https://github.com/9018/zabbixdocker.git
cd zabbixdocker
chown -R 472:472 grafana
chmod -R 755 grafana/plugins/alexanderzobnin-zabbix-app/zabbix-plugin_linux_arm64
chmod -R 755 grafana/plugins/alexanderzobnin-zabbix-app/zabbix-plugin_linux_amd64
#mv /etc/docker/daemon.json daemon.json.bak
#cp daemon.json /etc/docker/daemon.json
#systemctl daemon-reload
#systemctl restart docker
mkdir /home/data
mkdir /home/data/grafana
chown -R -v 472:472 /home/data/grafana/
docker-compose up -d 
cd /root
git clone https://github.com/deviantony/docker-elk.git
cd docker-elk
docker-compose up -d
