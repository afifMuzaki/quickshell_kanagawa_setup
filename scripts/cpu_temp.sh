#!/bin/sh

for zone in /sys/class/thermal/thermal_zone*; do
  if [[ -f $zone/type && $(cat $zone/type 2>/dev/null) = "x86_pkg_temp" ]]; then
    temp=$(cat "$zone/temp" 2>/dev/null)
    if [ -n "$temp" ]; then
      echo $((temp / 1000))
      exit 0
    fi
  fi
done

echo "0"
