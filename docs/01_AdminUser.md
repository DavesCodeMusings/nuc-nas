# Creating an Admin User Account
Even if you're the only user of the system, you're going to need an account besides root to log on with. Setting up the account with sudo will give you an experience much like other Linux distributions.

By the end of this step you will have:
* Installed sudo
* Created an admin user
* Configured sudo to not require retyping the admin user's password

## Can I skip it?
You can log in as root all the time, though it's not considered a best practice. You can also create a non-privileged user without sudo, instead using `su -` for switching to the root account.

## Why sudo?
The short answer: it's mostly for sanity. Alpine Linux prefers the minimalist `doas` over `sudo`. However, sudo is the defacto standard in nearly every other Linux distro. If you use distros besides Alpine, and you're used to prefixing commands with _sudo_, it's going to be frustrating retraining your brain to type _doas_.

## Understanding the Script
Normally with Alpine Linux, you would use the `adduser` command to create a new user. The `groupadd` command would then be used to assign the user to the _wheel_ group to give sudo access. You could then edit /etc/sudoers to allow the _wheel_ group. What the script does is to combine the these commands and run them in the correct order.

## Configuring an Admin User
First, log into the system console as root.

Next, use wget to fetch the [setup-admin-user.sh]() script.

Optionally, customize the username using the variables at the top of the script.

Finally, run `sh ./setup-admin-user.sh` and supply the password when prompted.

Here's an example of the script being run with the default username of _admin_

```
Installing packages
(1/1) Installing sudo (1.9.13_p3-r2)
Executing busybox-1.36.1-r1.trigger
OK: 234 MiB in 91 packages
Configuring sudo
Creating user account admin
Changing password for admin
New password:
Retype password:
passwd: password for admin changed by root
```

## Testing the Admin User
As a final check to make sure everything is working, you'll want to test ssh login and sudo.

1. Log in as the admin user via ssh
2. Use sudo to start a root shell

For example:

```
ssh admin@IP.AD.DR.ESS
admin@IP.AD.DR.ESS's password:
Welcome to Alpine!

alpine:~$ sudo su -
alpine:~#
```

Notice how the shell prompt changes from a $ to #, indicating root access.

You'll use a similar procedure for all future logins.

## Next Steps
With the admin user configured, it's time to use those sudo powers to start configuring disk space using the [Logical Volume Manager](02_LVM.md)
