#!/bin/bash

exec > /var/log/user-data.log 2>&1
set -x

yum update -y
yum install -y httpd php awscli -y

APP_IP="${app_ip}"
echo "SetEnv APP_IP $APP_IP" >> /etc/httpd/conf/httpd.conf


# Configure Apache with environment variable for app IP
echo "SetEnv APP_IP $APP_IP" > /etc/httpd/conf.d/app_ip.conf
systemctl enable httpd
systemctl start httpd

# Create index.php
cat <<EOF > /var/www/html/index.php
<!DOCTYPE html>
<html>
<head>
<title>Feedback</title>
<style>
body{font-family:Arial,sans-serif;max-width:400px;margin:50px auto;padding:20px;background:#f9f9f9}
form{background:white;padding:30px;border-radius:8px;box-shadow:0 2px 10px rgba(0,0,0,0.1)}
h1{margin:0 0 20px;color:#333;font-size:24px}
input,textarea{width:100%;padding:12px;margin:10px 0;border:1px solid #ddd;border-radius:4px;box-sizing:border-box}
button{width:100%;padding:12px;background:#007cba;color:white;border:none;border-radius:4px;cursor:pointer;font-size:16px}
button:hover{background:#005a87}
</style>
</head>
<body>
<form method="POST" action="/submit.php">
<h1>Feedback</h1>
<input name="name" placeholder="Name" required>
<textarea name="message" placeholder="Message" rows="4" required></textarea>
<button type="submit">Submit</button>
</form>
</body>
</html>
EOF

# Create submit.php to forward POST request to app server
cat <<'EOF' > /var/www/html/submit.php
<?php
$name = $_POST['name'] ?? '';
$message = $_POST['message'] ?? '';
$app_ip = getenv('APP_IP');
$url = "http://$app_ip/submit.php";

$ch = curl_init($url);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query(['name' => $name, 'message' => $message]));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($ch);
curl_close($ch);

header("Location: /");
exit;
?>
EOF

chown apache:apache /var/www/html/*
chmod 644 /var/www/html/*
