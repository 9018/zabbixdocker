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