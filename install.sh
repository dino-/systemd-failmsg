#! /bin/bash

version="1.1"

distRoot=${1:-"systemd-failmsg-${version}"}
prefix="$distRoot/${2:-usr/local}"

shareDir="$prefix/share/systemd-failmsg"

install -Dm0755 failmsg.sh "$prefix/bin/failmsg.sh"
install -Dm0644 "failmsg@.service" "${distRoot}/etc/systemd/system/failmsg@.service"
install -Dm0644 "LICENSE" "${shareDir}/doc/LICENSE"
install -Dm0644 "README.md" "${shareDir}/doc/README.md"
