FROM python:3.12-slim

# Install SQLite
RUN apt-get update && apt-get install -y sqlite3 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy backend Python code
COPY backend/ /app/

# Copy frontend (templates + static)
COPY templates/ /app/templates/
COPY static/ /app/static/
COPY lang/ /app/lang/
COPY INFO /app/INFO

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Create needed folders
RUN mkdir -p /app/appdata/backups /app/appdata/logs

# Expose API port
EXPOSE 5000

# Start backend
CMD ["python3", "start.py"]
