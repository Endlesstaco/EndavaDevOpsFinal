#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo echo 'Hello world!' > /var/www/html/index.html
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo chmod 666 /var/run/docker.sock
docker run -d -p 9090:9090 prom/prometheus





