#!/bin/bash
#
# this script disconnects a system from a wireguard server then subsequently 
# reconnects
#
# azoth zephyr <azoth@zephyr.sx> 
#
USAGE="Usage: ./flip-vpn.sh <wireguard interface>"

if [$1 -eq ""];
then
	echo $USAGE
	echo "ERROR: please provide the name of the interface"
	exit 1
fi

# if the interface is not shown in ip addr, throw
if [[ `ip addr | grep " $1: "` -eq " " ]];
then
	echo $USAGE
	echo "ERROR: please provide the name of a valid wireguard interface currently configured and displayed in 'ip addr'"
	exit 1
fi

sudo wg-quick down $1 && sudo wg-quick up $1
