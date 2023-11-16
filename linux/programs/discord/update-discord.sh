#!/bin/bash
# https://itsfoss.com/install-discord-linux/
echo 'downloading newest version of discord'
wget -q 'https://discord.com/api/download?platform=linux&format=tar.gz' -O discord.tar.gz
echo 'setting up...'
sudo tar -xzf discord.tar.gz -C /opt
sudo ln -sf /opt/Discord/Discord /usr/bin/Discord
rm discord.tar.gz
echo 'done'
