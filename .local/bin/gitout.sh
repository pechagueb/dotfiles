#!/bin/bash

#######################################################
#   ____  _____ ____  
#  |  _ \| ____| __ )  Autor: 
#  | |_) |  _| |  _ \  Patricio Echagüe Ballesteros
#  |  __/| |___| |_) | Descripción:
#  |_|   |_____|____/  Automatiza actualización dir en Github
#
#######################################################

# Verificar si se pasó el mensaje del commit como argumento
if [ -z "$1" ]; then
    echo "❌ Error: Debes proporcionar un mensaje para el commit."
    echo "Uso: $0 \"tu mensaje de commit\""
    exit 1
fi

# Guardar el mensaje en una variable
MENSAJE="$1"

echo "📦 Añadiendo cambios..."
git add --all

echo "💾 Creando commit: \"$MENSAJE\"..."
git commit -m "$MENSAJE"

echo "🚀 Subiendo a GitHub (master)..."
git push origin master

echo "✅ ¡Todo listo y subido!"
