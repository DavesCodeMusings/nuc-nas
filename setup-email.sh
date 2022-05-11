chgrp mail /var/mail
chmod 2775 /var/mail

apk add exim mailx

sed -i~ \
  -e 's/# group = mail/  group = mail/' \
  -e 's/# mode = 0660/  mode = 0660/' \
  /etc/exim/exim.conf

ln -s mail/aliases /etc/aliases

rc-update add exim
service exim start



apk add dovecot

mv /etc/dovecot/dovecot.conf /etc/dovecot/dovecot.conf~

cat <<EOF > /etc/dovecot/dovecot.conf
listen = *
log_path = /var/log/dovecot.log
protocols = imap
disable_plaintext_auth = no
mail_privileged_group = mail
mail_location = mbox:~/mail:INBOX=/var/mail/%u
userdb {
  driver = passwd
}
passdb {
  driver = passwd-file
  args = scheme=sha512-crypt username_format=%n /etc/dovecot/passwd
}

# These are self-signed certs generated when the dovecat apk was installed.
ssl=yes
ssl_cert=</etc/ssl/dovecot/server.pem
ssl_key=</etc/ssl/dovecot/server.key
EOF

touch /etc/dovecot/passwd
chown root:dovecot /etc/dovecot/passwd
chmod 640 /etc/dovecot/passwd

service dovecot start
rc-update add dovecot

echo "Create user passwords with: doveadm pw -s sha512-crypt"
echo "Add them to /etc/dovecot/passwd like this: username:password

