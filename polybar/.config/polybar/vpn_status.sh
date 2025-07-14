#!/bin/bash

# Verifica se existe alguma VPN ativa no momento
ACTIVE_VPN=$(nmcli -t -f NAME,TYPE connection show --active | grep ":vpn")

if [[ -n "$ACTIVE_VPN" ]]; then
    # VPN está ativa
    echo "%{F#a6e3a1} VPN ON%{F-}"
else
    # VPN está inativa
    echo "%{F#f38ba8} VPN OFF%{F-}"
fi

