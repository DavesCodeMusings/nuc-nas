In this step, Nextcloud and Samba are both configured to run as Docker containers using a single Docker Compose project. Both applications share files, a core component of any NAS device.

By the end of this step, you will have:
* Created a logical volume for file storage.
* Created a Docker Compose project for Nextcloud and Samba containers.
* Started the containers in the Docker Project.

## Can I skip it?
You could skip this step if you don't want to share files, or you could modify the Docker Compose project to only install one of the two file sharing containers.

## Why Nextcloud and Samba
Both Nextcloud and Samba share files, but the do it differently. The Nextcloud approach is to offer files on a variety of platforms including PC, mobile, and web-based. Samba is more of a map a drive letter to a server share sort of model. Both have their advantages.

## Understanding the Scripted Install
[setup-file-sharing.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-file-sharing.sh)

## Running setup-file-sharing.sh
```
alpine:~# wget https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-file-sharing.sh
Connecting to raw.githubusercontent.com (185.199.109.133:443)
saving to 'setup-file-sharing.sh'
setup-file-sharing.s 100% |********************************|   961  0:00:00 ETA
'setup-file-sharing.sh' saved

alpine:~# sh ./setup-file-sharing.sh
Creating network "file-sharing_default" with the default driver
Creating volume "file-sharing_nextcloud" with default driver
Pulling nextcloud (nextcloud:)...
latest: Pulling from library/nextcloud
...
Status: Downloaded newer image for nextcloud:latest
Pulling samba (davescodemusings/samba-anon:x86)...
x86: Pulling from davescodemusings/samba-anon
...
Status: Downloaded newer image for davescodemusings/samba-anon:x86
Creating samba     ... done
Creating nextcloud ... done
```

>Some output has been truncated for brevity.
>

## Next Steps

[LDAP](04_OpenLDAP.md)
