#!/bin/bash
set -e
export LD_LIBRARY_PATH=/mnt/e/wow/server/acore/run/lib
chmod +x /mnt/e/wow/server/acore/run/bin/*
echo "ldd check:"
ldd /mnt/e/wow/server/acore/run/bin/dbimport | grep -E "not found|mysql|icu|ncurses" || true
cd /mnt/e/wow/server/acore/run/bin
./dbimport -c /mnt/e/wow/server/acore/run/etc/dbimport.conf
echo DBIMPORT_OK