#!/bin/bash

# Nome da sua VPN
VPN_NAME="Fabritech"

# Verificar se a VPN está conectada
STATUS=$(nmcli connection show --active | grep -i "$VPN_NAME")

if [ -n "$STATUS" ]; then
  # Desconectar a VPN
  nmcli connection down "$VPN_NAME"
  notify-send "VPN disconnected"
else
  # Conectar à VPN
  nmcli connection up "$VPN_NAME"
  notify-send "VPN connected"
fi
