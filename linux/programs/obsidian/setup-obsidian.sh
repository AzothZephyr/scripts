
if [ ! -d "/opt/obsidian" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  echo "creating /opt/obsidian"
  mkdir /opt/obsidian
fi

# TODO: download newest and add to /opt/obsidian
# they do some stupid shit with releases whereby they don't have a single url available to download the latest, they update it by version number
# so you'll need to pull version number and interpolate the string into a wget command or something


# create application file for kde / desktop use in /opt/obsidian
echo "[Desktop Entry]
Name=Obsidian
StartupWMClass=obsidian
Comment=An application to organize shit.
GenericName=Internet Messenger
Exec=/usr/local/bin/obsidian
Type=Application
Categories=Network;
Path=/usr/local/bin" > /opt/obsidian/obsidian.desktop

# copy the file to /usr/share/applications
sudo cp -r /opt/obsidian/obsidian.desktop /usr/share/applications