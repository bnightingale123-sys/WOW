#!/bin/bash
set -e
df -h / /opt /mnt/e
echo ---
ls /opt/acore/data/
for d in maps vmaps mmaps dbc; do echo "$d: $(ls /opt/acore/data/$d 2>/dev/null | wc -l)"; done
echo --- conf ---
grep -n "Warden.Enabled" /opt/acore/etc/worldserver.conf
grep -n "SocketTimeOutTime" /opt/acore/etc/worldserver.conf
grep -n "DisconnectTolerance" /opt/acore/etc/worldserver.conf