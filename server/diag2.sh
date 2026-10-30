#!/bin/bash
export LD_LIBRARY_PATH=/opt/acore/lib
echo "=== STATUS ==="
pgrep -a authserver; pgrep -a worldserver
ss -tlnp | grep -E '3724|8085'
echo "=== AUTH LOG FULL ==="
cat /opt/acore/logs/Auth.log 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g'
echo "=== AUTH OUT ==="
cat /opt/acore/logs/authserver.out 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g'
echo "=== Server.log recent player/auth ==="
grep -iE 'Account|Login|Player|Session|disconnect|Kick|Error|GM|Authentication|WorldSocket|Client' /opt/acore/logs/Server.log 2>/dev/null | tail -50
echo "=== OPENSSL / LDD auth ==="
ldd /opt/acore/bin/authserver | grep -iE 'ssl|crypto|mysql|not found'
echo "=== conf WrongPass/Logs ==="
grep -E '^(WrongPass|LogsDir|Logger|MaxPing|SourceDirectory|LoginDatabase)' /opt/acore/etc/authserver.conf | head -30
