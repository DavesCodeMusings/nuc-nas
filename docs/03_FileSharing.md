TODO

[setup-file-sharing.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-file-sharing.sh)

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
