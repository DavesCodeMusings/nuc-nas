chgrp mail /var/mail
chmod 2775 /var/mail

apk add exim mailx

sed -i~ \
  -e 's/# group = mail/group = mail/' \
  -e 's/# mode = 0660/mode = 0660/' \
  /etc/exim/exim.conf
  
rc-update add exim
service exim start
