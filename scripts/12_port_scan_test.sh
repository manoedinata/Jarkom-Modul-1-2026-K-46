#!/bin/bash

# DIJALANKAN DI: Node "Knights"
# Buka listener di port 22 & 80 (port 7777 sengaja dibiarkan
# tertutup / tidak ada listener)
# ------------------------------------------------------------
nc -lvp 80 &
nc -lvp 22 &

# ------------------------------------------------------------
# DIJALANKAN DI: Node "Alice"
# Scan port terbuka (22, 80) dan port tertutup (7777) milik Knights
# ------------------------------------------------------------
KNIGHTS_IP="192.234.3.2"

nc -zv "$KNIGHTS_IP" 22 80
nc -zv "$KNIGHTS_IP" 7777

echo "Bandingkan TCP flag di Wireshark: SYN-ACK (port terbuka) vs RST-ACK (port tertutup)."
