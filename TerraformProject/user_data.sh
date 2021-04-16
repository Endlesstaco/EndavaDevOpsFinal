#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo echo 'Hello world!' > /var/www/html/index.html


