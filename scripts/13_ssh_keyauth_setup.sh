#!/bin/bash

# DIJALANKAN DI: Node "Knights"
# Install OpenSSH Server, aktifkan public key auth, & buat user
# mika_admin
# ------------------------------------------------------------
apt-get update && apt-get install openssh-server -y

sed -i 's/^#\s*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#\s*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

service ssh restart

useradd -m mika_admin && echo "mika_admin:mika_admin" | chpasswd

# ------------------------------------------------------------
# DIJALANKAN DI: Node "Mika"
# Buat SSH keypair, copy public key ke Knights, lalu login tanpa
# password
# ------------------------------------------------------------
KNIGHTS_IP="192.234.3.2"

ssh-keygen -t rsa -b 2048 -N '' -f ~/.ssh/id_rsa
ssh-copy-id -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa.pub "mika_admin@$KNIGHTS_IP"

# Login (setelah key ter-copy, seharusnya tanpa diminta password)
ssh "mika_admin@$KNIGHTS_IP"

echo "Tangkap dengan Wireshark filter: ssh. Cek paket Protocol Version Exchange & Key Exchange."
echo "Kredensial tidak terlihat plaintext karena sesi SSH dienkripsi setelah key exchange (berbeda dengan Telnet)."
