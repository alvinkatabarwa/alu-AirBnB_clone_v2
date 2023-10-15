#!/usr/bin/ env bash

# Install Nginx if not already installed
sudo apt-get update
sudo apt-get -y install nginx

# Create necessary folders and files
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/
sudo echo "Hello, this is a test index.html file." | sudo tee /data/web_static/releases/test/index.html

# Create symbolic link
sudo rm -rf /data/web_static/current
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership to ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
sudo sed -i '/server_name _;/ a\
\\n\
    location /hbnb_static/ {\
        alias /data/web_static/current/;\
        index index.html;\
    }' /etc/nginx/sites-available/default

# Restart Nginx
sudo service nginx restart

