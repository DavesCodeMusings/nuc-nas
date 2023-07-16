USERNAME=admin
FULLNAME="System Administrator"

echo "Installing packages"
apk update
apk add sudo

echo "Configuring sudo"
cat <<EOF >/etc/sudoers.d/nopasswd
%wheel ALL=(ALL) NOPASSWD: ALL
EOF

echo "Creating user account: $USERNAME"
adduser -g '$FULLNAME' $USERNAME
addgroup $USERNAME wheel
passwd $USERNAME
