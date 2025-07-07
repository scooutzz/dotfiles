#!/bin/bash

### CONFIGURAÇÃO DE MONITORES ###

xrandr \
  --output DP-4 --primary --mode 1920x1080 --rate 144 --pos 0x0 --rotate normal \
  --output DP-3 --right-of DP-4 --auto --rotate normal

### CONFIGURAÇÃO DO MOUSE ###

# Desabilitar aceleração
xinput set-prop pointer:"Logitech G703 LS" "libinput Accel Profile Enabled" 0, 1

# Opcional: zerar velocidade (neutro)
xinput set-prop pointer:"Logitech G703 LS" "libinput Accel Speed" 0

