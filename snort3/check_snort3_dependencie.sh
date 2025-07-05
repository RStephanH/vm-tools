#!/bin/bash

# Array of dependencies
dependencies=(
    "cmake"
    "daq"
    "libdnet"
    "g++"
    "flex"
    "hwloc"
    "luajit"
    "openssl"
    "libpcap-dev"
    "libpcre2-dev"
    "pkg-config"
    "zlib1g-dev"
)

# Check if script is run with sudo privileges
if [ "$EUID" -ne 0 ]; then
    echo "This script requires sudo privileges. Please run as root or with sudo."
    exit 1
fi

# Update package lists
echo "Updating package lists..."
apt-get update >/dev/null 2>&1

# Check each dependency
for dependency in "${dependencies[@]}"; do
    echo "Checking for $dependency..."
    if apt-cache policy "$dependency" >/dev/null 2>&1; then
        echo "$dependency is available in the apt repository."
    else
        echo "$dependency not found in the apt repository."
    fi
done
