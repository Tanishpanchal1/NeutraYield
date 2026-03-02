#!/bin/bash
set -e

# Navigate to the NeutraYield directory
cd /app/NeutraYield || cd NeutraYield

# Run Django migrations
echo "Running database migrations..."
python manage.py migrate --noinput

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Start the application
echo "Starting Gunicorn..."
exec gunicorn bnb_hack.wsgi:application --bind 0.0.0.0:8000 --workers 4
