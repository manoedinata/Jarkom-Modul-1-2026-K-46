#!/bin/bash

# DIJALANKAN DI: Node "Chisa"
# Unduh file ke folder shared FTP agar bisa diakses Mika
# ------------------------------------------------------------
cd /var/wired/data/
./gdrive_download.sh 1tKZu0rcti4t-fXX4jtXDSKDBWzsawfoN protocol7_manifesto.zip

# ------------------------------------------------------------
# DIJALANKAN DI: Node "Mika"
# Login FTP dengan akun mika (read-only): unduh file, lalu coba
# upload untuk membuktikan pembatasan write
# ------------------------------------------------------------
FTP_SERVER="192.234.2.2"   # IP FTP Server Chisa
FILE_NAME="protocol7_manifesto.zip"

lftp -u mika,mika "$FTP_SERVER" -e "get $FILE_NAME; bye"

# Percobaan upload harus gagal: 550 Permission denied
lftp -u mika,mika "$FTP_SERVER" -e "put $FILE_NAME; bye" || true
