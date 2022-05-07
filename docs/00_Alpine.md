The first step in building a the system is to add RAM and a solid state disk (SSD) to the NUC. Intel provides a quickstart document with the NUC kit for that task. After that, it's time to install the operating system (OS). For that, we're using Alpine Linux. The Alpine Linux installation is scripted using an answer file.

At the end of this step, you will have Alpine installed and ready to log into via secure shell (SSH) for the remaining installation steps.

## Can I Skip This?
No. But, you can duplicate the process using a virtual machine if you like.

## Why Alpine?
Alpine Linux is small footprint OS and, like the NUC hardware, fits with the minimalist goals of the project.

## Preparing Boot Media
You'll need a bootable ISO image to install Alpine. Go to the [Alpine downloads](https://alpinelinux.org/downloads/) and get the exteneded image for x86_64. You can either burn it to a CD-ROM or write it to a USB flash drive. The Raspberry Pi Imager tool can be used for this if you choose _Use Custom_ as the OS image.

## (Mostly) automated Alpine installation
Here's how it works:

1. Boot the alpine-extended.iso image
2. Temporarily configure with a DHCP address.
3. Fetch [setup-alpine.sh](https://gitea.anubis.home/pi/nuc-nas/src/branch/main/setup-alpine.sh) using wget and a web server of your choice.
4. Run setup-alpine.sh.

### Disabling Secure Boot
When booting the NUC, you will first need to disable secure boot in the setup. You can access the setup by pressing F2 just after powering up.

### Configuring Alpine with a DHCP Address
To get the installation script, you need to be connected to the internet. To get connected you'll need an IP address. The Alpine boot image has a script called _setup-interfaces_ that performs this task. All you need to do is run _setup_interfaces_, answer a few questions. Once you do that and bring the interface up, you'll be connected to your LAN.

In the example below, it's assumed you are using a wired connection to the network.

```
alpine# setup-interfaces
eth0
dhcp
none
n

alpine# ifup eth0
```

### Fetching and Customizing the Automation Script
First, you'll need to get a copy of the [installation script](https://github.com/DavesCodeMusings/nucloud/blob/main/setup-alpine.sh) that generates the answer file. You can use wget.

Next, edit the script changing any of the variables at the top to match your setup. Alpine includes the vi editor with base image. If you're not a fan of vi, you can use the command `apk add nano` to install the nano editor.

Finally, run the script with `sh ./setup-alpine.sh`

Here's an example of the commands:
```
alpine# wget https://github.com/DavesCodeMusings/nucloud/blob/main/setup-alpine.sh
alpine# vi setup-alpine.sh
alpine# sh ./setup-alpine.sh
```

As the script runs, you'll be asked to supply a root password and to confirm the hard drive installation.

When setup is finished, shut down the system and remove the installation media.

## Create a Non-Root User
Even if you're the only user of the system, you're going to need an account besides root to log on with SSH. If you want to install sudo as well, this will give you an experience much like other Linux distributions. Alternatively, you can use the command `su -` to switch to the root account. The instructions below assume you'll be using sudo.

First, log into the system console as root.

Next, use the `adduser` command to create a new user account.

Finally, install sudo and give the new user admin permissions.

```
adduser -g "Proper Dave" dave

addgroup dave wheel
apk add sudo
visudo
```

After running visudo, search for _wheel_ and uncomment one of the lines that allows members of the wheel group to run privileged commands.

## Next Steps
With the basic OS installation complete, you're ready to move on to provisioning storage with the Linux Logical Volume Manager (LVM)
