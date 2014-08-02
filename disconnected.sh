#!/bin/sh

port_local=""
port_remote=""

source /etc/openvpn/client.inc.sh

if [ "$port_local" = "" ] || [ "$port_remote" = "" ]; then
    :
else
    portForwardDeleteRule "95.85.5.97" $port_local $ifconfig_local $ifconfig_pool_remote_ip $port_remote
fi

