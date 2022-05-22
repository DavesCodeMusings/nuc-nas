LVM_DISK=sda
LVM_PART=sda4

echo "Installing packages"
apk add cfdisk lvm2 lvm2-extra e2fsprogs e2fsprogs-extra

echo "Creating LVM partition"
cfdisk /dev/${LVM_DISK}
pvcreate /dev/${LVM_PART}

echo "Creating volume group vg0"
vgcreate vg0 /dev/${LVM_PART}
vgchange -ay

echo "Configuring LVM to start at boot"
rc-update add lvm boot
