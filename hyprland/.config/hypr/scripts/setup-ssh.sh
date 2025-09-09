#!/bin/bash

# Matar agentes conflitantes
pkill ssh-agent
pkill gnome-keyring-daemon

# Aguardar
sleep 1

# Criar diretório se não existir
mkdir -p $XDG_RUNTIME_DIR/keyring

# Iniciar gnome-keyring
eval $(gnome-keyring-daemon --start --components=ssh,secrets,pkcs11 --control-directory=$XDG_RUNTIME_DIR/keyring)

# Exportar variáveis para o ambiente
export SSH_AUTH_SOCK
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

# Adicionar chaves SSH automaticamente
ssh-add ~/.ssh/id_rsa 2>/dev/null || true
ssh-add ~/.ssh/id_ed25519 2>/dev/null || true

# Log para debug
echo "SSH_AUTH_SOCK: $SSH_AUTH_SOCK" >> /tmp/ssh-setup.log
echo "Chaves carregadas: $(ssh-add -l)" >> /tmp/ssh-setup.log
