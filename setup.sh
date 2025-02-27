#!bin/bash
echo "Update system global"
sudo apt update && sudo apt upgrade

echo "Install  nginx"
sudo apt install nginx
sudo systemctl enable nginx
sudo systemctl start nginx

echo "Install php packages + mysql "
sudo apt install php-fpm php-cli php-mysql php-curl php-mbstring php-xml php-zip

