#!/bin/bash
grep -E '^(Warden.Enabled|SocketTimeOutTimeActive|DisconnectToleranceInterval)' /opt/acore/etc/worldserver.conf
echo ---
free -m
pgrep -a authserver
pgrep -a worldserver
grep -i warden /opt/acore/logs/Server.log | tail -5
tail -5 /opt/acore/logs/Auth.log
