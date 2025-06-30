#!/bin/bash
yum update -y
yum install -y httpd php
systemctl enable httpd
systemctl start httpd

cat <<EOF > /var/www/html/index.php
<!DOCTYPE html>
<html>
<head>
    <title>Three-Tier LAMP App</title>
</head>
<body>
    <h1>Register Username</h1>
    <form method="POST" action="http://${app_ip}/submit.php">
        <input type="text" name="username" placeholder="Enter username" required>
        <button type="submit">Submit</button>
    </form>
</body>
</html>
EOF

chown apache:apache /var/www/html/index.php
chmod 644 /var/www/html/index.php
