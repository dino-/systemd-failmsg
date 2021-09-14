#! /bin/bash

version="1.3"

PREFIX=${PREFIX:-"systemd-failmsg-${version}"}
unitDir="$PREFIX/lib/systemd/system"
shareDir="$PREFIX/share/systemd-failmsg"

install -Dm0755 failmsg.sh "$PREFIX/bin/failmsg.sh"
install -Dm0644 "failmsg@.service" "$unitDir/failmsg@.service"
install -Dm0644 service.d_toplevel-override.conf "$unitDir/service.d/toplevel-override.conf"
install -Dm0644 failmsg@.service.d_toplevel-override.conf "$unitDir/failmsg@.service.d/toplevel-override.conf"
install -Dm0644 "LICENSE" "${shareDir}/doc/LICENSE"
install -Dm0644 "README.md" "${shareDir}/doc/README.md"
install -Dm0644 "always-fails.service" "${shareDir}/always-fails.service"
