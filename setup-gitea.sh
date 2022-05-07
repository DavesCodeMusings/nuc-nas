GIT_HOME=/srv/git

grep ^git /etc/passwd || adduser -D -h ${GIT_HOME} git
GIT_UID=$(id -u git)
GIT_GID=$(id -g git)
[ -d ${GIT_HOME} ] || mkdir ${GIT_HOME}

apk add git

mkdir /var/lib/docker/compose/gitea
cat <<EOF >/var/lib/docker/compose/gitea/docker-compose.yml
services:
    gitea:
        image: gitea/gitea:latest
        container_name: gitea
        hostname: gitea
        environment:
            - 'USER_UID=${GIT_UID}'
            - 'USER_GID=${GIT_GID}'
        ports:
            - '3000:3000'
        restart: unless-stopped
        volumes:
            - /etc/timezone:/etc/timezone:ro
            - /etc/localtime:/etc/localtime:ro
            - /etc/ssl/certs/ca-certificates.crt:/etc/ssl/certs/ca-certificates.crt:ro
            - data:/data
            - ${GIT_HOME}:/srv/git

volumes:
    data:
EOF

cd /var/lib/docker/compose/gitea
docker-compose up -d

echo "Visit http://$(hostname):3000 to configure Gitea"
