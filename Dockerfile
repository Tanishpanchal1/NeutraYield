FROM python:3.12-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project
COPY . .

# Run migrations
RUN python manage.py migrate --noinput || true
RUN python manage.py collectstatic --noinput || true

# Expose the port
EXPOSE 8000

# Run the application
CMD ["gunicorn", "bnb_hack.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "4"]
