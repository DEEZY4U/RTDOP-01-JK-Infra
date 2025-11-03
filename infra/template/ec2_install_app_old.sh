#!/bin/bash

cd /home/ubuntu
apt update -y
apt install -y python3 python3-pip python3-venv git


# Clone your app repo
git clone https://github.com/DEEZY4U/Python-REST-API-01-To-Do-App.git
cd Python-REST-API-01-To-Do-App

python3 -m venv ~/todo-env
source ~/todo-env/bin/activate

pip3 install -r requirements.txt

# Export environment variables for the Flask app
echo "export DB_HOST=${db_endpoint}" >> /home/ubuntu/.bashrc
echo "export DB_USER='dbuser'" >> /home/ubuntu/.bashrc
echo "export DB_PASS='dbpassword'" >> /home/ubuntu/.bashrc
echo "export DB_NAME='devprojdb'" >> /home/ubuntu/.bashrc

# Also export them for current session
export DB_HOST=${db_endpoint}
export DB_USER='dbuser'
export DB_PASS='dbpassword'
export DB_NAME='devprojdb'

cat $DB_HOST

# Wait a bit to ensure DB is ready
echo "Waiting for DB to initialize..."
sleep 10

# Run the Flask app
# nohup python3 app.py > app.log 2>&1 &