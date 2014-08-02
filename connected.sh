#!/bin/sh

port_local=""
port_remote=""

source /etc/openvpn/client.inc.sh

#echo $serverip
#exit 0

if [ "$port_local" = "" ] || [ "$port_remote" = "" ]; then
    :
else
    portForwardAddRule $serverip $port_local $ifconfig_local $ifconfig_pool_remote_ip $port_remote
fi
