#!/bin/bash
sudo yum update
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>My first web server deployed. It will be fantastic </h1>" | sudo tee /var/www/html/index.html