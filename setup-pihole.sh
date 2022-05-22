PIHOLE_ADMIN_PORT=8080
PIHOLE_ADMIN_PASSWORD=password
COMPOSE_PROJECT_DIR=/var/lib/docker/compose/pihole

echo "Creating compose project directory"
mkdir -p ${COMPOSE_PROJECT_DIR} || exit 1
cd /var/lib/docker/compose/pihole || exit 2

echo "Creating compose file"
cat <<EOF >${COMPOSE_PROJECT_DIR}/compose.yml
# More info at https://github.com/pi-hole/docker-pi-hole/ and https://docs.pi-hole.net/
services:
  pihole:
    container_name: pihole
    hostname: pihole-docker.$(hostname)
    image: pihole/pihole:latest
    # For DHCP it is recommended to remove these ports and instead add: network_mode: "host"
    ports:
      - "53:53/tcp"
      - "53:53/udp"
#      - "67:67/udp" # Only required if you are using Pi-hole as your DHCP server
      - "${PIHOLE_ADMIN_PORT}:80/tcp"
    environment:
      TZ: 'America/Chicago'
      WEBPASSWORD: ${PIHOLE_ADMIN_PASSWORD}
    # Volumes store your data between container upgrades
    volumes:
      - 'pihole:/etc/pihole'
      - 'dnsmasq.d:/etc/dnsmasq.d'
    #   https://github.com/pi-hole/docker-pi-hole#note-on-capabilities
    cap_add:
      - NET_ADMIN # Recommended but not required (DHCP needs NET_ADMIN)
    restart: unless-stopped

volumes:
    pihole:
    dnsmasq.d:
EOF

echo "Starting Gitea"
cd ${COMPOSE_PROJECT_DIR}
docker-compose up -d
