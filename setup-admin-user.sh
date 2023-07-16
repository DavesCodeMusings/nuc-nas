USERNAME=admin
FULLNAME="System Administrator"

echo "Installing packages"
apk update
apk add sudo

echo "Creating user account: $USERNAME"
adduser -g '$FULLNAME' $USERNAME
addgroup $USERNAME wheel

echo "Configuring sudo"
cat <<EOF >/etc/sudoers.d/nopasswd
%wheel ALL=(ALL) NOPASSWD: ALL
EOF

echo "Setting password for $USERNAME"
passwd $USERNAME
