#!/bin/bash
apt-get update
apt-get install -y net-tools
apt-get install -y build-essential
apt-get install -y htop
# Add WezTerm repository
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/wezterm-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/wezterm-archive-keyring.gpg] https://apt.fury.io/wez/ * *" | sudo tee /etc/apt/sources.list.d/wezterm.list
apt-get update
apt-get install -y wezterm