#!/bin/bash
set -e

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate --noinput

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Start the application
exec gunicorn bnb_hack.wsgi:application --bind 0.0.0.0:8000 --workers 4
