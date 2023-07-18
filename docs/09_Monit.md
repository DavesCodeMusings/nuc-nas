# Monit for Ensuring System Health

In this step, Monit is installed to monitor the state of various system resources and alert via email when things are outside of normal.

At the end of this step you will have:

* Installed configured Monit to watch over a few common services.
* Created a /etc/monit.d directory to add custom health checks.

## Can I skip it?

Yes. You can use another monitoring tool or forego monitoring entirely.

## Why monit?

Monit's configuration is simple. Once the initial config is done, it only takes a few lines to add another service or filesystem to monitor.

## Understanding the Scripted Install

The [setup-monit.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-monit.sh) script will try to determine your network configuration to configure the Monit web service. If you're using something besides eth0, you'll need to edit the first few lines. Monit will be configured to allow access from the local network.

The setup script will also create configuration files to monitor _sshd_ and _rootfs_, sending alerts when things go outside the normal parameters, and in the case of _sshd_, attempting to restart the service if it's down.

Any additional monitoring will need to be configured in the /etc/monit.d directory.

## Running setup-monit.sh

First download [setup-monit.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-monit.sh)

Next, run `cat /etc/network/interfaces` to check your network setup. If the only interfaces listed are _lo_ and _eth0_, you don't need to make any changes. If not, edit setup-monit first and customize the three variables at the top.

Run the script and check the output against what's shown below.

```
Detecting network configuration for device eth0...
Installing packages
(1/2) Installing monit (5.33.0-r1)
(2/2) Installing monit-openrc (5.33.0-r1)
Executing busybox-1.36.1-r1.trigger
OK: 507 MiB in 138 packages
Configuring monit
Starting monit
 * service monit added to runlevel default
 New Monit id: 322782f38a7679880949fb8d77678ef9
 Stored in '/var/.monit.id'
Control file syntax OK
 * Caching service dependencies ...                                       [ ok ]
 * Starting monit ...                                                     [ ok ]
See https://mmonit.com/wiki/ for configuration examples.
https://mmonit.com/wiki/Monit/EnableSSLInMonit for SSL.
```

## Checking System Health

Open up a web browser on a computer on the same network. Use the address of http://IP.AD.DR.ESS:2812/ to view the system health web page.

## Add Resource Checks

Check the [Monit home page](https://mmonit.com/monit/) and the wiki to find configuration examples to expand your monitoring capabilities. After changing the configuration, test it and reload with the following commands:

```
monit -t
monit reload
```

Run these two commands anytime you make changes.

## Alerting

If you have email working for your server, you can configure Monit to send alerts when things change. Create a new file called _/etc/monit.d/alerts.conf_ with contents similar to what's shown below.

```
set mailserver localhost
set alert monit@server.home
```

Obviously, you'll want to customize the email address, but otherwise it should work as soon as you reload the monit configuration.

```
monit -t
monit reload
```

## Next Steps
At this point, the system is pretty full-featured for such modest hardware. One thing that will tie it all together nicely is a web server with reverse proxy capability. [Nginx](10_Nginx.md) is just such an application and it fits nicely with the containerized applications we've built so far. 
