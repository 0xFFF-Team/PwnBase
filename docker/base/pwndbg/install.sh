#!/bin/bash
# Install pwndbg GDB plugin

set -e

echo "Installing pwndbg..."

# Clone pwndbg (full clone needed for checkout)
cd /tmp
git clone https://github.com/pwndbg/pwndbg.git
cd pwndbg

# Detect Python version and checkout appropriate release
PYVER=$(python3 --version | awk '{print $2}')

case "$PYVER" in
    3.8*|3.9*)
        echo "Using pwndbg release 2024.08.29 for Python $PYVER"
        git checkout 2024.08.29
        ;;
    3.6*|3.7*)
        echo "Using pwndbg release 2023.07.17 for Python $PYVER"
        git checkout 2023.07.17
        ;;
    *)
        echo "Using latest pwndbg for Python $PYVER"
        ;;
esac

# Install pwndbg
./setup.sh

# Copy to /opt for persistence
mkdir -p /opt/pwndbg
cp -r . /opt/pwndbg/

# Clean up
cd /
rm -rf /tmp/pwndbg

echo "pwndbg installed successfully"
