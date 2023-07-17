ROOT_CA=HomeCA
DOMAIN=home
COUNTRY=
STATE_PROVINCE=
CITY=

# All variables must be set
[ -n "$ROOT_CA" ] || exit 1
[ -n "$DOMAIN" ] || exit 1
[ -n "$COUNTRY" ] || exit 1
[ -n "$STATE_PROVINCE" ] || exit 1
[ -n "$CITY" ] || exit 1

CERTS_DIR=/etc/ssl/certs
KEYS_DIR=/etc/ssl/private

# Destination directories must exist
[ -d "$CERTS_DIR" ] || exit 2
[ -d "$KEYS_DIR" ] || exit 2

TEMP_DIR=$(mktemp -d)

echo "Creating root CA config"
cat <<EOF >${TEMP_DIR}/${ROOT_CA}.conf
[req]
default_bits = 4096
default_md = sha256
distinguished_name = req_dn
req_extensions = req_ext
prompt = no

[req_dn]
C = ${COUNTRY}
ST = ${STATE_PROVINCE}
L = ${CITY}
O = ${ROOT_CA}
CN = ${ROOT_CA}

[req_ext]
basicConstraints = critical, CA:true
keyUsage = keyCertSign, cRLSign
EOF

echo "Creating root CA"
openssl genrsa -out ${KEYS_DIR}/${ROOT_CA}.key 4096
openssl req -config ${TEMP_DIR}/${ROOT_CA}.conf -key ${KEYS_DIR}/${ROOT_CA}.key -new -out ${TEMP_DIR}/${ROOT_CA}.csr
openssl x509 -trustout -signkey ${KEYS_DIR}/${ROOT_CA}.key -days 3650 -req -in ${TEMP_DIR}/${ROOT_CA}.csr -out ${CERTS_DIR}/${ROOT_CA}.crt

echo "Cleaning up temporary files"
rm ${TEMP_DIR}/${ROOT_CA}.csr
rm ${TEMP_DIR}/${ROOT_CA}.conf
