#!/bin/bash
sudo yum install epel-release -y
sudo yum install nginx -y
sudo export HOSTNAME=$(curl -s http://169.254.169.254/metadata/v1/hostname)
sudo export PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)
sudo echo Droplet: $HOSTNAME, IP Address: $PUBLIC_IPV4 > /usr/share/nginx/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx
