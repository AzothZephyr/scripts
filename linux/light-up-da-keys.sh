#!/bin/bash
# 
# i used to experience a bug on void linux where 
# i needed to manually start acpid after reboobing.
# this script does that.
#
# azoth zephyr <azoth@zephyr.sx>
#
sudo ln -s /etc/sv/acpid /var/service
