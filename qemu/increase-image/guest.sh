#!/usr/bin/env bash
# Print current disk layout
lsblk

# If using a single root partition (e.g., /dev/vda1), grow it using 'growpart'
# Install growpart if needed
sudo apt update
sudo apt install -y cloud-guest-utils

read -r -p "Enter the root partition :" root_partition
# Grow the partition (assume /dev/vda1 is the root partition)
sudo growpart ${root_partition}

# Resize the filesystem. For ext4:
sudo resize2fs ${root_partition}

# For XFS, use:
# sudo xfs_growfs /

# Optionally, check new size
df -h
