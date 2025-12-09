FROM python:3.12-slim

RUN apt-get update && apt-get install -y sqlite3 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy backend code
COPY app/ /app/

# Copy templates, static, lang
COPY templates/ /app/templates/
COPY static/ /app/static/
COPY lang/ /app/lang/

# Copy Python files
COPY app/start.py /app/start.py
COPY app/update_plex_users.py /app/update_plex_users.py
COPY app/translations.json /app/translations.json

# Other files
COPY INFO /app/INFO
COPY icon.png /usr/share/icons/hicolor/256x256/apps/icon.png
COPY requirements.txt .

# Copy entrypoint
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

RUN pip install --no-cache-dir -r requirements.txt

# Create required folders
RUN mkdir -p /app/appdata/backup /app/appdata/logs /app/appdata/temp

EXPOSE 5000

ENTRYPOINT ["/app/entrypoint.sh"]

CMD ["python3", "/app/start.py"]
