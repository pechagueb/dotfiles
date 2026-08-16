#######################################################
#   ____  _____ ____  
#  |  _ \| ____| __ )  Autor: 
#  | |_) |  _| |  _ \  Patricio Echagüe Ballesteros
#  |  __/| |___| |_) | Descripción:
#  |_|   |_____|____/  Sincronización GoogleDrive local con backup externo + notificación
#
# Versión: 2.0 (Optimizado para systemd --user)
#######################################################

#!/bin/bash

# 1. Sincronización
rsync -av --delete /home/patricioeb/GoogleDrive/ /mnt/debian/home/patricioeb/GoogleDrive/

# 2. Notificación final (systemd --user ya tiene el entorno gráfico)
/usr/bin/notify-send -u critical "Sync Google" "Sincronización completada con éxito"