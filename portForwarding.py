#!/usr/bin/python

import sys
import socket
import subprocess

if(sys.argv[1] == "connect"):
	action = "-A"
else:
	action = "-D"

ifconfigLocal = sys.argv[2]
ifconfigPoolRemoteIp = sys.argv[3]
serverIp = socket.gethostbyname(socket.gethostname())

ports = {
	"10.8.0.5" : [
		{ "external" : "65022", "internal" : "22" },
		{ "external" : "65080", "internal" : "80" },
	]
}

try:
	portsForForwarding = ports[ifconfigPoolRemoteIp]
	for port in	portsForForwarding:
		bashCommand = "/sbin/iptables -t nat %s PREROUTING -d %s -p tcp --dport %s -j DNAT --to-dest %s:%s" % (action, serverIp, port["external"], ifconfigPoolRemoteIp, port["internal"])
		process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
		bashCommand = "/sbin/iptables -t nat %s POSTROUTING -d %s -p tcp --dport %s -j SNAT --to-source %s" % (action, ifconfigPoolRemoteIp, port["internal"], ifconfigLocal)
		process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
except :
	pass
