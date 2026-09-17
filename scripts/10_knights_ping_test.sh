#!/bin/bash

# DIJALANKAN DI: Node "Knights"
# ============================================================

CHISA_IP="192.234.2.2"

ping -c 77 -s 128 -i 0.3 "$CHISA_IP"

echo "Buka Wireshark & filter 'icmp' untuk analisis Type/Code, RTT, dan packet loss."
