#!/bin/bash

# Mata qualquer instância anterior
pkill gnome-keyring-daemon

# Aguarda um momento
sleep 1

# Inicia o gnome-keyring com todos os componentes
eval $(gnome-keyring-daemon --start --components=ssh,secrets,pkcs11)

# Exporta as variáveis
export SSH_AUTH_SOCK
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

# Log para debug
echo "SSH_AUTH_SOCK: $SSH_AUTH_SOCK" >> /tmp/keyring.log
echo "GNOME_KEYRING_CONTROL: $GNOME_KEYRING_CONTROL" >> /tmp/keyring.log
