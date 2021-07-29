#! /bin/bash

# This script is called by the failmsg@.service unit to send email to the user
# whose unit has failed
#
# For this to work, root and possibly one or more user accounts will need to be
# mapped to real email addresses in /etc/aliases and you will need a
# functioning sendmail-like installed.
#
# To test the script, just run it with any input: `failmsg.sh foobar` and it
# should send an email.

unitName="$1"
host=$(hostname)

if [ "$(id -u)" == "0" ]
  then
    journalctlPrefix="journalctl"
    fromAddr="root@${host}.localdomain"
    toAddr="root"
  else
    journalctlPrefix="journalctl --user"
    fromAddr="${USER}@${host}.localdomain"
    toAddr="${USER}"
fi

log=$(${journalctlPrefix} -u "$unitName" | tail)

sendmail -t <<MESSAGE
From: ${fromAddr}
To: ${toAddr}
Subject: Service $unitName on $host has failed

log excerpt:

$log

See more with '${journalctlPrefix} -u $unitName'
MESSAGE
