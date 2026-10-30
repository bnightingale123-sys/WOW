#!/bin/bash
CONF=/opt/acore/etc/authserver.conf
# bump wrong pass logging
sed -i 's/^WrongPass.Logging = .*/WrongPass.Logging = 1/' "$CONF"
# ensure Logger if present
if grep -q '^Logger.root' "$CONF"; then
  sed -i 's/^Logger.root=.*/Logger.root=4,Console Auth/' "$CONF"
fi
# restart ONLY auth quickly to pick wrongpass logging - world can stay
export LD_LIBRARY_PATH=/opt/acore/lib
pkill -x authserver || true
sleep 1
cd /opt/acore/bin
: > /opt/acore/logs/authserver.out
nohup ./authserver -c /opt/acore/etc/authserver.conf >> /opt/acore/logs/authserver.out 2>&1 &
disown
for i in $(seq 1 20); do
  ss -tlnp | grep -q ':3724' && break
  sleep 1
done
ss -tlnp | grep 3724
pgrep -a authserver
# confirm no lost connection
sleep 3
if grep -qi 'Lost connection\|ERROR' /opt/acore/logs/authserver.out; then
  echo AUTH_HAS_ERRORS
  cat /opt/acore/logs/authserver.out
else
  echo AUTH_CLEAN
  tail -5 /opt/acore/logs/Auth.log
fi
