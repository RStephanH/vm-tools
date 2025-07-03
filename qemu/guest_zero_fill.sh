#!/bin/bash
# guest_zero_fill.sh — Run INSIDE the Linux VM

echo "🔧 Zeroing out free space to make image shrinkable..."
sleep 2

sudo dd if=/dev/zero of=~/zero.fill bs=1M status=progress || true
sudo rm -f ~/zero.fill
sync

echo "✅ Done. Shutting down the VM..."
sudo poweroff

