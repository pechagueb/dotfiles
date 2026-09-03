#!/bin/bash

#######################################################
#   ____  _____ ____  
#  |  _ \| ____| __ )  Autor: Patricio Echagüe Ballesteros
#  | |_) |  _| |  _ \  Descripción: Enciende o apaga 
#  |  __/| |___| |_) | monitor virtual leyendo monitors.lua
#  |_|   |_____|____/  Para conectar tablet con Weylus
#
#######################################################

# Ruta a archivo de configuración de monitores
CONFIG_FILE="$HOME/.config/hypr/config/monitors.lua" # Ajusta la ruta si es diferente

if hyprctl monitors | grep -q "HEADLESS-1"; then
    # Si existe, la destruimos para apagarla
    hyprctl output remove HEADLESS-1
    notify-send "Monitor Virtual" "HEADLESS-1 desactivado"
else
    # Si no existe, creamos la salida headless primero
    hyprctl output create headless HEADLESS-1

    # Intentamos extraer los valores del monitors.lua si existe el bloque para HEADLESS-1
    if [ -f "$CONFIG_FILE" ]; then
        # Extraemos modo, posición y escala del bloque HEADLESS-1 en el archivo Lua
        MODE=$(awk '/HEADLESS-1/,/\}/' "$CONFIG_FILE" | grep "mode" | cut -d'"' -f2)
        POS=$(awk '/HEADLESS-1/,/\}/' "$CONFIG_FILE" | grep "position" | cut -d'"' -f2)
        SCALE=$(awk '/HEADLESS-1/,/\}/' "$CONFIG_FILE" | grep "scale" | cut -d'"' -f2)

        # Si los encuentra, los aplica mediante la API de Lua
        if [ -n "$MODE" ] && [ -n "$POS" ]; then
            SCALE="${SCALE:-1}"
            hyprctl eval "hl.monitor({ output = \"HEADLESS-1\", mode = \"$MODE\", position = \"$POS\", scale = \"$SCALE\", disabled = false })"
            notify-send "Monitor Virtual" "Activado (Modo: $MODE, Pos: $POS)"
            exit 0
        fi
    fi

    # Fallback por seguridad si no lee el archivo o no encuentra los valores
    hyprctl eval 'hl.monitor({ output = "HEADLESS-1", mode = "1800x1200@60", position = "0x590", scale = "1", disabled = false })'
    notify-send "Monitor Virtual" "HEADLESS-1 activado (Fallback)"
fi