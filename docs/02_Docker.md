# Docker Community Edition and Portainer Community Edition

TODO

[setup_docker.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-docker.sh)

If things go well, there's nothing to do but sit back and watch the install messages go by.

Here's a sample using all the default values:

```
alpine:~# wget https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-docker.sh
Connecting to raw.githubusercontent.com (185.199.111.133:443)
saving to 'setup-docker.sh'
setup-docker.sh      100% |********************************|  1338  0:00:00 ETA
'setup-docker.sh' saved

alpine:~# vi setup-docker.sh
VOL_SIZE=10G
VOL_GROUP=vg0
AGENT_ONLY=no

alpine:~# sh ./setup-docker.sh
  Logical volume "docker" created.
mke2fs 1.46.4 (18-Aug-2021)
Creating filesystem with 2621440 4k blocks and 655360 inodes
Filesystem UUID: 13c0f642-ea20-4b51-a4dc-a9478bd6a2c7
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done

(1/62) Installing ca-certificates (20211220-r0)
(2/62) Installing libseccomp (2.5.2-r0)
(3/62) Installing runc (1.0.2-r2)
(4/62) Installing containerd (1.5.11-r1)
(5/62) Installing containerd-openrc (1.5.11-r1)
(6/62) Installing libmnl (1.0.4-r2)
(7/62) Installing libnftnl (1.2.1-r0)
(8/62) Installing iptables (1.8.7-r1)
(9/62) Installing iptables-openrc (1.8.7-r1)
(10/62) Installing ip6tables (1.8.7-r1)
(11/62) Installing ip6tables-openrc (1.8.7-r1)
(12/62) Installing tini-static (0.19.0-r0)
(13/62) Installing docker-engine (20.10.14-r1)
(14/62) Installing docker-openrc (20.10.14-r1)
(15/62) Installing docker-cli (20.10.14-r1)
(16/62) Installing docker (20.10.14-r1)
Executing docker-20.10.14-r1.pre-install
(17/62) Installing libbz2 (1.0.8-r1)
(18/62) Installing expat (2.4.7-r0)
(19/62) Installing gdbm (1.22-r0)
(20/62) Installing libgcc (10.3.1_git20211027-r0)
(21/62) Installing libstdc++ (10.3.1_git20211027-r0)
(22/62) Installing mpdecimal (2.5.1-r1)
(23/62) Installing readline (8.1.1-r0)
(24/62) Installing sqlite-libs (3.36.0-r0)
(25/62) Installing python3 (3.9.7-r4)
(26/62) Installing py3-ordered-set (4.0.2-r2)
(27/62) Installing py3-appdirs (1.4.4-r2)
(28/62) Installing py3-parsing (2.4.7-r2)
(29/62) Installing py3-six (1.16.0-r0)
(30/62) Installing py3-packaging (20.9-r1)
(31/62) Installing py3-setuptools (52.0.0-r4)
(32/62) Installing py3-cached-property (1.5.2-r1)
(33/62) Installing py3-certifi (2020.12.5-r1)
(34/62) Installing py3-chardet (4.0.0-r2)
(35/62) Installing py3-distro (1.6.0-r0)
(36/62) Installing dockerpy-creds (0.4.0-r2)
(37/62) Installing py3-cparser (2.20-r1)
(38/62) Installing py3-cffi (1.14.5-r2)
(39/62) Installing py3-idna (3.3-r0)
(40/62) Installing py3-asn1crypto (1.4.0-r1)
(41/62) Installing py3-cryptography (3.3.2-r3)
(42/62) Installing py3-ipaddress (1.0.23-r2)
(43/62) Installing py3-charset-normalizer (2.0.7-r0)
(44/62) Installing py3-urllib3 (1.26.7-r0)
(45/62) Installing py3-requests (2.26.0-r1)
(46/62) Installing py3-websocket-client (1.2.1-r2)
(47/62) Installing docker-py (5.0.3-r0)
(48/62) Installing py3-dockerpty (0.4.1-r3)
(49/62) Installing py3-docopt (0.6.2-r6)
(50/62) Installing py3-pyrsistent (0.18.0-r0)
(51/62) Installing py3-attrs (21.2.0-r0)
(52/62) Installing py3-jsonschema (4.2.1-r0)
(53/62) Installing py3-asn1 (0.4.8-r1)
(54/62) Installing py3-bcrypt (3.2.0-r4)
(55/62) Installing py3-pynacl (1.4.0-r2)
(56/62) Installing py3-paramiko (2.7.2-r1)
(57/62) Installing py3-pysocks (1.7.1-r2)
(58/62) Installing py3-dotenv (0.19.2-r0)
(59/62) Installing yaml (0.2.5-r0)
(60/62) Installing py3-yaml (5.4.1.1-r1)
(61/62) Installing py3-texttable (1.6.4-r0)
(62/62) Installing docker-compose (1.29.2-r1)
Executing busybox-1.34.1-r5.trigger
Executing ca-certificates-20211220-r0.trigger
OK: 1191 MiB in 225 packages
 * service docker added to runlevel default
 * Caching service dependencies ...                                   [ ok ]
 * Mounting cgroup filesystem ...                                     [ ok ]
 * /var/log/docker.log: creating file
 * /var/log/docker.log: correcting owner
 * Starting Docker Daemon ...                                         [ ok ]
Creating network "portainer_default" with the default driver
Creating volume "portainer_data" with default driver
Pulling portainer (portainer/portainer-ce:)...
latest: Pulling from portainer/portainer-ce
772227786281: Pull complete
96fd13befc87: Pull complete
b3238bddfe78: Pull complete
Digest: sha256:3ff080a0cd2a45bd0bde046069973b3fe642c3e4d43c5b429dd7b77f0057c7d7
Status: Downloaded newer image for portainer/portainer-ce:latest
Creating portainer ... done
Visit http://alpine.home:9000 to configure Portainer
```

## Managing Containers with Portainer
Configure Portainer by opening a web browser and visiting the DNS name or IP address of the NUC on port 9000. See the [official documentation](https://docs.portainer.io/) on how to get things set up.

## Next Steps
With Docker, Docker Compose, and Portainer at your disposal, you're ready to get the NAS funtionality going with containers for [Nextcloud and Samba](03_FileSharing.md).
