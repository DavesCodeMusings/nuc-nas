ADMIN_USERNAME=admin
ADMIN_FULLNAME="System Administrator"

echo "Installing packages"
apk update
apk add sudo

echo "Configuring sudo"
cat <<EOF >/etc/sudoers.d/nopasswd
%wheel ALL=(ALL) NOPASSWD: ALL
EOF

echo "Creating user account: $ADMIN_USERNAME"
adduser -g "$ADMIN_FULLNAME" $ADMIN_USERNAME
addgroup $ADMIN_USERNAME wheel
