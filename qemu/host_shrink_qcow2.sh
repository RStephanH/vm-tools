#!/bin/bash
# host_shrink_qcow2.sh — Run on the HOST after VM shutdown

# === Configuration ===
VM_IMAGE="my_image.qcow2"              # Change the VM image filename
OUTPUT_IMAGE="shrinked_tmp.qcow2"
BACKUP_IMAGE="${VM_IMAGE}.bak"

echo "⚠️  WARNING: Ensure the VM is shut down before proceeding!"
read -rp "Press ENTER to continue..."

# === Step 1: Backup original image ===
echo "🔄 Backing up $VM_IMAGE to $BACKUP_IMAGE..."
cp -v "$VM_IMAGE" "$BACKUP_IMAGE"

# === Step 2: Convert to shrink unused space ===
echo "🚧 Shrinking image..."
qemu-img convert -O qcow2 "$VM_IMAGE" "$OUTPUT_IMAGE"
if [ $? -ne 0 ]; then
    echo "❌ Error during image conversion. Aborting."
    exit 1
fi

# === Step 3: Replace original image ===
echo "✅ Replacing original image with shrunk version..."
mv -v "$OUTPUT_IMAGE" "$VM_IMAGE"

# === Step 4: Show result ===
echo "ℹ️ Shrinking complete. Image info:"
qemu-img info "$VM_IMAGE"

