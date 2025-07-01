#!/bin/bash

exec > /var/log/user-data.log 2>&1
set -x

yum update -y
yum install -y httpd php php-mysqli awscli -y

db_ip="${db_ip}"
db_user="${db_user}"
db_password="${db_password}"
db_name="${db_name}"

systemctl enable httpd
systemctl start httpd

# Create submit.php to accept and store feedback
cat <<EOF > /var/www/html/submit.php
<?php
\$conn = new mysqli("${db_ip}", "${db_user}", "${db_password}", "${db_name}");
if (\$conn->connect_error) {
    die("Connection failed: " . \$conn->connect_error);
}

\$name = \$_POST['name'] ?? '';
\$message = \$_POST['message'] ?? '';

if (!empty(\$name) && !empty(\$message)) {
    \$stmt = \$conn->prepare("INSERT INTO feedback (name, message) VALUES (?, ?)");
    \$stmt->bind_param("ss", \$name, \$message);
    \$stmt->execute();
    \$stmt->close();
    echo "Feedback saved.";
} else {
    echo "Missing input.";
}
\$conn->close();
?>
EOF

# Set permissions
chown apache:apache /var/www/html/submit.php
chmod 644 /var/www/html/submit.php
