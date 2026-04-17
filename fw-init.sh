#!/bin/sh
echo 1 > /proc/sys/net/ipv4/ip_forward
apk add --no-cache iptables-legacy > /dev/null 2>&1
iptables-legacy -F FORWARD
iptables-legacy -t nat -F
iptables-legacy -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables-legacy -A FORWARD -i eth2 -o eth0 -j ACCEPT
iptables-legacy -A FORWARD -i eth0 -o eth2 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables-legacy -A FORWARD -i eth2 -o eth1 -j DROP
echo "Parefeu initialise."
sleep infinity
