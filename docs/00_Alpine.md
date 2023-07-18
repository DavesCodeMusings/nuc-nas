# Operating System Installation

The first step in building a the system is to add RAM and a solid state disk (SSD) to the NUC. Intel provides a quickstart document with the NUC kit for that task. After that, it's time to install the operating system (OS). For that, we're using Alpine Linux. The Alpine Linux installation is scripted using an answer file.

At the end of this step, you'll have Alpine installed and ready to log into via secure shell (SSH) for the remaining setup and customization.

## Can I Skip This?
No. But, you can use the Alpine-supplied `setup-alpine` interactive script instead of the automated wrapper script presented here.

## Why Alpine?
Alpine Linux is small footprint OS and, like the NUC hardware, fits with the minimalist goals of the project.

## Understanding the Installation Process
In order to automate as much as possible during the installation, there is a script that creates an _answer file_ allowing you to skip many of the guided setup questions. However, you will first need to get the script. It's just a simple wget command, but with no OS installed yet, there's no network connection. To work around this, the installation is done like this:

1. The system is booted with the Alpine installation media.
2. Alpine's `setup-interfaces` script is used to configure the Ethernet interface for DHCP.
3. The interface is brought up using Alpine's `ifup` command.
4. The automation wrapper script, [setup-alpine.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-alpine.sh), is fetched from GitHub using wget.

## Preparing Boot Media
You'll need a bootable ISO image to install Alpine. Go to the [Alpine downloads](https://alpinelinux.org/downloads/) and get the exteneded image for x86_64. You can either burn it to a CD-ROM or write it to a USB flash drive. The Raspberry Pi Imager tool can be used for this if you choose _Use Custom_ as the OS image.

## Performing (Mostly) Automated Alpine Installation
Here's are the steps at a high level:

1. Boot the alpine-extended.iso image
2. Temporarily configure a DHCP address: `setup-interfaces` then `ifup eth0`
3. Fetch the setup script: `wget https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-alpine.sh`
4. Edit the script to customize: `vi setup-alpine.sh`
5. Run the script to install `sh ./setup-alpine.sh`

More detailed instructions are shown below.

### Disabling Secure Boot
When booting the NUC, you will first need to disable secure boot in the setup. You can access the setup by pressing F2 just after powering up.

### Configuring Alpine with a Temporary DHCP Address
To get the installation script, you need to be connected to the internet. To get connected you'll need an IP address. The Alpine boot image has a script called _setup-interfaces_ that performs this task. All you need to do is run _setup_interfaces_, answer a few questions. Once you do that and bring the interface up, you'll be connected to your LAN.

In the example below, it's assumed you are using a wired connection to the network.

```
localhost login: root
Welcome to Alpine!
localhost:~# setup-interfaces
Available interfaces are: eth0.
Enter '?' for help on bridges, bonding and vlans.
Which one do you want to initialize? (or '?' or 'done') [eth0]
Ip address for eth0? (or 'dhcp', 'none', '?') [dhcp]
Ip address for wlan0? (or 'dhcp', 'none', '?') [dhcp] none
Do you want to do any manual network configuration? (y/n) [n]

localhost:~# ifup eth0
```

### Fetching and Customizing the Automation Script
First, you'll need to get a copy of the [installation script](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-alpine.sh) that generates the answer file. You can use wget.

Next, edit the script changing any of the variables at the top to match your setup. Most of the variable names should be self-explanatory.

>Alpine includes the vi editor with base image. If you're not a fan of vi, you can use the command `apk add nano` to install the nano editor.

### Running setup-alpine.sh
With any customizing now done, you're ready to run the script by tying the command `sh ./setup-alpine.sh` 

As the script runs, you'll be asked to supply a root password and to confirm the hard drive installation. Everything else is automatic. When setup is finished, shut down the system using the `poweroff` command and remove the installation media.

Here's an example of a typical installation:
```
localhost:~# wget https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-alpine.sh
Connecting to raw.githubusercontent.com (185.199.109.133:443)
saving to 'setup-alpine.sh'
setup-alpine.sh      100% |********************************|  1003  0:00:00 ETA
'setup-alpine.sh' saved

localhost:~# vi setup-alpine.sh
KEYBOARD_LAYOUT=us   # First prompt when running setup-keymaps
KEYBOARD_VARIANT=us  # Second prompt when running setup-keymaps
HOSTNAME=alpine
DOMAIN=home
DNS=$(ip route show | awk '/^default/ { print $3 }')  # Assume the router (default gateway) also provides DNS.
BOOT_SIZE=100
ROOT_SIZE=8192
SWAP_SIZE=8192

localhost:~# sh ./setup-alpine.sh
Creating answerfile for /sbin/setup-alpine
Running /sbin/setup-alpine
 * Caching service dependencies ...                                   [ ok ]
 * Setting keymap ...                                                 [ ok ]
Changing password for root
New password:
Retype password:
passwd: password for root changed by root
 * Starting networking ...
 *   lo ...                                                           [ ok ]
 *   eth0 ...                                                         [ ok ]
 * Seeding random number generator ...
 * Saving 256 bits of creditable seed for next boot                   [ ok ]
 * Starting busybox acpid ...                                         [ ok ]
 * Starting busybox crond ...                                         [ ok ]
 * service chronyd added to runlevel default
 * Caching service dependencies ...                                   [ ok ]
 * Starting chronyd ...                                               [ ok ]
Added mirror dl-cdn.alpinelinux.org
Updating repository indexes... done.
 * Starting sshd ...                                                  [ ok ]
WARNING: The following disk(s) will be erased:
  sda   (25.8 GB ATA      VBOX HARDDISK   )
WARNING: Erase the above disk(s) and continue? (y/n) [n] y
Creating file systems...
mkfs.fat 4.2 (2021-01-31)
Installing system on /dev/sda3:
Installing for x86_64-efi platform.
Installation finished. No error reported.
100% ==>
initramfs: creating /boot/initramfs-lts
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-lts
Found initrd image: /boot/initramfs-lts
Warning: os-prober will not be executed to detect other bootable partitions.
Systems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
done

Installation is complete. Please reboot.
Don't forget to remove installation media.
```

## Next Steps
It's considered bad practice to log in as root, so the next thing to do is setup an account for an [admin user](01_AdminUser.md)
