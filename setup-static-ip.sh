IPV4_ADDRESS=
IPV4_NETMASK=
IPV4_GATEWAY=
HOSTNAME=alpine
DOMAIN=home
DNS1=${IPV4_GATEWAY}
DNS2=1.1.1.1

echo "Verifying settings"
[ -n "$IPV4_ADDRESS" ] || exit 1
[ -n "$IPV4_NETMASK" ] || exit 1
[ -n "$IPV4_GATEWAY" ] || exit 1
[ -n "$HOSTNAME" ] || exit 1
[ -n "$DOMAIN" ] || exit 1
[ -n "$DNS1" ] || exit 1

echo "Writing to /etc/network/interfaces"
cat <<EOF >/etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address ${IPV4_ADDRESS}
    netmask ${IPV4_NETMASK}
    gateway ${IPV4_GATEWAY}
    hostname ${HOSTNAME}.${DOMAIN}
EOF

echo "Writing to /etc/hosts"
cat <<EOF >/etc/hosts
127.0.0.1   localhost.localdomain  localhost
${IPV4_ADDRESS}  ${HOSTNAME}.${DOMAIN}  ${HOSTNAME}
EOF

echo "Writing to /etc/resolv.conf"
cat <<EOF >/etc/resolv.conf
search ${DOMAIN}
nameserver ${DNS1}
EOF
[ -n "${DNS2}" ] && echo "nameserver ${DNS2}" >>/etc/resolv.conf

echo "You must reboot for changes to take effect."
