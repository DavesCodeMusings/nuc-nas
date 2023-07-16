SSL_CERT=/etc/ssl/certs/$(hostname).crt
SSL_KEY=/etc/ssl/private/$(hostname).key

if ! [ -f $SSL_CERT ] || ! [ -f $SSL_KEY ]; then
  echo "SSL certificate and key not found!"
  echo "Press CTRL+C to abort or ENTER to continue with non-SSL setup."
  read REPLY
fi

echo "Creating compose project directory"
mkdir -p /var/lib/docker/compose/nginx || exit 2

echo "Creating Nginx compose file"
if [ -f $SSL_CERT ] && [ -f $SSL_KEY ]; then
  cat <<EOF >/var/lib/docker/compose/nginx/compose.yml
services:
    nginx:
        image: nginx
        container_name: nginx
        hostname: nginx
        restart: unless-stopped
        ports:
        - 80:80
        - 443:443
        volumes:
        - /etc/ssl:/etc/ssl:ro
        - ./conf.d:/etc/nginx/conf.d
        - /srv/www:/usr/share/nginx/html:ro
EOF
else
  cat <<EOF >/var/lib/docker/compose/nginx/compose.yml
services:
    nginx:
        image: nginx
        container_name: nginx
        hostname: nginx
        restart: unless-stopped
        ports:
        - 80:80
        volumes:
        - ./conf.d:/etc/nginx/conf.d
        - /srv/www:/usr/share/nginx/html:ro
EOF
fi

echo "Creating static web server configuration"
mkdir /var/lib/docker/compose/nginx/conf.d || exit 3
if [ -f SSL_CERT ] && [ -f SSL_KEY ]; then
  cat <<EOF >/var/lib/docker/compose/nginx/conf.d/00_default.conf
# Serve static files
server {
    listen 80;
    listen 443 ssl;
    server_name $(hostname);
    ssl_certificate  $SSL_CERT;
    ssl_certificate_key  $SSL_KEY;
    location / {
        root /usr/share/nginx/html/$(hostname);
        index index.html index.htm;
    }
}
EOF
else
  cat <<EOF >/var/lib/docker/compose/nginx/conf.d/00_default.conf
# Serve static files
server {
    listen 80;
    server_name $(hostname);
    location / {
        root /usr/share/nginx/html/$(hostname);
        index index.html index.htm;
    }
}
EOF
fi

echo "Creating content directory"
mkdir -p /srv/www/$(hostname)

if ! [ -e /srv/www/$(hostname)/index.html ]; then
  cat <<EOF > /srv/www/$(hostname)/index.html
<!DOCTYPE html>

<html>

<head>
  <title>It works!</title>
</head>

<body>
  <p>It works!</p>
</body>

</html>
EOF
fi

echo "Starting Nginx..."
cd /var/lib/docker/compose/nginx
docker-compose up -d
