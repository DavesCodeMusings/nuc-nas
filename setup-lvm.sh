LVM_DISK=sda
LVM_PART=4

if [ -b /dev/${LVM_DISK}${LVM_PART} ]; then
  echo "Cowardly refusing to overwrite existing partition!"
  exit 1
fi

echo "Installing packages"
apk add sfdisk partx lvm2 lvm2-extra e2fsprogs e2fsprogs-extra

echo "Displaying partition plan"
echo ',+,lvm' | sfdisk --no-act --append /dev/${LVM_DISK}
echo
echo -n "Proceed with changes [y/N]? "
read REPLY
[ "$REPLY" == "y" ] || exit 0

echo "Creating LVM partition"
echo ',+,lvm' | sfdisk --quiet --force --append /dev/${LVM_DISK}
partx -a -n${LVM_PART} /dev/${LVM_DISK}
pvcreate /dev/${LVM_DISK}${LVM_PART}

echo "Creating volume group vg0"
vgcreate vg0 /dev/${LVM_DISK}${LVM_PART}
vgchange -ay

echo "Configuring LVM to start at boot"
rc-update add lvm boot
