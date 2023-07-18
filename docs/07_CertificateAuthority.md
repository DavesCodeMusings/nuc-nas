# Certificate Authority for Secure Connections
In this step, we'll set up a self-hosted certificate authority (CA). Having your own CA allows you to create SSL certificates for the various devices and services on your network.

By the end of this step you will have:
* A self-signed root CA certificate
* An intermediate CA certificate
* A certificate for the host with wildcard subdomains.

## Can I skip it?
Yes. You can simply use unencrypted communication. Or you can use a publict certificate service like Let's Encrypt.

## Why Self-Signed Certificates
Probably the biggest reason is to be able to use https links for the web-based services on your hosts and stop those _this connection is insecure_ messages. Having your own CA means you can secure as many devices as you like. And if you copy the signing certificate to your devices, they will all trust your certificates.

## Understanding the Script
The certificate issuing process goes like this:

1. The device needing a certificate creates a private key and uses that key to create a certificate signing request.
2. The request is presented to the certificate authority and signed with the CA's certificate.
3. The device now has a signed certificate it can use for encryption.

The only exception is the root CA has to sign its own certificate, since it is at the base of everything. All of these steps are scripted for the root CA certificate, the intermediate CA certificate, and a host certificate.

## Prerequisites
The certificate generating script relies on information gathered from the `hostname` command. Specifically, `hostname -s` to determine the host, `hostname -d` to determine the domain, and `hostname -i` to determine the IP address. If any of these commands is returning incomplete or erroneous information, or you do not yet have a static IP address, this needs to be fixed before running the script.

The easiest way to fix the information comming from `hostname` is by adding a single line in /etc/hosts that looks like this:

```
192.168.1.100  host.domain.name  host
```

>You'll need to customize the information to match your setup.

## Creating the Certificate Authority
First, download the [setup-cert-authority.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-cert-authority.sh) script.

Next, edit the script to customize the variables at the top.

Finally, run the script to generate the root and intermediate certificates.

>You must provide the city, state or province, and country code or the script will refuse to run. Anything that has spaces must be quoted. For example, CITY="New York".

Here's an example:

```
alpine:~# wget https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-cert-authority.sh
Connecting to raw.githubusercontent.com (185.199.108.133:443)
saving to 'setup-cert-authority.sh'
setup-cert-authority 100% |********************************|  2114  0:00:00 ETA
'setup-cert-authority.sh' saved

alpine:~# vi setup-cert-authority.sh
CITY=Madison
STATE_PROVINCE=Wisconsin
COUNTRY=US

alpine:~# sh ./setup-cert-authority.sh
Verifying settings
HOME_CA
192.168.0.20 alpine.home
Madison, Wisconsin
US
Verifying directories
Creating root CA config
Creating root CA
Certificate request self-signature ok
subject=C = US, ST = Wisconsin, L = Madison, O = HOME_CA, CN = HOME_CA
Creating intermediate CA config
Creating intermediate CA
Certificate request self-signature ok
subject=C = US, ST = Wisconsin, L = Madison, O = home, CN = home
Creating host certificate config
Creating host certificate
Certificate request self-signature ok
subject=C = US, ST = Wisconsin, L = Madison, O = home, CN = alpine.home
Cleaning up temporary files
```

You'll see information about your host after _Verify settings_. If the script stops here, something is missing.

You should see three lines with a _Certificate request self-signature ok_ message. These are for the root CA, the intermediate CA, and the host certificate, respectively.

>Some output has been truncated for brevity.

## Finding the Certificates
You will find your certificates and keys in the system directories /etc/ssl/certs and /etc/ssl/private.

```
alpine:~# ls /etc/ssl/certs
HOME_CA.crt  alpine.crt  ca-certificates.crt  home.crt
alpine:~# ls /etc/ssl/private
HOME_CA.key  alpine.key  home.key
```

## Using the Certificates
The root and intermediate (HOME_CA and home) aren't used to secure web servers and other devices directly. They are used to sign other certificates that are then used to secure a device.

A detailed discussion of how to sign certificates is beyond the scope of this document, but you can find plenty of resources by serching the web for "how to self sign a certificate". You can also reverse engineer the host certificate portion of the setup-cert-authority.sh script.

## Next Steps
TODO
