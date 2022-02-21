sleep 30
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo ufw enable
sudo ufw allow 80/tcp
sudo mkdir vivek2