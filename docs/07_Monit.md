# Monit for Ensuring System Health

In this step, Monit is installed to monitor the state of various system resources and alert via email when things are outside of normal.

At the end of this step you will have:

* Installed configured Monit to watch over a few common services.
* Created a /etc/monit.d directory to add custom health checks.

## Can I skip it?

Yes. You can use another monitoring tool or forego monitoring entirely.

## Why monit?

Monit's configuration is simple. Once the initial config is done, it only takes a few lines to add another service or filesystem to monitor.

## Understanding the scripted install

The [setup-monit.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-monit.sh) script will try to determine your network configuration to configure the Monit web service. If you're using something besides eth0, you'll need to edit the first few lines. Monit will be configured to allow access from the local network.

The setup script will also create configuration files to monitor _sshd_ and _rootfs_, sending alerts when things go outside the normal parameters, and in the case of _sshd_, attempting to restart the service if it's down.

Any additional monitoring will need to be configured in the /etc/monit.d directory.

## Running setup-monit.sh

