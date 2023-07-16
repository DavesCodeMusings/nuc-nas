LVM_DISK=sda
LVM_PART=sda4

echo "Installing packages"
apk add sfdisk lvm2 lvm2-extra e2fsprogs e2fsprogs-extra

echo "Displaying partition plan"
echo ',+,lvm' | sfdisk -n -a /dev/${LVM_DISK}
echo "Proceed with changes [y/N]?"
read REPLY
[ "$REPLY" != "y" ] || exit 0

echo "Creating LVM partition"
echo ',+,lvm' | sfdisk -a /dev/${LVM_DISK}
partprobe
pvcreate /dev/${LVM_PART}

echo "Creating volume group vg0"
vgcreate vg0 /dev/${LVM_PART}
vgchange -ay

echo "Configuring LVM to start at boot"
rc-update add lvm boot
