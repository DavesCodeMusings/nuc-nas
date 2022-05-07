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
The installation script, [setup-lvm.sh](https://github.com/DavesCodeMusings/nucloud/blob/main/setup-lvm.sh), expects that you'll be using partition /dev/sda4 for LVM. If you have a more complex setup, there are variables at the top of the script that you can customize. Though for a single disk Alpine install, you shouldn't need to change anything.

When you run the script, the first step is to install and run cfdisk, a menu-driven partitioning tool. Navigation of the cfdisk options is done using arrow keys, enter, and escape. The only caveat is you must type out the word 'yes' when writing changes. Simply using 'y' or pressing enter will not do anything.

## Running setup-lvm.sh
First, download the [setup-lvm.sh](https://github.com/DavesCodeMusings/nucloud/blob/main/setup-lvm.sh) using wget.

Next, edit and make any neccessary customizations to the LVM_DISK and LVM_PART variables. (Again, most people will not need to do this.)

Finally, run the script.

Here's an example of how most people will proceed with this step:

```
wget https://github.com/DavesCodeMusings/nucloud/blob/main/setup-lvm.sh
sh ./setup-lvm.sh
```

## Verifying Success
Some of the LVM tools you can use to see the logical volumes are:
* pvs or pvdisplay for information about the physical volumes
* vgs or vgdisplay for the volume group
* lvs of lvdisplay for the logical volumes

pvs, vgs, and lvs show only brief information. pvdisplay, vgdisplay, and lvdisplay show more verbose output.

At this point, there are no logical volumes to show. But, you should see physical volume and volume group information. The amount of free space should match the the size of your SSD minus what was allocated to the boot, swap, and root partitions.

## Next Steps
Now that the logical volume manager is setup, it's time to put the space to use. The next thing we'll do is carve out 10G to use for [Docker containers](02_Docker.md).
