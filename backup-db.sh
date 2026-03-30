#!/bin/bash
# =============================================================================
# Encrypted and compressed PostgreSQL backup
# =============================================================================

DATE=$(date -u +"%Y-%m-%d %H:%M:%S.%3N UTC")
FILENAME_DATE="${DATE// /_}"
FILENAME_DATE="${FILENAME_DATE//:/_}"
DB_NAME="db_name"
BACKUP_DIR="/root/backups"

mkdir -p $BACKUP_DIR

echo "$DATE LOG: starting database backup"

docker compose --project-name dvi-production exec -T db \
    pg_dump -U postgres -d "$DB_NAME" --clean --if-exists | \
    gzip --best | \
    gpg --symmetric --cipher-algo AES256 --batch --passphrase-file /root/.backup-pass \
    -o "$BACKUP_DIR/dvi-app-$FILENAME_DATE.sql.gz.gpg"

BACKUP_SIZE=$(du -h "$BACKUP_DIR/dvi-app-$FILENAME_DATE.sql.gz.gpg" | cut -f1)

echo "$DATE LOG: backup completed: $BACKUP_DIR/dvi-app-$FILENAME_DATE.sql.gz.gpg ($BACKUP_SIZE)"

# Keep only last 14 backups
find "$BACKUP_DIR" -type f -name "*.sql.gz.gpg" -mtime +14 -delete

echo "$DATE LOG: old backups cleaned up; backup process finished"
