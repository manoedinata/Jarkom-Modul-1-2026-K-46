#!/bin/bash

# DIJALANKAN DI: Node "Lain" (Router)
# Simpan file ini sebagai /root/cek_status.sh lalu:
#   chmod +x /root/cek_status.sh
# ============================================================

echo "Interface: "
ip -br a
echo ""

echo "Status tabel NAT (Masquerade): "
iptables -t nat -L -v -n
echo "============================================="
