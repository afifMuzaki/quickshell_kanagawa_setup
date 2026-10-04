#!/bin/sh

first=1

printf "{"
for f in /sys/class/hwmon/hwmon*/fan*_input; do
  [[ -r $f ]] || continue
  d=$(dirname "$f")
  [ $first -eq 0 ] && printf ", "
  first=0
  printf "\"%s_%s_%s\": %s" "${d##*/}" "$(cat $d/name)" "$(basename $f _input)" "$(cat $f)"
done
printf "}\n"
