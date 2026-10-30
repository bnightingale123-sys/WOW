#!/bin/bash
export LD_LIBRARY_PATH=/opt/acore/lib
echo "=== Auth recent ==="
ls -la /opt/acore/logs/ 2>/dev/null
# find all auth-related logs
find /opt/acore -name '*Auth*' -o -name '*auth*' 2>/dev/null | head
echo "=== Server.log login lines ==="
grep -iE 'account|login|auth|session|ip|disconnect|kick|error|fail|accept|client|GM|realm' /opt/acore/logs/Server.log 2>/dev/null | tail -40
echo "=== authserver.out ==="
tail -50 /opt/acore/logs/authserver.out 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g'
echo "=== world recent non-prompt ==="
tail -100 /opt/acore/logs/worldserver.out 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g' | grep -v '^AC>' | tail -40
echo "=== conf auth key ==="
grep -E '^(LogsDir|LogLevel|Logger|RealmServerPort|BindIP|WrongPass|MaxWrongPass|IPLocation|Updates)' /opt/acore/etc/authserver.conf | head -40
grep -E '^(LogsDir|Logger\.network|Logger\.auth|Logger\.entities|Warden)' /opt/acore/etc/worldserver.conf | head -30
