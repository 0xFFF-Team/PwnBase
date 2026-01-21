#!/bin/bash
# Install pwndbg GDB plugin

set -e

echo "Installing pwndbg..."

# Clone pwndbg
cd /tmp
git clone --depth 1 https://github.com/pwndbg/pwndbg.git

# Install pwndbg
cd pwndbg
./setup.sh

# Copy to /opt for persistence
mkdir -p /opt/pwndbg
cp -r . /opt/pwndbg/

# Clean up
cd /
rm -rf /tmp/pwndbg

echo "pwndbg installed successfully"
