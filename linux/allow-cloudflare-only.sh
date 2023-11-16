#!/usr/bin/bash

# To set nginx to only accept cloudflare ips, run this script
# then add "include /etc/nginx/allow-cloudflare-only.conf" to 
# your configurations server object
# ---
# Example:
# server {
#     listen 80;
#     server_name example.com;
#     include /etc/nginx/allow-cloudflare-only.conf;
#
#     location / { 
#       ...
#     }
# }
#
# then reload nginx:
# sudo systemctl reload nginx
# 
# azoth zephyr <azoth@zephyr.sx>
# ---

set -e

cf_ips() {
echo "# https://www.cloudflare.com/ips"

for type in v4 v6; do
echo "# IP$type"
curl -sL "https://www.cloudflare.com/ips-$type/" | sed "s|^|allow |g" | sed "s|\$|;|g"
echo
done

echo "# Generated at $(LC_ALL=C date)"
}

(cf_ips && echo "deny all; # deny all remaining ips") > allow-cloudflare-only.conf
sudo mv allow-cloudflare-only.conf /etc/nginx/
