#!/bin/bash

# DIJALANKAN DI: Node "Chisa"
# ============================================================
set -e

apt update
apt install -y telnetd

useradd -m phantom_user 2>/dev/null || true
echo "phantom_user:wired_ghost" | chpasswd

# Pastikan service telnet (via inetd) berjalan
service inetutils-inetd restart 2>/dev/null || service openbsd-inetd restart 2>/dev/null || true

echo "Telnetd siap. Login dari node Eiri dengan: telnet 192.234.2.2"
echo "Tangkap dengan Wireshark filter: telnet, lalu klik kanan -> Follow -> TCP Stream."
