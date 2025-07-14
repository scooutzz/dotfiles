#!/bin/bash

# Busca VPN ativa (se existir)
ACTIVE_VPN=$(nmcli -t -f NAME,TYPE connection show --active | grep ":vpn" | cut -d: -f1)

# Busca todas VPNs cadastradas no NetworkManager
VPN_LIST=$(nmcli -t -f NAME,TYPE connection show | grep ":vpn" | cut -d: -f1)

# Monta o menu
MENU_ITEMS=()

if [[ -n "$ACTIVE_VPN" ]]; then
    MENU_ITEMS+=("VPN ativa: $ACTIVE_VPN")
    MENU_ITEMS+=("Desconectar VPN")
fi

# Adiciona as VPNs encontradas dinamicamente
while IFS= read -r vpn; do
    MENU_ITEMS+=("$vpn")
done <<< "$VPN_LIST"

# Converte array em string separada por nova linha
MENU=$(printf "%s\n" "${MENU_ITEMS[@]}")

# Exibe o menu via rofi ou dmenu
SELECTED=$(echo -e "$MENU" | rofi -dmenu -p "Escolha VPN")

# Lógica do que fazer
case "$SELECTED" in
    "Desconectar VPN")
        nmcli connection down "$ACTIVE_VPN"
        notify-send "VPN" "Desconectado de $ACTIVE_VPN"
        ;;
    "VPN ativa: $ACTIVE_VPN")
        # Clicou só no título → nada a fazer
        ;;
    "")
        # Usuário cancelou o menu
        ;;
    *)
        nmcli connection up "$SELECTED"
        notify-send "VPN" "Conectado à VPN $SELECTED"
        ;;
esac

