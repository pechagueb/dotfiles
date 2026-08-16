#######################################################
#   ____  _____ ____  
#  |  _ \| ____| __ )  Autor: 
#  | |_) |  _| |  _ \  Patricio Echagüe Ballesteros
#  |  __/| |___| |_) | Descripción:
#  |_|   |_____|____/  Muestra notificación con HORA y METEO
#
# Versión: 2.0 (Optimizado para systemd --user)
#######################################################

#!/bin/bash

HORA=$(date "+%a, %d %B %Y - %H:%M")
METEO=$(curl wttr.in/28.4152062,-16.4986277?format="+%c+%t+%m+%M\n")

/usr/bin/notify-send -u critical "$HORA" "$METEO"
