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
TODO
```

## Next Steps

TODO
