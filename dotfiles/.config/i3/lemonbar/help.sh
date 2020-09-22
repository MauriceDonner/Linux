#!/usr/local/bin/bash
 
height=14
bgcolor=#1e1e1e
fgcolor=#eeeeee
font1="-*-gohufont-medium-*-*-*-11-*-*-*-*-*-*-*"
clockicon="%{T2}\ue016"
batteryicon=""
titleicon="%{T2}%{F#999999}\ue13a%{F-}"
 
clock() {
        TIME=$(date +%H:%M)
        echo -e "$clockicon %{T1}$TIME "
}
 
title() {
        WINDOW=$(xdotool getwindowfocus getwindowname)
        echo -e "$titleicon %{T1}$WINDOW "
}
 
battery() {
        BAT=$(apm -l)
        AC=$(apm -a)
        if [[ "$AC" > 0 ]] ; then
                batteryicon="\ue23a"
        elif [[ "$BAT" < 25 ]] ; then
                batteryicon="\ue236"
        elif [[ "$BAT" < 75 ]] ; then
                batteryicon="\ue237"
        elif [[ "$BAT" > 74 ]] ; then
                batteryicon="\ue238"
        fi
 
        echo -e "%{T2}$batteryicon %{T1}$BAT% "
}
 
net() {
        WIFIICON='%{T2}\ue25c'
        WIREDICON='\ue14a'
        WIFISTATUS=$(ifconfig iwn0 | grep active)
        if [[ -n "$WIFISTATUS" ]] ; then
                NWID=$(ifconfig iwn0 | grep join | awk '{ print $3}' | tr -cd [:alnum:] )
                echo -e "$WIFIICON $NWID "
        fi
}
 
vol() {
        CURVOL=$(bc -l <<< "scale=0;$(mixerctl | grep outputs.master= | sed 's/.*,//g')/2.55")
        MUTED=$(mixerctl | grep outputs.master.mute=on)  
        if [[ "$MUTED" ]] ; then
                echo -e "%{F#666666}%{T2}\ue0e1 %{T1}$CURVOL% %{F-}"
        else
                echo -e "%{T2}\ue0e1 %{T1}$CURVOL% "
        fi
}
while true; do
        echo " $(title)  %{r} $(net)$(vol)$(battery)$(clock)"
        sleep .5
done | lemonbar -d -g  1366x$height -B "$bgcolor"  -F "$fgcolor" -U "$fgcolor" -f "$font1" -f "-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1"
