#! /bin/bash

version="1.5"
projectName="systemd-failmsg"

PREFIX=${PREFIX:-"${projectName}-${version}"}
unitDir="$PREFIX/usr/lib/systemd/system"
shareDir="$PREFIX/usr/share/${projectName}"

install -Dm0755 failmsg.sh "$PREFIX/usr/bin/failmsg.sh"
install -Dm0644 "failmsg@.service" "$unitDir/failmsg@.service"
install -Dm0644 service.d_toplevel-override.conf "$unitDir/service.d/toplevel-override.conf"
install -Dm0644 failmsg@.service.d_toplevel-override.conf "$unitDir/failmsg@.service.d/toplevel-override.conf"
install -Dm0644 "LICENSE" "${shareDir}/doc/LICENSE"
install -Dm0644 "README.md" "${shareDir}/doc/README.md"
install -Dm0644 "always-fails.service" "${shareDir}/always-fails.service"
