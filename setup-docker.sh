VOL_SIZE=10G
VOL_GROUP=vg0
AGENT_ONLY=no

echo "Creating compose project directory"
mkdir -p /var/lib/docker/compose/portainer || exit 2

echo "Creating logical volume /dev/${VOL_GROUP}/docker"
lvcreate -n docker -L ${VOL_SIZE} ${VOL_GROUP}
mkfs.ext4 /dev/${VOL_GROUP}/docker
echo "/dev/${VOL_GROUP}/docker /var/lib/docker ext4 rw 1 1" >>/etc/fstab
mount /var/lib/docker

echo "Installing packages"
apk add docker docker-compose
rc-update add docker
service docker start

echo "Creating compose file"
if [ "$AGENT_ONLY" == "no" ]; then
  cat <<EOF >/var/lib/docker/compose/portainer/compose.yml
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

else
  cat <<EOF >/var/lib/docker/compose/portainer/compose.yml
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
fi

echo "Starting Portainer"
cd /var/lib/docker/compose/portainer
docker-compose up -d

echo "Visit http://$(hostname):9000 to configure Portainer"
