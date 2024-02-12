#!/bin/bash

# This script still need to check

# Step 1: Download the Go tar.gz file
wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz

# Step 2: Extract the file to /usr/local
tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz

# Step 3: Remove the tar.gz file
rm go1.22.0.linux-amd64.tar.gz

# Step 4: Add Go bin to PATH in .profile in an idempotent way
if ! grep -q '/usr/local/go/bin' $HOME/.profile; then
    echo 'if [ -d "/usr/local/go/bin" ] ; then' >> $HOME/.profile
    echo '    PATH="/usr/local/go/bin:$PATH"' >> $HOME/.profile
    echo 'fi' >> $HOME/.profile
fi

# Reload .profile to apply changes
source $HOME/.profile

# Optional: Print Go version to verify installation
go version
