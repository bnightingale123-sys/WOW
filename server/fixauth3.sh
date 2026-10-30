#!/bin/bash
export LD_LIBRARY_PATH=/opt/acore/lib
# if auth has lost mysql, restart it
if grep -q "Lost connection" /opt/acore/logs/authserver.out 2>/dev/null || grep -q "Lost connection" /opt/acore/logs/Auth.log 2>/dev/null; then
  echo NEED_AUTH_RESTART
  pkill -x authserver || true
  sleep 1
  cd /opt/acore/bin
  : > /opt/acore/logs/authserver.out
  nohup ./authserver -c /opt/acore/etc/authserver.conf >> /opt/acore/logs/authserver.out 2>&1 &
  disown
  sleep 3
fi
pgrep -a authserver
pgrep -a worldserver
ss -tlnp | grep -E '3724|8085'
echo "--- Auth.log tail ---"
tail -8 /opt/acore/logs/Auth.log | sed 's/\x1b\[[0-9;]*m//g'
echo "--- auth out ---"
cat /opt/acore/logs/authserver.out | sed 's/\x1b\[[0-9;]*m//g'
if grep -q "Lost connection" /opt/acore/logs/authserver.out 2>/dev/null; then echo STILL_BAD; else echo AUTH_OK; fi
