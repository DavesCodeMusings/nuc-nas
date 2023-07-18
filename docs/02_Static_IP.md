# Setting a Static IP
So far the system has been relying on DHCP to get its IP address, gateway, and name servers. The DHCP server assigns addresses from a range of IPs and there's no guarantee a host will get the same one each time. While this is fine for mot devices, a server should have a predictable IP address. This step will take care of that.

By the end of this step you will have:
* A static configuration for the IP and network parameters
* A DNS resolver configuration appropriate for your setup.
* An entry in the /etc/hosts file for important addresses on your network

## Can I skip it?
You may be able to configure your router with a DHCP reservation to achieve the same results, but you should consider adding an /etc/hosts file entry for your host at the very least.

## Why a Static IP?
Besides having a predictable way of reaching your server, you have the option of adding services like intranet mail, DNS, web, and others that rely on an unchanging address.

## Why /etc/hosts?
With DNS available, /etc/hosts may seem like a throwback to the early days of the ARPAnet, but it has its uses. For one, the `hostname` command relies on the informaation in /etc/hosts to provide the domain name and IP address when the -d and -i options are used. Without /etc/hosts, the information cannot be retrieved.

## Understanding the Script
The script will overwrite the following files: /etc/network/interfaces, /etc/hosts, and /etc/resolv.conf. In the end, it will look very much like a fresh install of the operating system. If you have customized these files at all, those changes will be lost. In that case, it's better to edit by hand.

## Configuring Network Parameters

