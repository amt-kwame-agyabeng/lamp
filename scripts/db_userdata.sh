#!/bin/bash
yum update -y
yum install -y mysql-server

systemctl enable mysqld
systemctl start mysqld

# Secure MySQL installation (skipped interactive part here for simplicity)
mysql -e "CREATE DATABASE lampdb;"
mysql -e "CREATE USER 'lampuser'@'%' IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON lampdb.* TO 'lampuser'@'%';"
mysql -e "FLUSH PRIVILEGES;"
