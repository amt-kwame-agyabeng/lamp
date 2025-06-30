#!/bin/bash
yum update -y
yum install -y httpd php php-mysqlnd
systemctl enable httpd
systemctl start httpd

cat <<EOF > /var/www/html/submit.php
<?php
\$host = "${db_ip}";
\$db = "lampdb";
\$user = "lampuser";
\$pass = "securepassword";

\$conn = new mysqli(\$host, \$user, \$pass, \$db);
if (\$conn->connect_error) {
    die("Connection failed: " . \$conn->connect_error);
}

\$username = \$_POST['username'];
\$sql = "INSERT INTO users (username) VALUES ('\$username')";

if (\$conn->query(\$sql) === TRUE) {
    echo "<h2>Username '<strong>\$username</strong>' was successfully saved to the database.</h2>";
} else {
    echo "Error: " . \$conn->error;
}

\$conn->close();
?>
EOF

chown apache:apache /var/www/html/submit.php
chmod 644 /var/www/html/submit.php
