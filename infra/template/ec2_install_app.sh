#!/bin/bash

# Update system packages
sudo apt update -y
sudo apt install -y python3 python3-pip python3-venv git

# Change to ubuntu user’s home
cd /home/ubuntu

# Clone your Flask app
git clone https://github.com/DEEZY4U/Python-REST-API-01-To-Do-App.git
cd Python-REST-API-01-To-Do-App

# Create and activate Python virtual environment
python3 -m venv venv
source venv/bin/activate

# Install requirements
pip install -r requirements.txt

# Setup environment variables directly into systemd service
cat <<EOF > /etc/systemd/system/todoapp.service
[Unit]
Description=Flask ToDo REST API
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/Python-REST-API-01-To-Do-App
Environment="API_BASE_URL=https://todo.deezyboi.space"
Environment="DB_HOST=${db_endpoint}"
Environment="DB_USER=dbuser"
Environment="DB_PASSWORD=dbpassword"
Environment="DB_NAME=devprojdb"
ExecStart=/home/ubuntu/Python-REST-API-01-To-Do-App/venv/bin/python /home/ubuntu/Python-REST-API-01-To-Do-App/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload and enable service
sudo systemctl daemon-reload
sudo systemctl enable todoapp
sudo systemctl start todoapp

# Print service status for debugging
sudo systemctl status todoapp --no-pager
