GIT_HOME=/srv/git
COMPOSE_PROJECT_DIR=/var/lib/docker/compose/gitea

echo "Creating compose project directory"
mkdir -p ${COMPOSE_PROJECT_DIR} || exit 1

echo "Creating git user and group"
grep ^git /etc/passwd || adduser -D -h ${GIT_HOME} git
GIT_UID=$(id -u git)
GIT_GID=$(id -g git)
[ -d ${GIT_HOME} ] || mkdir ${GIT_HOME}

echo "Installing packages"
apk add git

echo "Creating compose file"
cat <<EOF >${COMPOSE_PROJECT_DIR}/compose.yml
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

echo "Starting Gitea"
cd ${COMPOSE_PROJECT_DIR}
docker-compose up -d

echo "Visit http://$(hostname):3000 to configure Gitea"
