#!/bin/bash
set -e
# Fix disconnect-related settings
CONF=/opt/acore/etc/worldserver.conf
cp -a "$CONF" "$CONF.bak.$(date +%s)"

# Disable Warden (common kick cause on private clients)
sed -i 's/^Warden.Enabled = 1/Warden.Enabled = 0/' "$CONF"

# Longer active socket timeout (map load via /mnt/e is slow)
sed -i 's/^SocketTimeOutTimeActive = 60000/SocketTimeOutTimeActive = 300000/' "$CONF"
sed -i 's/^DisconnectToleranceInterval = 0/DisconnectToleranceInterval = 60/' "$CONF"

# Ensure bind
grep -n "^Warden.Enabled\|^SocketTimeOutTimeActive\|^DisconnectToleranceInterval\|^BindIP\|^WorldServerPort" "$CONF"

# Also sync Windows copy if different path used later
WINCONF=/mnt/e/wow/server/acore/run/etc/worldserver.conf
if [ -f "$WINCONF" ]; then
  sed -i 's/^Warden.Enabled = 1/Warden.Enabled = 0/' "$WINCONF" 2>/dev/null || true
  sed -i 's/^SocketTimeOutTimeActive = 60000/SocketTimeOutTimeActive = 300000/' "$WINCONF" 2>/dev/null || true
  sed -i 's/^DisconnectToleranceInterval = 0/DisconnectToleranceInterval = 60/' "$WINCONF" 2>/dev/null || true
fi

echo CONF_OK
