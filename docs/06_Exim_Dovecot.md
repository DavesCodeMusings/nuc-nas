# Exim and Dovecot for intranet email
In this step, Exim is configured as a mail transfer agent and 

At the end of this step, you will have:
* Installed the Exim and Dovecot APKs along with the mailx client for testing.
* Configured Exim and Dovecot for local mail delivery.

## Can I skip it?
Yes. Local email delivery is mostly for receiving automated system messages. You don't have to use it.

## Why Exim and Dovecot?
Exim is probably the most straightforward of any email server. Dovecot is a little more complex, but compared to its peers, it's not too bad. 

## Understanding the Scripted Install
[setup-email.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-email.sh) automates the following tasks:
1. Install Exim, Dovecot, and mailx APKs.
2. Fix permissions on the mailbox directory.
3. Configure Dovecot as an IMAP mail server.
4. Start both server demons and configure them to start at boot.

There's nothing in the script that requires editing.

## Running setup-email.sh

When the automated installation steps run, the output should be similar to what is shown below.

```
TODO
```

## Next Steps

TODO
