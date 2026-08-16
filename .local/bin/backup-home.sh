#######################################################
#   ____  _____ ____  
#  |  _ \| ____| __ )  Autor: 
#  | |_) |  _| |  _ \  Patricio Echagüe Ballesteros
#  |  __/| |___| |_) | Descripción:
#  |_|   |_____|____/  Script de respaldo de /home (diario y semanal estilo Timeshift)
#
#######################################################

#!/bin/bash

# CONFIGURACIÓN
SOURCE_DIR="$HOME/"
BACKUP_DIR="/mnt/debian/backup/rsync_cachyos"

# Recibe 'daily' o 'weekly' como argumento
TYPE=$1

if [ "$TYPE" != "daily" ] && [ "$TYPE" != "weekly" ]; then
    echo "Uso: $0 {daily|weekly}"
    exit 1
fi

# Verificar si el disco externo está montado
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Error: El almacenamiento externo no está montado en $BACKUP_DIR"
    exit 1
fi

TARGET_DIR="$BACKUP_DIR/$TYPE"
LATEST_LINK="$TARGET_DIR/latest"
DATETIME=$(date +%Y-%m-%d_%H-%M-%S)
CURRENT_BACKUP="$TARGET_DIR/$DATETIME"

mkdir -p "$TARGET_DIR"

# Lógica Incremental usando --link-dest
OPT_LINK=""
if [ -L "$LATEST_LINK" ]; then
    OPT_LINK="--link-dest=$LATEST_LINK"
fi

# echo "Iniciando respaldo incremental ($TYPE) de $SOURCE_DIR hacia $CURRENT_BACKUP..."

# Ejecutar rsync
# Excluimos cachés y cosas innecesarias para ahorrar espacio y tiempo
rsync -av --delete $OPT_LINK \
    --exclude '.cache/' \
    --exclude '.cargo/' \
    --exclude '.node_repl_history' \
    --exclude 'VirtualBox VMs/' \
    --exclude '.vagrant.d/' \
    --exclude 'GoogleDrive/' \
    --exclude 'MEGA/' \
    "$SOURCE_DIR" "$CURRENT_BACKUP"

# Actualizar el enlace 'latest' para el próximo respaldo incremental
rm -f "$LATEST_LINK"
ln -s "$CURRENT_BACKUP" "$LATEST_LINK"

# --- ROTACIÓN (Mantenidos 3 diarios y 2 semanales) ---
# Nota: "latest" es un enlace dentro del directorio, por lo que ocupa un lugar en ls.
# - Para 3 copias diarias: conservamos 3 carpetas + 1 symlink = 4 elementos. Borramos a partir del 5º (+5).
# - Para 2 copias semanales: conservamos 2 carpetas + 1 symlink = 3 elementos. Borramos a partir del 4º (+4).

if [ "$TYPE" == "daily" ]; then
    ls -dt "$TARGET_DIR"/*/ | tail -n +5 | while read -r dir; do
        [ -d "$dir" ] && rm -rf "$dir"
    done
elif [ "$TYPE" == "weekly" ]; then
    ls -dt "$TARGET_DIR"/*/ | tail -n +4 | while read -r dir; do
        [ -d "$dir" ] && rm -rf "$dir"
    done
fi


# echo "¡Respaldo ($TYPE) completado con éxito!"

# Notificación
/usr/bin/notify-send -u critical "Backup" "¡Respaldo ($TYPE) completado con éxito!"