# Provisioning Storage with Logical Volume Manager
The Alpine OS is installed using three disk parititions: boot, swap, and root. The remaining space will be allocated to the Logical Volume Manager (LVM) so you can easily divide it up in whatever way makes sense for your needs. With the exception of creating the partition, everything is automated with a script.

By the ends of this step, you will have:
1. Created a partition of type _Linux LVM_.
2. Initialized the partition as a physical volume. 
3. Created a volume group.
4. Configured LVM to start when the system boots.

## Can I skip it?
You can certainly create your own disk layout if you want. Alternatives to using LVM include creating traditional partitions or simply expanding the root partition to use the remaining space on the SSD.

## Why LVM?
LVM has advantages in flexibility. It's generally easier to resize logical volumes than traditional partitions. This makes it less critical to size the disks correctly from the outset. With LVM, you simply allocate the minimum space you need now, knowing you can expand it in the future.

## Understanding the Scripted Install
The installation script, [setup-lvm.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-lvm.sh), expects that you'll be using partition /dev/sda4 for LVM. If you have a more complex setup, there are variables at the top of the script that you can customize. Though for a single disk Alpine install, you shouldn't need to change anything.

When you run the script, the first step is to install and run cfdisk, a menu-driven partitioning tool. Navigation of the cfdisk options is done using arrow keys, enter, and escape. The only caveat is you must type out the word 'yes' when writing changes. Simply using 'y' or pressing enter will not do anything.

## Running setup-lvm.sh
First, download the [setup-lvm.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-lvm.sh) using wget.

Next, edit and make any neccessary customizations to the LVM_DISK and LVM_PART variables. (Again, most people will not need to do this.)

Finally, run the script.

During the interactive portion of the install, you need to create an LVM type partition in the free space area of the disk.

Here's an example of how most people will proceed with this step:

```
alpine:~# wget https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-lvm.sh
Connecting to raw.githubusercontent.com (185.199.108.133:443)
saving to 'setup-lvm.sh'
setup-lvm.sh         100% |********************************|   164  0:00:00 ETA
'setup-lvm.sh' saved

alpine:~# sh ./setup-lvm.sh
(1/9) Installing libfdisk (2.37.4-r0)
(2/9) Installing libmount (2.37.4-r0)
(3/9) Installing libsmartcols (2.37.4-r0)
(4/9) Installing cfdisk (2.37.4-r0)
(5/9) Installing libaio (0.3.112-r1)
(6/9) Installing device-mapper-event-libs (2.02.187-r2)
(7/9) Installing lvm2-libs (2.02.187-r2)
(8/9) Installing lvm2 (2.02.187-r2)
(9/9) Installing lvm2-openrc (2.02.187-r2)
Executing busybox-1.34.1-r5.trigger
OK: 881 MiB in 163 packages

                                 Disk: /dev/sda
               Size: 40 GiB, 42949672960 bytes, 83886080 sectors
          Label: gpt, identifier: 0AA70338-A23D-C542-8A14-972AFC2147C5

    Device              Start         End     Sectors    Size Type
    /dev/sda1            2048      206847      204800    100M EFI System
    /dev/sda2          206848    16984063    16777216      8G Linux swap
    /dev/sda3        16984064    33761279    16777216      8G Linux filesystem
>>  Free space       33761280    83886046    50124767   23.9G                   

           [   New  ]  [  Quit  ]  [  Help  ]  [  Write ]  [  Dump  ]
           
                                 Disk: /dev/sda
               Size: 40 GiB, 42949672960 bytes, 83886080 sectors
          Label: gpt, identifier: 0AA70338-A23D-C542-8A14-972AFC2147C5

    Device              Start         End     Sectors    Size Type
    /dev/sda1            2048      206847      204800    100M EFI System
    /dev/sda2          206848    16984063    16777216      8G Linux swap
    /dev/sda3        16984064    33761279    16777216      8G Linux filesystem
>>  /dev/sda4        33761280    83886046    50124767   23.9G Linux LVM

     [ Delete ]  [ Resize ]  [  Quit  ]  [  Type  ]  [  Help  ]  [  Write ]

 Are you sure you want to write the partition table to disk? yes

Syncing disks.
  Physical volume "/dev/sda4" successfully created.
  Volume group "vg0" successfully created
  0 logical volume(s) in volume group "vg0" now active
 * service lvm added to runlevel boot
```

The important parts are selecting the _Linux LVM_ partition type and entering the word _yes_ (rather than 'y' or Enter) when asked about writing to disk.

## Verifying Success
Some of the LVM tools you can use to see the logical volumes are:
* pvs or pvdisplay for information about the physical volumes
* vgs or vgdisplay for the volume group
* lvs of lvdisplay for the logical volumes

pvs, vgs, and lvs show only brief information. pvdisplay, vgdisplay, and lvdisplay show more verbose output.

```
alpine:~# pvs
  PV         VG  Fmt  Attr PSize   PFree
  /dev/sda4  vg0 lvm2 a--  <23.90g <23.90g

alpine:~# vgs
  VG  #PV #LV #SN Attr   VSize   VFree
  vg0   1   0   0 wz--n- <23.90g <23.90g

alpine:~# lvs

```

At this point, there are no logical volumes to show. But, you should see physical volume and volume group information. The amount of free space should match the the size of your SSD minus what was allocated to the boot, swap, and root partitions. A 40G disk was used in the example above. 40G (total) - 8G (root) - 8G (swap) - 100M (boot) gives 23.9G for the logical volumes.

## Next Steps
Now that the logical volume manager is setup, it's time to put the space to use. The next thing we'll do is carve out 10G to use for Docker containers and [install Docker Community Edition](02_Docker.md).
