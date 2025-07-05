#!/bin/bash
#
# Install git if not already installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing..."
    sudo apt update
    sudo apt install -y git
else
    echo "Git is already installed."
fi

# Clone Snort3 repository
if [ ! -d "snort3" ]; then
    git clone https://github.com/snort3/snort3.git --depth=1
else
    echo "Snort3 repository already cloned."
fi

# Enter into the Snort3 directory
cd snort3 || { echo "Failed to enter snort3 directory"; exit 1; }

# Store the current directory path in a variable
path_to_snorty="$(pwd)"
echo "Path to Snort3: $path_to_snorty"
export path_to_snorty 
./configure_cmake.sh --prefix=$path_to_snorty
cd build
make -j $(nproc) install
