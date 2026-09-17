#!/bin/bash

# DIJALANKAN DI: Node "Lain" (Router)
# Set IP pada tiap interface yang mengarah ke Switch (gateway
# tiap segmen). Sesuaikan nama interface (eth1/eth2/eth3) dengan
# urutan link Switch di topologi GNS3.
# ------------------------------------------------------------
cat >> /etc/network/interfaces <<'EOF'

# IP Gateway untuk Switch 1 (Alice, Mika)
auto eth1
iface eth1 inet static
	address 192.234.1.1
	netmask 255.255.255.0

# IP Gateway untuk Switch 2 (Chisa)
auto eth2
iface eth2 inet static
	address 192.234.2.1
	netmask 255.255.255.0

# IP Gateway untuk Switch 3 (Knights, Eiri)
auto eth3
iface eth3 inet static
	address 192.234.3.1
	netmask 255.255.255.0
EOF

service networking restart 2>/dev/null || /etc/init.d/networking restart

# ------------------------------------------------------------
# DIJALANKAN DI: Node Client (Alice/Mika/Chisa/Knights/Eiri)
# Sesuaikan address & gateway sesuai node & switch tempat client
# tersambung (lihat pemetaan IP di atas). Contoh di bawah untuk
# Alice (Switch 1, IP .2).
# ------------------------------------------------------------
cat >> /etc/network/interfaces <<'EOF'

# Static config for eth0 (ganti address sesuai node)
auto eth0
iface eth0 inet static
	address 192.234.1.2
	netmask 255.255.255.0
	gateway 192.234.1.1
EOF

service networking restart 2>/dev/null || /etc/init.d/networking restart
