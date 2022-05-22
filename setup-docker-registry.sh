REGISTRY_PORT=5000
HOSTNAME=$(hostname -f)
DOMAIN=$(hostname -d)

echo "Looking for TLS certificates..."
TLS_CERT=/etc/ssl/certs/${HOSTNAME}.crt
TLS_KEY=/etc/ssl/private/${HOSTNAME}.key
TLS_CA=/etc/ssl/certs/${DOMAIN}.crt

[ -f $TLS_CERT ] || exit 1
[ -f $TLS_KEY ] || exit 1
[ -f $TLS_CA ] || exit 1

echo "Creating directories..."
mkdir /var/lib/docker/compose/registry || exit 2
mkdir -p /etc/docker/certs.d/${HOSTNAME}:${REGISTRY_PORT} || exit 2

echo "Creating compose file..."
cat <<EOF >compose.yml
services:
    registry:
        image: registry:2
        container_name: registry
        hostname: registry
        environment:
            - REGISTRY_HTTP_TLS_CERTIFICATE=${TLS_CERT}
            - REGISTRY_HTTP_TLS_KEY=${TLS_KEY}
        ports:
            - 5000:5000
        restart: unless-stopped
        volumes:
            - /etc/localtime:/etc/localtime:ro
            - /etc/ssl:/etc/ssl
            - data:/var/lib/registry

volumes:
    data:
EOF

echo "Starting registry..."
docker-compose up -d

echo "Configuring Docker to trust registry TLS cert..."
cp ${TLS_CA} /etc/docker/certs.d/${HOSTNAME}:${REGISTRY_PORT}/ca.crt

cat <<EOF
List registry contents with:
  curl -k https://${HOSTNAME}:${REGISTRY_PORT}/v2/_catalog

Configure remote hosts to trust registry.
  Copy this host's ${TLS_CA}
  To remote host's /etc/docker/certs.d/${HOSTNAME}:${REGISTRY_PORT}/ca.crt

EOF
