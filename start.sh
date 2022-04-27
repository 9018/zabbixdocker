cd /root
git clone https://github.com/9018/zabbixdocker.git
cd zabbixdocker
mkdir /home/data/grafana/
chown -R 472:472 /home/data/grafana/
docker-compose up -d 