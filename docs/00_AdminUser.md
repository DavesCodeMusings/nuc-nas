
## Creating a Non-Root User Account
Even if you're the only user of the system, you're going to need an account besides root to log on with SSH. If you want to install sudo as well, this will give you an experience much like other Linux distributions. Alternatively, you can use the command `su -` to switch to the root account. The instructions below assume you'll be using sudo.

First, log into the system console as root.

Next, use the `adduser` command to create a new user account.

Finally, install sudo and give the new user admin permissions.

Here's a typical setup with a user named Dave:

```
alpine:~# adduser -g "Proper Dave" dave
Changing password for dave
New password:
Retype password:
passwd: password for dave changed by root

alpine:~# addgroup dave wheel

alpine:~# apk add sudo
(1/1) Installing sudo (1.9.8_p2-r1)
Executing busybox-1.34.1-r5.trigger
OK: 873 MiB in 154 packages

alpine:~# visudo
##
## User privilege specification
##
root ALL=(ALL) ALL

## Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL) ALL

## Same thing without a password
%wheel ALL=(ALL) NOPASSWD: ALL
```

Notice how the line `%wheel ALL=(ALL) NOPASSWD: ALL` has been uncommented. This will let any user in the _wheel_ group (like dave) to use sudo without being prompted for their password.

