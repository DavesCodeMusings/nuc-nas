## (Mostly) automated Alpine installation
Here's how it works:

1. Boot the alpine-extended.iso image
2. Temporarily configure the NUC with a DHCP address.
3. Fetch [setup-alpine.sh](https://gitea.anubis.home/pi/nuc-nas/src/branch/main/setup-alpine.sh) using wget and a web server of your choice.
4. Run setup-alpine.sh and reboot.
5. Profit!

>### Note
>setup-alpine.sh and all of the other setup-*.sh have configuration variables at the top of each file. Be sure to review the configuration values before running the script.

Here's an example of the commands:
```
alpine# setup-interfaces
eth0
dhcp
n

alpine# ifup eth0

alpine# wget http://anubis.home/nuc-nas/setup-alpine.sh

alpine# sh ./setup-alpine.sh
```

You will be asked for a root password and to confirm the hard drive installation.

When setup is finished:
1. Shut down (with `poweroff` command)
2. Remove installation media
3. Power on

## Create a Non-Root User
Log into the system console as root. Use the `adduser` command to create a new user account. Optionally install sudo and give the new user admin permissions.

```
adduser -g "Proper Dave" dave

addgroup dave wheel
apk add sudo
visudo
```

After running visudo, search for _wheel_ and uncomment one of the lines that allows members of the wheel group to run privileged commands.

## Next Steps
With the basic OS installation complete, you're ready to move on to provisioning storage with the Linux Logical Volume Manager (LVM)
