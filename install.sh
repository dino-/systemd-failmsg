#! /bin/bash

version="1.0"

rootDir="systemd-failmsg-${version}"
PREFIX=${PREFIX:-"$rootDir/usr/local"}

shareDir="$PREFIX/share/systemd-failmsg"

install -Dm0755 failmsg.sh "$PREFIX/bin/failmsg.sh"
install -Dm0644 "failmsg@.service" "$rootDir/etc/systemd/system/failmsg@.service"
install -Dm0644 "LICENSE" "${shareDir}/doc/LICENSE"
install -Dm0644 "README.md" "${shareDir}/doc/README.md"
