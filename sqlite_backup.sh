#!/bin/bash

# Configuration
DB_FILE="$HOME/databases/test_database.sqlite"
BACKUP_DIR="$HOME/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/test_database-$TIMESTAMP.sqlite"
ENCRYPTED_FILE="$BACKUP_FILE.enc"
PASSPHRASE="secret"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Copy SQLite database to backup location
cp "$DB_FILE" "$BACKUP_FILE"

# Encrypt backup using AES-256
openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 -in "$BACKUP_FILE" -out "$ENCRYPTED_FILE" -pass pass:"$PASSPHRASE"

# Remove unencrypted backup
rm -f "$BACKUP_FILE"

echo "Backup completed and encrypted: $ENCRYPTED_FILE"
