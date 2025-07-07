#!/bin/bash

# Nome da VPN
VPN_NAME="Fabritech"

# Verificar se a VPN está conectada
STATUS=$(nmcli connection show --active | grep -i "$VPN_NAME")

if [ -n "$STATUS" ]; then
  # VPN está ativa
  echo "%{F#a6e3a1} VPN ON%{F-}"
else
  # VPN está inativa
  echo "%{F#f38ba8} VPN OFF%{F-}"
fi
