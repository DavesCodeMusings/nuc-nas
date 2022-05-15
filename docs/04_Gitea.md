In this step, Gitea is configured to run as a Docker container. While not a critical component of a NAS device, having a Git server is convenient in many respects.

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

## Running the setup-gitea.sh script
First, download [setup-gitea.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-gitea.sh) using wget.

Next, edit the file if you want to change the location where files will be stored.

Finally, run the script. Sample output is shown below.

```
TODO
```

## Configuring Via the Web Interface
TODO

## Next Steps
TODO
