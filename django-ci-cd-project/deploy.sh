#!/bin/bash

cd ~/django_project
source venv/bin/activate
python manage.py migrate
python manage.py collectstatic --noinput
gunicorn your_project.wsgi:application --bind 0.0.0.0:8000 --daemon
