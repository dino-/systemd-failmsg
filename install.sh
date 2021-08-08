#! /bin/bash

version="1.2"

PREFIX=${PREFIX:-"systemd-failmsg-${version}"}

shareDir="$PREFIX/share/systemd-failmsg"

install -Dm0755 failmsg.sh "$PREFIX/bin/failmsg.sh"
install -Dm0644 "failmsg@.service" "$PREFIX/lib/systemd/system/failmsg@.service"
install -Dm0644 "LICENSE" "${shareDir}/doc/LICENSE"
install -Dm0644 "README.md" "${shareDir}/doc/README.md"
