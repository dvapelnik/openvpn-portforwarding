#!/bin/sh

/etc/openvpn/portForwarding.py 'connect' $ifconfig_local $ifconfig_pool_remote_ip
