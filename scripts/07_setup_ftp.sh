#!/bin/bash

# DIJALANKAN DI: Node "Chisa"
# Simpan file ini sebagai /root/setup_ftp.sh (container ephemeral,
# jalankan ulang tiap kali container restart).
# ============================================================
set -e

echo "=== Install vsftpd ==="

apt update
apt install -y vsftpd

echo "=== Membuat shared folder ==="

mkdir -p /var/wired/data
chmod 777 /var/wired/data

echo "=== Membuat user FTP ==="

useradd -m alice 2>/dev/null || true
echo "alice:alice" | chpasswd

useradd -m mika 2>/dev/null || true
echo "mika:mika" | chpasswd

useradd -m eiri 2>/dev/null || true
echo "eiri:eiri" | chpasswd

echo "=== Konfigurasi vsftpd ==="

cat > /etc/vsftpd.conf <<'EOF'
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
chroot_local_user=YES
local_root=/var/wired/data
allow_writeable_chroot=YES
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=YES
user_config_dir=/etc/vsftpd_user_conf
EOF

echo "=== Membuat userlist ==="

cat > /etc/vsftpd.userlist <<'EOF'
# Blacklist eiri
eiri
EOF

echo "=== Membuat konfigurasi per-user ==="

mkdir -p /etc/vsftpd_user_conf

cat > /etc/vsftpd_user_conf/mika <<'EOF'
write_enable=NO
EOF

cat > /etc/vsftpd_user_conf/alice <<'EOF'
# Alice memiliki akses Read-Write
EOF

echo "=== Restart vsftpd ==="

service vsftpd restart

echo "=== Selesai ==="
