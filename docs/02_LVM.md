# Provisioning Storage with Logical Volume Manager
The Alpine OS is installed using three disk parititions: boot, swap, and root. The remaining space will be allocated to the Logical Volume Manager (LVM) so you can easily divide it up in whatever way makes sense for your needs. With the exception of creating the partition, everything is automated with a script.

By the ends of this step, you will have:
1. Created a partition of type _Linux LVM_.
2. Initialized the partition as a physical volume. 
3. Created the volume group, vg0.
4. Configured LVM to start when the system boots.

## Can I skip it?
You can certainly create your own disk layout if you want. Alternatives to using LVM include creating traditional partitions or simply expanding the root partition to use the remaining space on your SSD.

## Why LVM?
LVM has advantages in flexibility. It's generally easier to resize logical volumes than traditional partitions. This makes it less critical to size the disks correctly from the outset. With LVM, you simply allocate the minimum space you need now, knowing you can expand it in the future.

## Understanding the Scripted Install
The installation script, [setup-lvm.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-lvm.sh), expects that you'll be creating a new partition /dev/sda4 for LVM. If this is a fresh install, /dev/sda4 should be fine. If you have a more complex setup, there are variables at the top of the script that you can customize.

When you run the script, you'll be presented with the existing partition table followed by the proposed changes. You must enter 'y' to accept the changes.

## Running setup-lvm.sh
First, download the [setup-lvm.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-lvm.sh) using wget.

Next, edit and make any neccessary customizations to the LVM_DISK and LVM_PART variables. (Again, most people will not need to do this.)

Finally, run the script.

Here's an example of a successful run:

```
Installing packages
OK: 243 MiB in 110 packages
Displaying partition plan
Disk /dev/sda: 32 GiB, 34359738368 bytes, 67108864 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 37E70CAE-BE55-4F47-B3D6-8F2A2B89C705

Old situation:

Device        Start      End  Sectors  Size Type
/dev/sda1      2048   206847   204800  100M EFI System
/dev/sda2    206848 16984063 16777216    8G Linux swap
/dev/sda3  16984064 33761279 16777216    8G Linux filesystem

/dev/sda4: Created a new partition 4 of type 'Linux LVM' and of size 15.9 GiB.
/dev/sda5: Done.

New situation:
Disklabel type: gpt
Disk identifier: 37E70CAE-BE55-4F47-B3D6-8F2A2B89C705

Device        Start      End  Sectors  Size Type
/dev/sda1      2048   206847   204800  100M EFI System
/dev/sda2    206848 16984063 16777216    8G Linux swap
/dev/sda3  16984064 33761279 16777216    8G Linux filesystem
/dev/sda4  33761280 67106815 33345536 15.9G Linux LVM
The partition table is unchanged (--no-act).

Proceed with changes [y/N]? y
Creating LVM partition
Checking that no-one is using this disk right now ... FAILED

This disk is currently in use - repartitioning is probably a bad idea.
Umount all file systems, and swapoff all swap partitions on this disk.
Use the --no-reread flag to suppress this check.

Disk /dev/sda: 32 GiB, 34359738368 bytes, 67108864 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 37E70CAE-BE55-4F47-B3D6-8F2A2B89C705

Old situation:

Device        Start      End  Sectors  Size Type
/dev/sda1      2048   206847   204800  100M EFI System
/dev/sda2    206848 16984063 16777216    8G Linux swap
/dev/sda3  16984064 33761279 16777216    8G Linux filesystem

/dev/sda4: Created a new partition 4 of type 'Linux LVM' and of size 15.9 GiB.
/dev/sda5: Done.

New situation:
Disklabel type: gpt
Disk identifier: 37E70CAE-BE55-4F47-B3D6-8F2A2B89C705

Device        Start      End  Sectors  Size Type
/dev/sda1      2048   206847   204800  100M EFI System
/dev/sda2    206848 16984063 16777216    8G Linux swap
/dev/sda3  16984064 33761279 16777216    8G Linux filesystem
/dev/sda4  33761280 67106815 33345536 15.9G Linux LVM

The partition table has been altered.
Calling ioctl() to re-read partition table.
Re-reading the partition table failed.: Resource busy
The kernel still uses the old table. The new table will be used at the next reboot or after you run partprobe(8) or partx(8).
Syncing disks.
partx: /dev/sda: error adding partitions 1-3
  Physical volume "/dev/sda4" successfully created.
Creating volume group vg0
  Volume group "vg0" successfully created
  0 logical volume(s) in volume group "vg0" now active
Configuring LVM to start at boot
 * service lvm added to runlevel boot
```

There are a few errors and warnings in the output, but these are expected because the disk is in use as it's being changed. The `partx` command is used to refresh the partition table after the changes are made, so the errors can be ignored. Manual verification of changes is covered in the next section.

## Verifying Success
The command `sfdisk -l /dev/sda` can be used to verify the partition table.

```
alpine:~# sfdisk -l /dev/sda
Disk /dev/sda: 32 GiB, 34359738368 bytes, 67108864 sectors

Device        Start      End  Sectors  Size Type
/dev/sda1      2048   206847   204800  100M EFI System
/dev/sda2    206848 16984063 16777216    8G Linux swap
/dev/sda3  16984064 33761279 16777216    8G Linux filesystem
/dev/sda4  33761280 67106815 33345536 15.9G Linux LVM
```

>Some output is truncated for brevity.

Commands `pvs`, `vgs`, and `lvs` will verify the logival volumes.

```
alpine:~# pvs
  PV         VG  Fmt  Attr PSize   PFree
  /dev/sda4  vg0 lvm2 a--  <23.90g <23.90g

alpine:~# vgs
  VG  #PV #LV #SN Attr   VSize   VFree
  vg0   1   0   0 wz--n- <23.90g <23.90g

alpine:~# lvs

```

At this point, there are no logical volumes to show. But, you should see physical volume and volume group information. The amount of free space should match the the size of your SSD minus what was allocated to the boot, swap, and root partitions. A 32G disk was used in the example above. 32G (total) - 8G (root) - 8G (swap) - 100M (boot) gives a little less than 16G for the logical volumes.

## Next Steps
Now that the logical volume manager is setup, it's time to put the space to use. The next thing we'll do is carve out 10G to use for Docker containers and [install Docker Community Edition](03_Docker.md).
