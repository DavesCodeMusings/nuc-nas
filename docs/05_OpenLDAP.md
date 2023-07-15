# OpenLDAP for Centralized Authentication
In this step, OpenLDAP is configured to serve as a centralized login and password authority for applications. Portainer, Nextcloud, and Gitea can all be configured to use LDAP authetication. Many other applications you might choose to install will support LDAP as well.

At the end of this step, you will have:
* Installed the OpenLDAP APK along with backend and client packages.
* Configured the LDAP database to match your network's DNS name.
* Configured OpenLDAP to support the schema used with Linux style user accounts.

## Can I skip it?
Yes, you can configure separate username and passwords for each application if you like.

## Why OpenLDAP?
OpenLDAP has been around for a long time and is well documented. For a simple home network setup, the configuration is relatively straightforward.

>Unfortunately, there is no official OpenLDAP container image on Docker Hub. The only well-maintained container image looks to be more complex to configure than Alpine's APK packages.

## Understanding the Scripted Install
[setup-openldap.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-openldap.sh) automates the following tasks:
1. Install OpenLDAP and related APKs.
2. Adjust the Alpine settings for the OpenLDAP package to conform to more recent versions of OpenLDAP.
3. Customize the initial configuration import file (slapd.ldif) to match the DNS domain.
4. Add the schema required for Linux-style user accounts.
5. Configure the service to start when the system comes up.

There is one important configuration setting in the setup-openldap.sh script.

** You must change the DOMAIN="dc=home" line to match your DNS domain. **

LDAP domains are compatible with DNS domains, but are not specified in the same dotted notation. LDAP uses the _dc=_ notation a domain component. So instead of chaining together sub-domain, domain, and top-level domain with dots like DNS, you use dc= and separate with commas. Perhaps the best way to understand the difference is with a few examples.

* _biz.contoso.com_ becomes _dc=biz,dc=contoso,dc=com_
* _myfamilyname.net_ becomes _dc=myfamilyname,dc=net_
* _home_ becomes _dc=home_

_dc=home_ is the default for the DOMAIN variable in the setup script. It was chosen because .home is a reserved top-level domain name for private networks. Much like the IP address space of 192.168.x.x, the .home top-level domain is specified in [RFC-6762](https://www.rfc-editor.org/rfc/rfc6762#appendix-G) as something that will never be used on the internet and is therefore safe to use on private networks.

Using this naming convention, you would give your hosts names like server1.home or nas.home, and the corresponding LDAP domain would be dc=home.

## Running setup-ldap.sh

When the automated installation steps run, the output should be similar to what is shown below.

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

## Configuring Applications to use LDAP Authentication

Each application will be slightly different in the way it's configured, but the basic information required is the same.

Links to the various application configuration instructions are listed below.
* [Portainer](https://docs.portainer.io/admin/settings/authentication/ldap)
* [Nextcloud](https://docs.nextcloud.com/server/19/admin_manual/configuration_user/user_auth_ldap.html)
* [Gitea](https://docs.gitea.com/next/usage/authentication)

## Next Steps

OpenLDAP is very command-line intensive and perhaps not the easiest of software to grasp. Searching the net for "openldap import ldif" can give you some hints on how to bulk add users and groups to the LDAP directory. There's also a rather old tool for Windows called [LDAP Admin](http://www.ldapadmin.org/) that offers a graphical user interface to the LDAP directory.

After you've got LDAP mastered, you can move on to setting up local email delivery [exim and dovecot](06_Exim_Dovecot.md)
