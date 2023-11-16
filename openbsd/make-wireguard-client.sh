#!/bin/bash
#
# This script creates wireguard client files. There is some things that need to do manually, but the creation of 
# the client files is automated.
#
# azoth zephyr <azoth@zephyr.sx>
# 
if [ -z "$1" ] || [ -z "$2" ] || [ "$EUID" -ne 0 ]; then
  echo "Usage: `basename $0` <client device name> <client ip>"
  echo "  -*-  must be ran as root on the wireguard server -*-"
  exit 0
fi  
CLIENT_NAME=$1
CLIENT_VPN_IP=$2
# -generate keys-
wg genkey|tee $CLIENT_NAME.pri.key| wg pubkey > $CLIENT_NAME.pub.key
CLIENT_PRIV=`cat $CLIENT_NAME.pri.key`
CLIENT_PUB=`cat $CLIENT_NAME.pub.key`
SERVER_PUB=`ifconfig wg0 | grep wgpubkey | awk {'print $2'}`
SERVER_PUB_IP=`ifconfig vio0|grep inet|awk {'print $2'}`
SERVER_PRIV_IP=`ifconfig wg0|grep inet|awk {'print $2'}`
SERVER_PORT=9012
NETWORK=""
# generate a key and a private / public file
wg genkey|tee $CLIENT_NAME.pri.key| wg pubkey > $CLIENT_NAME.pub.key

echo "---- CLIENT DONE ----"
# create /etc/hostname.wg0 for openbsd
cat <<EOF > $CLIENT_NAME.bsd.conf
echo "wgkey $CLIENT_PRIV
wgpeer $SERVER_PUB wgrtable 1 wgendpoint $SERVER_PUB_IP $SERVER_PORT wgaip $NETWORK
inet $CLIENT_VPN_IP
up
!route add default -link -iface wg0
EOF
echo "- openbsd config is at: $CLIENT_NAME.bsd.conf"

# create standard wireguard configuration for linux / windows / etc
cat <<EOF >$CLIENT_NAME.conf
[Interface]
Address = $CLIENT_VPN_IP/32
PrivateKey = $CLIENT_PRIV
DNS = $SERVER_PRIV_IP # some dns resolver

[Peer]
PublicKey = $SERVER_PUB# pub server key
AllowedIPs = 0.0.0.0/0 # we want the client to navigate through the server
Endpoint = $SERVER_PUB_IP:$SERVER_PORT
EOF
echo "- linux and other platform config is at: $CLIENT_NAME.conf"

# TODO: fix this
#echo '----'
#echo 'here is a qr code if the client is mobile:'
#cat $CLIENT_NAME.conf|qrencode -t ansiutf8
echo '----'
echo 'SERVER CONFIGURATION:'
echo '- to set this account up in the server, add the following line to /etc/hostname.wg0'
echo '*****  it is up to you to insure there are no ip conflicts '
echo "wgpeer $CLIENT_PUB wgaip $CLIENT_VPN_IP/32"
echo '*****'
echo 'restart wireguard with `sh /etc/netstart wg0`'
echo '---'

rm $CLIENT_NAME.pub.key $CLIENT_NAME.pri.key
