# Exim and Dovecot for Intranet Email
In this step, Exim is configured as a mail transfer agent and 

At the end of this step, you will have:
* Installed the Exim and Dovecot APKs along with the mailx client for testing.
* Configured Exim and Dovecot for local mail delivery.

## Can I skip it?
Yes. Local email delivery is mostly for receiving automated system messages. You don't have to use it.

## Why Exim and Dovecot?
The main reason for having email setup on the system is to deliver notifications from any cron jobs or other system processes.

Exim is probably the most straightforward of any email server. The default configuration only needs two minor changes to make it usable.

Dovecot is a little more complex, but compared to its peers, it's not too bad. The installation script simplifies things by putting the minimum required config in a single file called _/etc/dovcot/dovecot.conf_ rather than the multitude of include files that are delivered with the package.

## Understanding the Scripted Install
[setup-email.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-email.sh) automates the following tasks:
1. Install Exim, Dovecot, and mailx APKs.
2. Fix permissions on the mailbox directory.
3. Configure Exim to use directory style mail delivery.
4. Configure Dovecot as an IMAP mail server.
5. Start both server demons and configure them to start at boot.

There's nothing in the script that requires customization.

## Running setup-email.sh

When the automated installation steps run, the output should be similar to what is shown below.

```
Fixing permissions on /var/mail
Installing packages
(1/16) Installing libbz2 (1.0.8-r5)
(2/16) Installing icu-data-en (73.2-r2)
Executing icu-data-en-73.2-r2.post-install
*
* If you need ICU with non-English locales and legacy charset support, install
* package icu-data-full.
*
(3/16) Installing libgcc (12.2.1_git20220924-r10)
(4/16) Installing libstdc++ (12.2.1_git20220924-r10)
(5/16) Installing icu-libs (73.2-r2)
(6/16) Installing libsodium (1.0.18-r3)
(7/16) Installing dovecot (2.3.20-r10)
Executing dovecot-2.3.20-r10.pre-install
Executing dovecot-2.3.20-r10.post-install
-----
subject=OU = IMAP server, CN = imap.example.com, emailAddress = postmaster@example.com
SHA1 Fingerprint=B0:39:69:25:84:F3:7A:73:9C:0E:86:B0:C2:D1:4B:6F:D9:89:EA:0B
(8/16) Installing dovecot-openrc (2.3.20-r10)
(9/16) Installing libspf2 (1.2.11-r2)
(10/16) Installing tdb-libs (1.4.8-r1)
(11/16) Installing exim (4.96-r2)
Executing exim-4.96-r2.pre-install
(12/16) Installing exim-openrc (4.96-r2)
(13/16) Installing libmd (1.0.4-r2)
(14/16) Installing libbsd (0.11.7-r1)
(15/16) Installing liblockfile (1.17-r3)
(16/16) Installing mailx (8.1.2_git20220412-r1)
Executing busybox-1.36.1-r1.trigger
OK: 506 MiB in 136 packages
Configuring exim
Starting exim
 * service exim added to runlevel default
 * Caching service dependencies ...                                       [ ok ]
 * Starting exim ...                                                      [ ok ]
Configuring Dovecot
Setting up IMAP user credential store
Starting Dovecot
 * service dovecot added to runlevel default
 * /run/dovecot: creating directory                                       [ ok ]
 * Starting dovecot ...                                                   [ ok ]
Create user passwords with: doveadm pw -s sha512-crypt
Add them to /etc/dovecot/passwd like this: username:password
```

## Setting up aliases

The root user can't log on via IMAP, so you'll probably want to edit /etc/mail/aliases to send root's mail to a regular user. Be sure to run the command `newaliases` to make the changes take effect when you're done. This is usually enough to ensure system messages make it to your inbox.

## Next Steps
TODO
