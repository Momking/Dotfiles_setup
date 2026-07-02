#!/bin/bash

gremlin_list=("hikari" "agnes-tachyon" "cafe" "gold-ship" "haru-urara" "mambo" "meisho-doto" "oguri-cap" "opera" "rice-shower")
selection=$(printf '%s\n' "${gremlin_list[@]}" | wofi -d -i -p "Gremlin: " --width=500 --height=300)
RUN_SCRIPT="/home/nishant/.config/linux-desktop-gremlin/run.sh"

for i in "${gremlin_list[@]}"; do
    if [ "$selection" == "$i" ]; then
        $RUN_SCRIPT $i &
        exit 0
    fi
done