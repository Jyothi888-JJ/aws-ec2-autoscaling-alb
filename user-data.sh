#!/bin/bash

dnf update -y

dnf install -y nginx

systemctl enable nginx
systemctl start nginx

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

cat <<EOF > /usr/share/nginx/html/index.html
<html>
<head>
    <title>AWS DevOps Demo</title>
</head>
<body>
    <h1>AWS EC2 Auto Scaling Demo</h1>
    <p>Application is running successfully.</p>
    <p>Instance ID: $INSTANCE_ID</p>
</body>
</html>
EOF
