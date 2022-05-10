LVM_DISK=sda
LVM_PART=sda4

apk add cfdisk lvm2 lvm2-extra e2fsprogs e2fsprogs-extra
cfdisk /dev/${LVM_DISK}
pvcreate /dev/${LVM_PART}
vgcreate vg0 /dev/${LVM_PART}
vgchange -ay
rc-update add lvm boot
