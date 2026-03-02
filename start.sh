#!/bin/bash
set -e

echo "Starting NeutraYield application..."

# Run Django migrations
echo "Running database migrations..."
python manage.py migrate --noinput 2>&1 || echo "Warning: Migrations encountered an issue (may be expected if DB already initialized)"

# Collect static files
echo "Collecting static files..."  
python manage.py collectstatic --noinput 2>&1 || echo "Warning: Static files collection encountered an issue"

# Create a superuser if it doesn't exist (optional)
echo "Application setup complete."

# Start the application with gunicorn
echo "Starting Gunicorn server on port 8000..."
exec gunicorn bnb_hack.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 4 \
    --worker-class sync \
    --timeout 120 \
    --access-logfile - \
    --error-logfile - \
    --log-level info
