VOL_SIZE=10G
VOL_GROUP=vg0
AGENT_ONLY=no

lvcreate -n docker -L ${VOL_SIZE} ${VOL_GROUP}
mkfs.ext4 /dev/${VOL_GROUP}/docker
mkdir /var/lib/docker
echo "/dev/${VOL_GROUP}/docker /var/lib/docker ext4 rw 1 1" >>/etc/fstab
mount /var/lib/docker

apk add docker docker-compose
rc-update add docker
service docker start

if [ "$AGENT_ONLY" == "no" ]; then
  mkdir -p /var/lib/docker/compose/portainer
  cat <<EOF >/var/lib/docker/compose/portainer/docker-compose.yml
services:
    portainer:
        image: portainer/portainer-ce
        container_name: portainer
        hostname: portainer
        restart: unless-stopped
        ports:
        - 8000:8000
        - 9000:9000
        - 9443:9443
        volumes:
        - data:/data
        - /var/run/docker.sock:/var/run/docker.sock

volumes:
    data:
EOF
  cd /var/lib/docker/compose/portainer
  docker-compose up -d
  echo "Visit http://$(hostname):9000 to configure Portainer"

else
  mkdir -p /var/lib/docker/compose/agent
  cat <<EOF >/var/lib/docker/compose/agent/docker-compose.yml
services:
  portainer-agent:
    image: portainer/agent
    restart: unless-stopped
    ports:
      - "9001:9001"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/lib/docker/volumes:/var/lib/docker/volumes
EOF
  cd /var/lib/docker/compose/agent
  docker-compose up -d
fi
