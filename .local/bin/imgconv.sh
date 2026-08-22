#!/usr/bin/env bash

#######################################################
#   ____  _____ ____  
#  |  _ \| ____| __ )  Autor: 
#  | |_) |  _| |  _ \  Patricio Echagüe Ballesteros
#  |  __/| |___| |_) | Descripción:
#  |_|   |_____|____/  Conversor de formatos gráficos
#
# Uso: Uso: imgconv <archivo_o_directorio> [formato_destino]
#######################################################

# Verificar argumentos
if [ $# -lt 1 ]; then
    echo "Uso: imgconv <archivo_o_directorio> [formato_destino]"
    echo ""
    echo "Opciones disponibles:"
    echo "  (sin formato) - Abre el selector interactivo (TUI) para elegir formato"
    echo "  webp          - Convierte directamente a WebP"
    echo "  png           - Convierte directamente a PNG"
    echo "  jpg           - Convierte directamente a JPG"
    echo "  avif          - Convierte directamente a AVIF"
    echo ""
    echo "Ejemplos:"
    echo "  imgconv imagen.png            # Abre TUI para elegir destino"
    echo "  imgconv foto.jpg webp         # Convierte directo a webp"
    echo "  imgconv ./imagenes            # Abre TUI para elegir archivo y formato"
    exit 1
fi

INPUT="$1"

# Si es un directorio o se pasó sin formato, usar TUI con gum
if [ -d "$INPUT" ]; then
    FILE=$(gum file "$INPUT")
    [ -z "$FILE" ] && exit 0
else
    FILE="$INPUT"
fi

# Si no se especificó formato en el segundo argumento, desplegar menú TUI
if [ -z "$2" ]; then
    FORMAT=$(gum choose "webp" "png" "jpg" "avif" "gif")
    [ -z "$FORMAT" ] && exit 0
else
    FORMAT="$2"
fi

OUTPUT="${FILE%.*}.$FORMAT"

# Ejecución de la conversión mediante ImageMagick
magick "$FILE" "$OUTPUT" && gum spin --title "Convirtiendo a $FORMAT..." -- sleep 0.5
gum style --foreground 212 "¡Convertido con éxito a $OUTPUT!"