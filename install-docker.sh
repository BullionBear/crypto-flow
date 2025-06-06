#!/bin/bash

# Exit on error
set -e

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or with sudo"
    exit 1
fi

# Check if Docker is already installed
if command -v docker &> /dev/null; then
    echo "Docker is already installed"
    exit 0
fi

# Check if running on Ubuntu
if [ ! -f /etc/os-release ]; then
    echo "This script is designed for Ubuntu systems"
    exit 1
fi

# Add Docker's official GPG key:
echo "Updating package lists..."
apt-get update
apt-get install -y ca-certificates curl

echo "Installing Docker GPG key..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Verify GPG key
if ! gpg --show-keys /etc/apt/keyrings/docker.asc | grep -q "Docker Release"; then
    echo "Failed to verify Docker GPG key"
    exit 1
fi

# Add the repository to Apt sources:
echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Installing Docker..."
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to docker group
if [ -n "$SUDO_USER" ]; then
    usermod -aG docker "$SUDO_USER"
    echo "Added $SUDO_USER to docker group"
    echo "Please logout and login again for the changes to take effect"
else
    echo "Warning: Could not determine the user to add to docker group"
fi

echo "Docker installation completed successfully"
