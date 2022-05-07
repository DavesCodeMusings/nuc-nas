TODO

[setup-gitea.sh](https://raw.githubusercontent.com/DavesCodeMusings/nucloud/main/setup-gitea.sh)

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

## Next Steps
