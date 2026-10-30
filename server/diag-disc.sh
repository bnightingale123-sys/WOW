#!/bin/bash
export LD_LIBRARY_PATH=/opt/acore/lib
echo PROCESSES:
pgrep -a authserver || echo NO_AUTH
pgrep -a worldserver || echo NO_WORLD
free -m | head -2
echo PORTS:
ss -tlnp | grep -E '3724|8085' || echo NO_PORTS
echo AUTH_ERR:
grep -E 'Lost connection|ERROR|Error' /opt/acore/logs/authserver.out /opt/acore/logs/Auth.log 2>/dev/null | tail -15
echo WORLD_TAIL:
tail -30 /opt/acore/logs/worldserver.out 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g' | grep -v '^AC>' | tail -20
echo SERVER_LOG:
grep -iE 'disconnect|kick|crash|error|Lost|Killed|Player|Account|GM' /opt/acore/logs/Server.log 2>/dev/null | tail -25
