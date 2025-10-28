#!/usr/bin/env bash
# Print current disk layout
lsblk

# If using a single root partition (e.g., /dev/vda1), grow it using 'growpart'
# Install growpart if needed
sudo apt update
sudo apt install -y cloud-guest-utils

read -r -p "Enter the number_root_partition :" number_root_partition
read -r -p "Enter the root partition :" root_partition
# Grow the partition (assume /dev/vda1 is the root partition)
sudo growpart ${root_partition}

# Resize the filesystem. For ext4:
sudo resize2fs ${root_partition}

#For LLVM 
# 2. Resize the physical volume
sudo pvresize /dev/vda3

# 3. Find your logical volume path (replace 'vgname/lvname' accordingly)
sudo lvdisplay
# Extend logical volume to all free space
sudo lvextend -l +100%FREE /dev/mapper/vgname-lvname

# 4. Resize the filesystem (substitute with xfs_growfs for XFS)
# For ext4:
sudo resize2fs /dev/mapper/vgname-lvname
# For XFS:
# sudo xfs_growfs /mount/point

# 5. Confirm disk usage
df -h
# For XFS, use:
# sudo xfs_growfs /

# Optionally, check new size
df -h
