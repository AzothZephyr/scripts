#!/bin/bash

if [ ! -d "/opt/Discord" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir /opt/Discord
fi

# Download latest discord
wget 'https://discord.com/api/download?platform=linux&format=tar.gz' -O discord.tar.gz
# uncompress / untar to /opt/Discord
sudo tar -xzvf discord.tar.gz -C /opt
# link /opt/Discord/Discord binary to /usr/bin/Discord
sudo ln -sf /opt/Discord/Discord /usr/bin/Discord

#remove the latest discord tar.gz
rm discord.tar.gz

# create application file for kde / desktop use in /opt/Discord
echo "[Desktop Entry]
Name=Discord
StartupWMClass=discord
Comment=All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.
GenericName=Internet Messenger
Exec=/usr/bin/Discord
Icon=/opt/Discord/discord.png
Type=Application
Categories=Network;InstantMessaging;
Path=/usr/bin" > /opt/Discord/discord.desktop

# copy the file to /usr/share/applications
sudo cp -r /opt/Discord/discord.desktop /usr/share/applications