#!/bin/sh

/etc/openvpn/portForwarding.py 'disconnect' $ifconfig_local $ifconfig_pool_remote_ip
