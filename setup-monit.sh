NETADDR = ipcalc -n $(ip route show | awk '/eth0 scope link/ { print $1 }') | awk -F= '{ print $2 }'
NETMASK = ipcalc -m $(ip route show | awk '/eth0 scope link/ { print $1 }') | awk -F= '{ print $2 }'

apk add monit

sed -i~ \
  -e 's/^# set pidfile/set pidfile/' \
  -e 's/^# set idfile/set idfile/' \
  -e 's/^# set statefile/set statefile/' \
  -e '/use address localhost/d' \
  -e "s/allow admin:monit.*$/allow ${NETADDR}\/${NETMASK}/" \
  -e 's/^#  include/include/' \
  /etc/monitrc

mkdir /etc/monit.d

cat <<EOF > /etc/monit.d/ssh.conf
check process sshd with pidfile /var/run/sshd.pid
start program  "/sbin/service sshd start"
stop program  "/sbin/service sshd stop"
if failed port 22 protocol ssh then restart
if 2 restarts within 3 cycles then timeout
EOF

cat <<EOF > /etc/monit.d/rootfs.conf
check device root with path /
if space usage > 80% then alert
EOF

rc-update add monit

monit -t && service monit start

echo "See https://mmonit.com/wiki/ for configuration examples."
