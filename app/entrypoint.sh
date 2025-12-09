#!/bin/sh

# ---------------------------------------------------------
# Création automatique des dossiers nécessaires à Vodum
# ---------------------------------------------------------
mkdir -p /app/appdata/backup
mkdir -p /app/appdata/logs
mkdir -p /app/appdata/temp

# Permissions (évite les erreurs SQLite)
chmod -R 775 /app/appdata

# ---------------------------------------------------------
# Lancement de Vodum
# ---------------------------------------------------------
python3 app.py &

# ---------------------------------------------------------
# Lancement du scheduler (crons)
# ---------------------------------------------------------
exec supercronic /app/vodum-cron
