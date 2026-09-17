#!/bin/bash

# DIJALANKAN DI: Node "Knights"
# ============================================================
set -e

FTP_SERVER="192.234.2.2"   # IP FTP Server Chisa
FILE_ID="1lFepK4wFmx55PnRki3NsHW-ivudSR0vg"
FILE_NAME="knights_report.zip"

# Unduh file laporan dari Google Drive
./gdrive_download.sh "$FILE_ID" "$FILE_NAME"

# Upload file ke FTP Server Chisa menggunakan akun alice
lftp -u alice,alice "$FTP_SERVER" -e "put $FILE_NAME; bye"

echo "Selesai upload $FILE_NAME ke $FTP_SERVER"
echo "Cek di Wireshark (filter: ftp or ftp-data) untuk STOR, kode 226, dan port PASV"
