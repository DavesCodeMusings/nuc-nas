# Certificate Authority
In this step, we'll set up a self-hosted certificate authority (CA). Having your own CA allows you to create SSL certificates for the various devices and services on your network.

By the end of this step you will have:
1. Created a self-signed root CA certificate
2. Created an intermediate CA certificate
3. Learned how to create certificates for your devices.

## Can I skip it?
Yes. You can simply use unencrypted communication. Or you can use a service like Let's Encrypt.

## Why Self-Signed Certificates
Probably the biggest reason is to be able to use https links for the web-based services on your hosts and stop those _this connection is insecure_ messages. Having your own CA means you can create as many certificates as you like. And if you copy the signing certificate to your devices, they will all trust your certificates.

## Understanding the Script
The certificate issuing process goes like this:

1. The device needing a certificate creates a private key and uses that key to create a certificate signing request.
2. The request is presented to the certificate authority and signed with the CA's certificate.
3. The device now has a signed certificate it can use for encryption.

The only exception is the root CA has to sign its own certificate, since it is at the base of everything. All of these steps are scripted for the root and intermediate CA certificates.

## Creating the Certificate Authority
First, download the [setup-cert-authority.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-cert-authority.sh) script.

Next, edit the script to customize the variables at the top.

Finally, run the script to generate the root and intermediate certificates.

>You must provide the country code, state or province, and city or the script will refuse to run. Anything that has spaces must be quoted. For example, CITY="New York".

Here's an example:

```
alpine:~# wget https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/s
etup-cert-authority.sh
Connecting to raw.githubusercontent.com (185.199.108.133:443)
saving to 'setup-cert-authority.sh'
setup-cert-authority 100% |********************************|  2114  0:00:00 ETA
'setup-cert-authority.sh' saved

alpine:~# vi setup-cert-authority.sh
ROOT_CA=HomeCA
DOMAIN=home
COUNTRY=US
STATE_PROVINCE=Wisconsin
CITY=Madison

alpine:~# sh ./setup-cert-authority.sh
Verifying settings
Verifying directories
Creating root CA config
Creating root CA
Certificate request self-signature ok
subject=C = US, ST = Wisconsin, L = Madison, O = HomeCA, CN = HomeCA
Creating intermediate CA config
Creating intermediate CA
Certificate request self-signature ok
subject=C = US, ST = Wisconsin, L = Madison, O = home, CN = home
Cleaning up temporary files
```

You should see an _ok_ message from both the root CA and the intermediate CA. If the script stops before that, it is most likely do to missing information or missing directories.

## Finding the Certificates
You will find your certificates and keys in the system directories /etc/ssl/certs and /etc/ssl/private.

```
alpine:~# ls /etc/ssl/certs
HomeCA.crt  ca-certificates.crt  home.crt
alpine:~# ls /etc/ssl/private
HomeCA.key  home.key
```

## Using the Certificates
The root and intermediate aren't used to secure web servers and other devices directly. They are used to sign other certificates that are then used to secure a device. A detailed discussion of how to do that is beyond the scope of this document, but you can find plenty of resources by serching the web for "how to self sign a certificate". You can also reverse engineer the setup-cert-authority.sh script.

## Next Steps
TODO
