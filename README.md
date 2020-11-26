# systemd-failmsg


## Synopsis

A systemd service and script to send an email to the system operator(s) in the
event of failure in another unit


## Description

This is a generic systemd service and script intended to be used with the
`OnFailure=` Unit option of other systemd units. The idea is to send an email
on failure for some arbitrary unit(s) of your choosing. Any behavior could be
substituted in place of email by modifying the unit and/or script.


## Installation

### Manual Installation

If `systemd-failmsg` was installed via a distro package, skip to the Post
Installation section

Manual installation requires copying these files:

    # install -Dm0644 "failmsg@.service" "/usr/lib/systemd/system/failmsg@.service"
    # install -m0755 "failmsg.sh" "/usr/local/bin/failmsg.sh"  # Somewhere on the PATH

### Post Installation

You will need a functioning sendmail-like installed on the system to be able to
send email. Installing and configuring this is beyond the scope of this
project.

You will also need to edit the `/etc/aliases` file, similarly to this:

    root: smedley@somewhere.com someotherinterestedparty@somewhereelse.com
    smedley: smedley@somewhere.com

This service can also be used by unprivileged users by copying the service file
to a user unit directory, example (this directory may not yet exist in the
user's HOME directory):

    $ install -Dm0644 "/usr/lib/systemd/system/failmsg@.service" "~/.config/systemd/user/failmsg@.service"

Regardless of the installation method, it may be necessary to daemon-reload
systemd if the system hasn't been rebooted as is customary when
adding/modifying systemd unit files in general.

    # systemctl daemon-reload
    $ systemctl --user daemon-reload

### Testing your installation

The mail script can be tested alone:

    # /usr/bin/failmsg.sh alpha.service
    $ /usr/bin/failmsg.sh bravo.service

And the unit can be tested:

    # systemctl start failmsg\@charlie.service.service
    $ systemctl --user start failmsg\@delta.service.service

If all goes well, you should see emails for each of the four commands above,
and logs for the executions as well.

    $ journalctl -u failmsg\@charlie.service.service


## Using systemd-failmsg

To use `failmsg@.service` from another unit add a line to the Unit section, like this:

    [Unit]
    OnFailure=failmsg@%n.service

This is also documented in the comments in `failmsg@.service`

Of course, sending email is just a suggestion here. The `failmsg.sh` script can
do pretty much anything you want. The important part here is the
`failmsg@.service`


## Contact

Dino Morelli <[dino@ui3.info](mailto:dino@ui3.info)>
