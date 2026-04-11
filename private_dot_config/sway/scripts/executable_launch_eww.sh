#!/bin/sh

pkill -x eww || true
eww daemon

for i in $(seq 1 10); do
    eww ping 2>/dev/null && break
    sleep 0.5
done

eww open-many cat_win senna_win fortune_win
