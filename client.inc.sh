#!/bin/sh

# Arguments
# $1 - Server external IP
# $2 - Server external port
# $3 - Server NAT IP
# $4 - Client NAT IP
# $5 - Client NAT port

function portForwardAddRule {
    /sbin/iptables -t nat -A PREROUTING -d "$1" -p tcp --dport "$2" -j DNAT --to-dest "$4":"$5"
    /sbin/iptables -t nat -A POSTROUTING -d "$4" -p tcp --dport "$5" -j SNAT --to-source "$3"
}

# Arguments
# $1 - Server external IP
# $2 - Server external port
# $3 - Server NAT IP
# $4 - Client NAT IP
# $5 - Client NAT port

function portForwardDeleteRule {
    /sbin/iptables -t nat -D PREROUTING -d "$1" -p tcp --dport "$2" -j DNAT --to-dest "$4":"$5"
    /sbin/iptables -t nat -D POSTROUTING -d "$4" -p tcp --dport "$5" -j SNAT --to-source "$3"
}

case "$ifconfig_pool_remote_ip" in
    "10.8.0.5")
        port_local=65022
        port_remote=22
	;;
    *);;
esac

mainif="eth0"
serverip=$(/sbin/ifconfig $mainif 2> /dev/null | /bin/awk '/inet addr:/ {print $2}' | /bin/sed 's/addr://')
