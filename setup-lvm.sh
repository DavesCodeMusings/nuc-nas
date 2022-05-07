LVM_DISK=sda
LVM_PART=sda4

apk add cfdisk lvm2
cfdisk /dev/${LVM_DISK}
pvcreate /dev/${LVM_PART}
vgcreate vg0 /dev/${LVM_PART}
vgchange -ay
rc-update add lvm boot
