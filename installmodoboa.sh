#!/bin/bash

# Install dependencies 
sudo apt-get update
sudo apt-get install python3 python3-pip python3-dev libxml2-dev libxslt1-dev

# Create a virtual environment
python3 -m venv env
source env/bin/activate

# Install Modoboa
pip install modoboa

# Create directories
sudo mkdir -p /etc/modoboa /var/lib/modoboa
sudo chown -R $USER:$USER /etc/modoboa /var/lib/modoboa

# Generate a random secret key
python -c 'import random; print(random.SystemRandom().randint(0, 2147483647))' > /etc/modoboa/secret_key

# Collect static files
python manage.py collectstatic --noinput 

# Configure Modoboa 
python manage.py configure_modoboa

# Run the server
python manage.py runserver
