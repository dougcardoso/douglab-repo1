#!/bin/bash

sudo mkdir -p /etc/ssl/private
sudo mkdir -p /etc/ssl/certs

# Generate SSL certificate
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 \
    -subj "/C=IE/ST=Westmeath/L=Mullingar/O=Douglab/CN=ansible.douglab" \
    -keyout /etc/ssl/private/cockpit-selfsigned.key \
    -out /etc/ssl/certs/cockpit-selfsigned.crt

# Create certificate bundle
cat /etc/ssl/certs/cockpit-selfsigned.crt \
    /etc/pki/tls/certs/ca-bundle.crt \
    >/etc/ssl/certs/cockpit-bundle.crt

# Set up Cockpit service
mkdir -p /etc/systemd/system/cockpit.service.d/
cat > /etc/systemd/system/cockpit.service.d/override.conf <<EOL
[Service]
Environment=COCKPIT_HTTPS_KEY=/etc/ssl/private/cockpit-selfsigned.key
Environment=COCKPIT_HTTPS_CERT=/etc/ssl/certs/cockpit-selfsigned.crt
Environment=COCKPIT_HTTPS_CA_CERT=/etc/ssl/certs/cockpit-bundle.crt
EOL

# Restart Cockpit service
systemctl daemon-reload
systemctl restart cockpit

