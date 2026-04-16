#!/bin/sh
# Détecte le bridge du réseau DMZ via son subnet 172.20.0.0/24
BRIDGE=$(ip route | grep "172.20.0.0" | awk '{print $3}')
if [ -z "$BRIDGE" ]; then
  echo "Bridge DMZ non trouvé, fallback sur br-0"
  BRIDGE=$(ip link | grep -o 'br-[a-f0-9]*' | head -1)
fi
echo "Interface détectée : $BRIDGE"
exec /docker-entrypoint.sh -i $BRIDGE -v
