#!/bin/bash

exec > /var/log/user-data.log 2>&1
set -x

sudo dnf update -y
sudo dnf install -y mariadb105-server

sudo systemctl enable mariadb
sudo systemctl start mariadb

DB_NAME="${db_name}"       
DB_USER="${db_user}"
DB_PASSWORD="${db_password}"

sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS \`${db_name}\`;
CREATE USER IF NOT EXISTS '${db_user}'@'%' IDENTIFIED BY '${db_password}';
GRANT ALL PRIVILEGES ON \`${db_name}\`.* TO '${db_user}'@'%';
FLUSH PRIVILEGES;
USE \`${db_name}\`;
CREATE TABLE IF NOT EXISTS feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF

