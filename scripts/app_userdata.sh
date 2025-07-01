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

# Create view.php to display feedback entries
cat <<EOF > /var/www/html/view.php
<?php
\$conn = new mysqli("${db_ip}", "${db_user}", "${db_password}", "${db_name}");
if (\$conn->connect_error) {
    die("DB Connection failed: " . \$conn->connect_error);
}

\$result = \$conn->query("SELECT name, message, submitted_at FROM feedback ORDER BY submitted_at DESC");

if (\$result && \$result->num_rows > 0) {
    while (\$row = \$result->fetch_assoc()) {
        echo "<div class='feedback-entry'>";
        echo "<strong>" . htmlspecialchars(\$row['name']) . "</strong><br>";
        echo "<em>" . htmlspecialchars(\$row['submitted_at']) . "</em><br>";
        echo "<p>" . htmlspecialchars(\$row['message']) . "</p>";
        echo "</div><hr>";
    }
} else {
    echo "<p>No feedback found.</p>";
}
\$conn->close();
?>
EOF

# Set permissions
chown apache:apache /var/www/html/submit.php /var/www/html/view.php
chmod 644 /var/www/html/submit.php /var/www/html/view.php
