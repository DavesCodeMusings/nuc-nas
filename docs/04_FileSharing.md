# File Sharing with Nextcloud and Samba

In this step, Nextcloud and Samba are configured to run as Docker containers using a single Docker Compose project. Both applications are used to share files, a core component of any NAS device.

By the end of this step, you will have:
* Created a logical volume for file storage.
* Created a Docker Compose project for Nextcloud and Samba containers.
* Started the containers in the Docker Compose project.

## Can I skip it?
You could skip this step if you don't want to share files, or you could modify the Docker Compose project to only install one of the two file sharing containers.

## Why Nextcloud and Samba?
Both Nextcloud and Samba share files, but the do it differently. The Nextcloud approach is to store and replicate files on a variety of platforms including PC, mobile, and web-based. Samba is more of a map a drive letter to a central server share sort of model. Both have their advantages.

## Understanding the Scripted Install
The [setup-file-sharing.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-file-sharing.sh) will perform three tasks.
1. Create a logical volume to mount on /srv
2. Create directories under /srv for Nexclound and Samba to use.
3. Create the Docker Compose project and start the services.

Like the other scripts, there are variables at the top for customization. The VOL_SIZE variable specifies the initial size of the logical volume. It's intentionally on the small side. If you have a lot of files, may want to increase it at the outset, or you can use `lvextend` to do it later.

> /srv was chosen based on the [Linux Filesystem Hierarchy's](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s17.html) recommendations for "data for services provided by this system".

## Running setup-file-sharing.sh
First, download [setup-file-sharing.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-file-sharing.sh) using wget.

Next, edit and make any neccessary customizations to the VOL_SIZE and VOL_GROUP. Recall that the default VOL_SIZE is rather small and may need to be increased.

Finally, run the script. If things go as expected, it should look something like this:

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

Git is another way to share files like code, documentation, and configurations. Github is an example of this. For private, self-hosted git repositories there's a lightweight server called Gitea you can run as a Docker container. The next step is to install [Gitea](05_Gitea.md).
