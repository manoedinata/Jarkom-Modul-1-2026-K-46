#!/bin/bash

# DIJALANKAN DI: Node "Lain" (Router)
# Aktifkan packet forwarding & NAT Masquerade (dan pastikan
# tetap aktif setelah eth0 up / reboot)
# ------------------------------------------------------------
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

cat >> /etc/network/interfaces <<'EOF'

# IP Forwarding dan NAT agar klien bisa dapat akses internet
up sysctl -w net.ipv4.ip_forward=1
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
EOF

service networking restart 2>/dev/null || /etc/init.d/networking restart

# ------------------------------------------------------------
# DIJALANKAN DI: Node Client (Alice/Mika/Chisa/Knights/Eiri)
# Tambahkan DNS nameserver agar bisa resolve domain (google.com)
# ------------------------------------------------------------
echo "nameserver 8.8.8.8" > /etc/resolv.conf

cat >> /etc/network/interfaces <<'EOF'

# Soal 4 - DNS Nameserver otomatis saat eth0 up
up echo "nameserver 8.8.8.8" > /etc/resolv.conf
EOF

service networking restart 2>/dev/null || /etc/init.d/networking restart
