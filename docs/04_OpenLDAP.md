# OpenLDAP for Centralized Authentication

TODO

[setup-openldap.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-openldap.sh)

```
alpine:~# wget https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/s
etup-openldap.sh
Connecting to raw.githubusercontent.com (185.199.110.133:443)
saving to 'setup-openldap.sh'
setup-openldap.sh    100% |********************************|  1100  0:00:00 ETA
'setup-openldap.sh' saved

alpine:~# vi setup-openldap.sh
export DOMAIN="dc=home"

alpine:~# sh ./setup-openldap.sh
Installing packages...
(1/7) Installing libsasl (2.1.28-r0)
(2/7) Installing libldap (2.6.0-r0)
(3/7) Installing libltdl (2.4.6-r7)
(4/7) Installing openldap (2.6.0-r0)
Executing openldap-2.6.0-r0.pre-install
Executing openldap-2.6.0-r0.post-install
*
* To use LDAP server, you have to install some backend. Most users would need MDB
* backend which you can install with: apk add openldap-back-mdb.
*
* If you use overlays, you have to install them separately too:
* apk add openldap-overlay-<name>, or openldap-overlay-all to install them all.
*
(5/7) Installing openldap-openrc (2.6.0-r0)
(6/7) Installing openldap-back-mdb (2.6.0-r0)
(7/7) Installing openldap-clients (2.6.0-r0)
Executing busybox-1.34.1-r5.trigger
OK: 1195 MiB in 232 packages
Configuring for v2.3+ style slapd.d config directory...
Customizing for domain: dc=home...
Adding schema for Linux user accounts...
Importing configuration...
Closing DB...
Configuring slapd service...
 * Caching service dependencies ...                                   [ ok ]
 * Setting up the Logical Volume Manager ...                          [ ok ]
 * /run/openldap: creating directory
 * /run/openldap: correcting owner
 * Starting LDAP server ...                                           [ ok ]
 * service slapd added to runlevel default

```

## Next Steps

