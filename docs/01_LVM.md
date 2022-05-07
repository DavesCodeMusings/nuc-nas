# Provisioning Storage with Logical Volume Manager
The Alpine OS is installed using three disk parititions: boot, swap, and root. The remaining space will be allocated to the Logical Volume Manager (LVM) so you can easily divide it up in whatever way makes sense for your needs. With the exception of creating the partition, everything is [automated with a script](https://github.com/DavesCodeMusings/nucloud/blob/main/setup-lvm.sh).

By the ends of this step, you will have:
1. Created a partition of type _Linux LVM_.
2. Initialized the partition as a physical volume. 
3. Created a volume group.
4. Configured LVM to start when the system boots.

## Can I skip it?
You can certainly create your own disk layout if you want. Alternatives to using LVM include creating traditional partitions or simply expanding the root partition to use the remaining space on the SSD.

## Why LVM?
LVM has advantages in flexability. It's generally easier to resize logical volumes than traditional partitions. This makes it less critical to size the disks correctly from the outset. With LVM, you simply allocate the minimum space you need now, knowing you can expand it in the future.

## Understanding the Scripted Install


## Running setup-lvm.sh
