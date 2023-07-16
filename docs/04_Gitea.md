In this step, Gitea is configured to run as a Docker container. While not a critical component of a NAS device, having a Git server is convenient for storing things like code and configuration files.

By the end of this step, you will have:
* Created a Docker Compose project to run the Gitea application.
* Installed command-line tools from the git APK package.

## Can I skip it?
Gitea provides an on-premise git hosting solution similar to GitHub and GitLab. If you have no need for a centralized place for you git repositories, or if you use a public hosting option, you can skip this step.

## Why Gitea?
Of the self-hosted git server options, Gitea is one of the simplest to install. It can also function without using a lot of server resources, making it ideal for a low-power device.

## Understanding the Scripted Install
The [setup-gitea.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-gitea.sh) script will perform the following tasks:

* Create a user for the git server.
* Install the APK with git command-line tools.
* Create a Docker Compose project for Gitea and start the application.

The only customizable component of the script is the GIT_HOME variable that indicates where the centralized git repositories will be stored. The default is /srv/git.

## Running the setup-gitea.sh Script
First, download [setup-gitea.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-gitea.sh) using wget.

Next, edit the file if you want to change the location where files will be stored.

Finally, run the script. Sample output from a typical run is shown below.

```
alpine:~# wget https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/s
etup-gitea.sh
Connecting to raw.githubusercontent.com (185.199.110.133:443)
saving to 'setup-gitea.sh'
setup-gitea.sh       100% |********************************|   933  0:00:00 ETA
'setup-gitea.sh' saved

alpine:~# sh ./setup-gitea.sh
(1/5) Installing brotli-libs (1.0.9-r5)
(2/5) Installing nghttp2-libs (1.46.0-r0)
(3/5) Installing libcurl (7.80.0-r1)
(4/5) Installing pcre2 (10.39-r0)
(5/5) Installing git (2.34.2-r0)
Executing busybox-1.34.1-r5.trigger
OK: 1207 MiB in 237 packages
Creating network "gitea_default" with the default driver
Creating volume "gitea_data" with default driver
Pulling gitea (gitea/gitea:latest)...
latest: Pulling from gitea/gitea
...
Status: Downloaded newer image for gitea/gitea:latest
Creating gitea ... done
Visit http://alpine.home:3000 to configure Gitea
```

>Output has been truncated for brevity.

## Configuring via the Web Interface
The first time Gitea is run, you'll be taken to a configuration page for the application. Many options are dependent on your particular needs, but there are a handful that should be changed to fit the way Gitea was installed.

* Repository Root Path: /srv/git
* Git LFS Root Path: (delete path to disable)
* Server Domain: your.server.dns
* SSH Server Port: (delete port number to disable)
* Gitea Base URL: http://your.server.dns:3000/

> Obviously, you'll want to replace _your.server.dns_ with the actual DNS name or IP address of your host.

[Gitea documentation](https://docs.gitea.io/) provides more detailed configuration assistance.

## Integrating Gitea with Portainer
There is a feature in Portainer that lets you control your Docker Compose projects from the Portainer interface and retrieve your docker-compose.yml from a Git repository. Gitea can provide this repository. Portainer can further be configured with webhooks to redeploy a Docker Compose project anytime the Git repository holding the docker-compose.yml is updated.

## Next Steps
Portainer, Nextcloud, and Gitea all require you to set up a user account. They're also all capable of using LDAP for centralized account management. To make this possible, you'll want to install [OpenLDAP](05_OpenLDAP.md)
