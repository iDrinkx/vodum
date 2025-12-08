FROM python:3.12-slim

RUN apt-get update && apt-get install -y sqlite3 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy backend code (dans ton repo c'est "app/")
COPY app/ /app/

# Copy templates, static, lang
COPY templates/ /app/templates/
COPY static/ /app/static/
COPY lang/ /app/lang/

# Copy other required files
COPY requirements.txt .
COPY start.py /app/start.py
COPY update_plex_users.py /app/update_plex_users.py
COPY translations.json /app/translations.json
COPY INFO /app/INFO
COPY icon.png /usr/share/icons/hicolor/256x256/apps/icon.png

RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /app/appdata/backups /app/appdata/logs

EXPOSE 5000

CMD ["python3", "start.py"]
