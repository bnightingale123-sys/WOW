#!/bin/bash
OUT=/out
rm -rf "$OUT"/*
# dereference symlinks so Windows mount gets real files
for f in \
  /lib/x86_64-linux-gnu/libmysqlclient.so.21 \
  /lib/x86_64-linux-gnu/libicudata.so.74 \
  /lib/x86_64-linux-gnu/libicui18n.so.74 \
  /lib/x86_64-linux-gnu/libicuuc.so.74 \
  /lib/x86_64-linux-gnu/libncurses.so.6 \
  /lib/x86_64-linux-gnu/libtinfo.so.6 \
  /lib/x86_64-linux-gnu/libreadline.so.8 \
  /lib/x86_64-linux-gnu/libbz2.so.1.0 \
  /lib/x86_64-linux-gnu/liblzma.so.5 \
  /lib/x86_64-linux-gnu/libz.so.1 \
  /lib/x86_64-linux-gnu/libzstd.so.1 \
  /lib/x86_64-linux-gnu/libssl.so.3 \
  /lib/x86_64-linux-gnu/libcrypto.so.3 \
  /lib/x86_64-linux-gnu/libstdc++.so.6 \
  /lib/x86_64-linux-gnu/libgcc_s.so.1 \
  /lib/x86_64-linux-gnu/libm.so.6 \
  /lib/x86_64-linux-gnu/libc.so.6 \
  /lib/x86_64-linux-gnu/libresolv.so.2
do
  if [ -e "$f" ]; then
    base=$(basename "$f")
    cp -L "$f" "$OUT/$base"
    echo "copied $base $(stat -c%s "$OUT/$base")"
  else
    # try usr path
    alt="/usr$f"
    if [ -e "$alt" ]; then
      base=$(basename "$alt")
      cp -L "$alt" "$OUT/$base"
      echo "copied $base $(stat -c%s "$OUT/$base")"
    else
      echo "MISSING $f"
    fi
  fi
done
# also try locate mysql via ldd
MYSQL=$(ldd /azerothcore/env/dist/bin/worldserver | awk '/libmysqlclient/ {print $3}')
if [ -n "$MYSQL" ] && [ -f "$MYSQL" ]; then
  cp -L "$MYSQL" "$OUT/libmysqlclient.so.21"
  echo "mysql from ldd $(stat -c%s "$OUT/libmysqlclient.so.21")"
fi
ls -lah "$OUT"
echo DONE
