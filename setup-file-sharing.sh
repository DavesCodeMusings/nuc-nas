install -m750 -o www-data -g root -d /srv/cloud
install -m755 -o root -g root -d /srv/media
install -m755 -o root -g root -d /srv/public
install -m777 -o root -g root -d /srv/shared

mkdir /var/lib/docker/compose/file-sharing || exit 1
cd /var/lib/docker/compose/file-sharing || exit 2

cat <<EOF >docker-compose.yml
services:
    nextcloud:
        image: nextcloud
        container_name: nextcloud
        hostname: nextcloud
        restart: unless-stopped
        ports:
            - 8910:80
        volumes:
            - nextcloud:/var/www/html
            - /srv/cloud:/var/www/html/data

    samba:
        image: davescodemusings/samba-anon:x86
        container_name: samba
        hostname: samba
        restart: unless-stopped
        ports:
            - '445:445'
        volumes:
            - /srv/public:/srv/public
            - /srv/media:/srv/media
            - /srv/shared:/srv/shared

volumes:
    nextcloud:
EOF

docker-compose up -d
