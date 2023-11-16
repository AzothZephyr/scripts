#!/bin/bash
#
# upgrade-golang.sh allows you to quickly switch between golang versions
# it removes the existing golang installation and downloads a specified
# version.
#
# this script presumes the golang installation was initially done following
# the golang install documentation below, installing golang in /usr/local/go
# and insuring proper path variable is set up.
#
# see: https://go.dev/doc/install
#
# azoth zephyr <azoth@zephyr.sx>
#

if [ "$1" = '' ]; then
  read -p "enter golang version to download, (ex. 1.20.8): " VERSION
else
  echo "installing version: $1"
  VERSION=$1
fi

FILE_NAME="go$VERSION.linux-amd64.tar.gz"

echo "downloading $FILE_NAME"
wget https://go.dev/dl/$FILE_NAME \
	--output-document /tmp/$FILE_NAME \
	--quiet

echo "installing $FILE_NAME"
sudo rm -rf /usr/local/go 
sudo tar -C /usr/local -xzf /tmp/$FILE_NAME
echo "cleaning up"
rm /tmp/$FILE_NAME
echo "done..."
