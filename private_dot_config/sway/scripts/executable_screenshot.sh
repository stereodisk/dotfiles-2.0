#!/bin/bash

mkdir -p ~/Pictures/Screenshots

case $1 in
    full)
        FILE=~/Pictures/Screenshots/full_$(date +'%Y-%m-%d_%H-%M-%S').png
        grim - | convert - "$FILE"
        swappy -f "$FILE" -o "$FILE"
        wl-copy -t image/png < "$FILE"
        notify-send -a "System" -i "$FILE" "Captura" "Captura de pantalla guardada"
        ;;
    selection)
        FILE=~/Pictures/Screenshots/area_$(date +'%Y-%m-%d_%H-%M-%S').png
        grim -g "$(slurp)" - | convert - "$FILE"
        swappy -f "$FILE" -o "$FILE"
        wl-copy -t image/png < "$FILE"
        notify-send -a "System" -i "$FILE" "Captura de Area" "Captura de area guardada"
        ;;
esac
