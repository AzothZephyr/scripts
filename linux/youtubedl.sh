#!/bin/bash
#
# this script downloads the latest version of youtube-dl.
# it is missing important features, such as binary hashes.
#
# azoth zephyr <azoth@zephyr.sx> 
#
curl --location https://yt-dl.org/downloads/latest/youtube-dl \
       	--output /tmp/youtube-dl \
		--silent
sudo mv /tmp/youtube-dl /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
