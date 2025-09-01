#!/bin/bash

### CONFIGURAÇÃO DE MONITORES ###

xrandr \
  --output DP-0 --primary --mode 1920x1080 --rate 144 --pos 0x0 --rotate normal \
  --output DP-3 --right-of DP-0 --auto --rotate normal

### CONFIGURAÇÃO DO MOUSE ###

# Desabilitar aceleração
xinput set-prop pointer:"Logitech G703 LS" "libinput Accel Profile Enabled" 0, 1

# Opcional: zerar velocidade (neutro)
xinput set-prop pointer:"Logitech G703 LS" "libinput Accel Speed" 0

xinput set-prop 17 "libinput Accel Profile Enabled" 0, 1

# Exec keyboard layout switcher us <-> us, us intl variant
setxkbmap -layout us,us -variant intl, -option grp:alt_shift_toggle

# GNOME Keyring (corrigido)
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK

