# Containerized Workloads with Docker
Docker provides a way to run applications as containers.

At the end of this step, you will have:
* Created a logical volume to store things related to Docker.
* Installed Docker Community Edition and Docker Compose.
* Started the Portainer administration tool as your first Docker container.

## Can I skip it?
If you would rather install applications using APK packages, you can certainly skip this step and do it that way.

## Why Docker Community Edition?
There are several container management tools available these days. Docker was one of the first and has a good support structure around it. It's also relatively simple to install and understand, making it well suited for a small home network.

## Understanding the Scripted Install
The [setup_docker.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-docker.sh) script will do three things for you.

1. Create a logical volume that will be mounted on /var/lib/docker (this is where Docker stores nearly everything and storage needs can grow.)
2. Install Docker Community Edition and Docker Compose from APK packages and start the Docker service.
3. Create a Docker Compose project for Portainer (a Docker web-based admin tool) and start it up.

If you already have Portainer running in your environment, there is an option in the script to install the Portainer Agent rather than the full administrative tool.

## Running setup-docker.sh
First, download the [setup_docker.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-docker.sh) using wget.

Next, edit and make any neccessary customizations to the VOL_SIZE, VOL_GROUP and AGENT_ONLY variables. If you haven't made any changes in the installation steps thus far, you can probably leave these as-is without any problems.

Finally, run the script.
If things go well, there's nothing to do but sit back and watch the install messages go by.

Here's a sample of what you might see using all the default values:

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
...
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
Creating compose project directory
Creating Portainer compose file
Waiting for docker socket...
Starting Portainer
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

> Some output has been truncated for brevity.

## Managing Containers with Portainer
Configure Portainer by opening a web browser and visiting the DNS name or IP address of the NUC on port 9000. See the [official documentation](https://docs.portainer.io/) on how to get things set up.

## Next Steps
With Docker, Docker Compose, and Portainer at your disposal, you're ready to get the NAS funtionality going with containers for [Nextcloud and Samba](04_FileSharing.md).
