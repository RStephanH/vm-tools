#!/bin/bash

set -e

echo "🚀 Updating APT package list..."
sudo apt update

echo "📦 Installing common dependencies from APT..."
sudo apt install -y \
    cmake g++ flex bison libpcap-dev libpcre2-dev zlib1g-dev \
    pkg-config libhwloc-dev luajit libssl-dev git build-essential \
    automake autoconf libtool curl wget

WORKDIR="$HOME/snort3-deps"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# ---- libdaq ----
echo "🔧 Cloning and building libdaq..."
if [ ! -d "libdaq" ]; then
    git clone https://github.com/snort3/libdaq.git
fi
cd libdaq
./bootstrap
./configure
make -j"$(nproc)"
sudo make install
cd ..

# ---- libdnet ----
echo "🔧 Cloning and building libdnet..."
if [ ! -d "libdnet" ]; then
    git clone https://github.com/dugsong/libdnet.git
fi
cd libdnet
./configure
make -j"$(nproc)"
sudo make install
cd ..

# ---- Flex (>= 2.6.0) ----
echo "🔧 Cloning and building Flex..."
if [ ! -d "flex" ]; then
    git clone https://github.com/westes/flex.git
fi
cd flex
./autogen.sh
./configure
make -j"$(nproc)"
sudo make install
cd ..

# ---- LuaJIT (if not already installed) ----
if ! command -v luajit >/dev/null; then
    echo "🔧 LuaJIT not found. Building from source..."
    curl -R -O http://luajit.org/download/LuaJIT-2.1.0-beta3.tar.gz
    tar -xvzf LuaJIT-2.1.0-beta3.tar.gz
    cd LuaJIT-2.1.0-beta3
    make -j"$(nproc)"
    sudo make install
    cd ..
fi

echo "✅ All Snort 3 dependencies are installed!"
echo "📁 You can now proceed to build Snort 3 in a clean environment."

