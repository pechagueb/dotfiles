#!/bin/bash

#######################################################
#   ____  _____ ____  
#  |  _ \| ____| __ )  Autor: 
#  | |_) |  _| |  _ \  Patricio Echagüe Ballesteros
#  |  __/| |___| |_) | Descripción:
#  |_|   |_____|____/  Enciende o apaga monitor virtual
#
# Para conectar tablet con Weylus
#######################################################

# Comprobar si HEADLESS-1 ya existe en los monitores activos
if hyprctl monitors | grep -q "HEADLESS-1"; then
    # Si existe, la destruimos para apagarla
    hyprctl output remove HEADLESS-1
    notify-send "Monitor Virtual" "HEADLESS-1 desactivado"
else
    # Si no existe, la creamos aplicando resolución y posición
    hyprctl output create headless HEADLESS-1
    hyprctl keyword monitor HEADLESS-1,1800x1200@60,0x590,1
    notify-send "Monitor Virtual" "HEADLESS-1 activado (1800x1200)"
fi