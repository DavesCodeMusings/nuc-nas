ADDRESS=192.168.0.100
NETMASK=255.255.255.0
GATEWAY=192.168.0.1
HOST=alpine
DOMAIN=home
DNS1=${GATEWAY}
DNS2=1.1.1.1

echo "Verifying settings"
[ -n "$ADDRESS" ] || exit 1
[ -n "$NETMASK" ] || exit 1
[ -n "$GATEWAY" ] || exit 1
[ -n "$HOST" ] || exit 1
[ -n "$DOMAIN" ] || exit 1
[ -n "$DNS1" ] || exit 1

echo "Writing to /etc/network/interfaces"
cat <<EOF >/etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address ${ADDRESS}
    netmask ${NETMASK}
    gateway ${GATEWAY}
    hostname ${HOST}.${DOMAIN}
EOF

echo "Writing to /etc/hosts"
cat <<EOF >/etc/hosts
127.0.0.1   localhost.localdomain  localhost
${ADDRESS}  ${HOST}.${DOMAIN}  ${HOST}
EOF

echo "Writing to /etc/resolv.conf"
cat <<EOF >/etc/resolv.conf
search ${DOMAIN}
nameserver ${DNS1}
EOF
[ -n "${DNS2}" ] && echo "nameserver ${DNS2}" >>/etc/resolv.conf
