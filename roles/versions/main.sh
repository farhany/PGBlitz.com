#!/bin/bash
#
# [Ansible Role]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 & Deiteq
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
one="abc"
two="abc"

while [ "$one" == "$two" ]; do
ansible-playbook /opt/plexguide/basics.yml --tags versions
program=$(cat /tmp/program_selection)
running=$(cat /opt/plexguide/roles/versions/scripts/ver.list | grep $program -oP )

if [ "$program" == "edge" ]; then
  ansible-playbook /opt/plexguide/pg.yml --tags pgedge
  clear
  exit
fi

  if [ "$program" == "edge" ]; then
    ansible-playbook /opt/plexguide/pg.yml --tags pgedge
    touch /var/plexguide/ask.yes 1>/dev/null 2>&1
    echo "INFO - Selected: Upgrade to PG EDGE" > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
    echo ""
    bash /opt/plexguide/roles/ending/ending.sh
    one="xyz"
    dialog --title "--- NOTE ---" --msgbox "\nPG $program Deployed!\n\nProcess Complete!" 0 0
    exit 0
  else
    touch /var/plexguide/ask.yes 1>/dev/null 2>&1
    version="$program"

    if [ "$program" == "$running" ]; then

        if dialog --stdout --title "Version User Confirmation" \
           --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
           --yesno "\nDo Want to Install: Version - $version?" 7 50; then

           touch /var/plexguide/ask.yes 1>/dev/null 2>&1
        else
          dialog --title "PG Update Status" --msgbox "\nExiting! User selected to NOT Install!" 0 0
          clear
          echo 'INFO - Selected Not To Upgrade PG' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
          sudo bash /opt/plexguide/roles/ending/ending.sh
          one="xyz"
          exit 0
        fi
    else
      clear
    fi
fi

if [ "$menu" == "update" ]; then
  echo 'INFO - Selected: PG Upgrades Menu Interface' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
  bash /opt/plexguide/roles/versions/main.sh
  exit
fi

echo 'INFO - Looping: PG Application Suite Interface' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
done

echo 'INFO - Selected: Exiting Application Suite Interface' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
exit