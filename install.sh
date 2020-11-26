#! /bin/bash

PREFIX=${PREFIX:-"dist/usr"}

install -Dm0755 failmsg.sh "$PREFIX/bin/failmsg.sh"
install -Dm0644 "failmsg@.service" "$PREFIX/lib/systemd/system/failmsg@.service"
