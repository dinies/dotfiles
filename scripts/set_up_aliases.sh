#!/bin/bash
set -e

#this does  not work yet, trying to avoid expansion of the commands 1-4 
# but if I don't use $() then there are nested apices "" "" and "" '' 
cmd_part_1= "$(dpkg-query --show --showformat='${Package;-50}\t${Installed-Size}\n')" 
cmd_part_2= "$(sort -k 2 -n)"
cmd_part_3= "$(grep -v deinstall)" 
cmd_part_4= "$(awk '{printf "%.3f MB \t %s\n", $2/(1024), $1}')"
echo "$cmd_part_1 | $cmd_part_2 | $cmd_part_3 | $cmd_part_4" >> /home/$USERNAME/.bashrc

