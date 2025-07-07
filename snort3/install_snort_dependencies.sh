#!/bin/bash

# Array of dependencies
dependencies=(
    "cmake"
    "libdaq2"
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
if ! apt-get update >/dev/null 2>&1; then
    echo "Failed to update package lists. Please check your internet connection or apt configuration."
    exit 1
fi

# Check and install each dependency
for dependency in "${dependencies[@]}"; do
    echo "Checking for $dependency..."
    if dpkg -l "$dependency" >/dev/null 2>&1; then
        echo "$dependency is already installed."
    else
        echo "$dependency is not installed. Installing..."
        if apt-cache policy "$dependency" >/dev/null 2>&1; then
            if apt-get install -y "$dependency" >/dev/null 2>&1; then
                echo "$dependency installed successfully."
            else
                echo "Failed to install $dependency. Please check the package name or repository."
            fi
        else
            echo "$dependency not found in the apt repository. Please check the package name or add the appropriate repository."
        fi
    fi
done

echo "Dependency installation check complete."
