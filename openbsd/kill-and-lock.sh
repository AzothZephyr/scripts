#!/bin/bash
#
# kill-and-lock.sh is a script that's used to log a remote user out of their session and lock the associated account. 
# it takes one argument, the users username.
#
# azoth zephyr <azoth@zephyr.sx>
#
if [ "$1" = "" ]
then
  echo "Usage: $0 <target username>"
  exit
fi

USER=$1
PIDS=( `ps aux|grep $USER|grep sshd|awk {'print $2'}` )

for PID in $PIDS; do
	kill $PID
done

usermod -Z $USER
