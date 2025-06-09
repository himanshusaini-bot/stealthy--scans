#!/bin/bash

echo "[*] Updating system..."
sudo apt update

echo "[*] Installing required tools..."
sudo apt install -y nmap snmp smbclient masscan hydra tcpdump netcat python3 python3-pip

echo "[*] Installing Python packages..."
pip3 install -r requirements.txt

echo "[*] All dependencies installed!"
