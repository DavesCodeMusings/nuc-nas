mkdir /var/lib/docker/compose/pihole || exit 1
cd /var/lib/docker/compose/pihole || exit 2

cat <<EOF >docker-compose.yml
version: "3"

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
      - "80:80/tcp"
    environment:
      TZ: 'America/Chicago'
      WEBPASSWORD: password
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

docker-compose up -d
