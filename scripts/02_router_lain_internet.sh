#!/bin/bash
set -e

cat >> /etc/network/interfaces <<'EOF'

# Soal 2 - eth0 tersambung ke NAT (internet publik) via DHCP
auto eth0
iface eth0 inet dhcp
    hostname lain
EOF

# Terapkan konfigurasi
service networking restart 2>/dev/null || /etc/init.d/networking restart

echo "Cek hasil dengan: ip a"
