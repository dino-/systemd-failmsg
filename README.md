# systemd-failmsg


## Synopsis

A systemd service and script to send failure emails


## Description

This is a generic systemd service and script intended to be used with the
`OnFailure=` Unit option of other systemd units. The idea is to send an email
to the system operator(s) on failure for some arbitrary unit(s) of your
choosing. Any behavior could be substituted in place of email by modifying the
unit and/or script.


## Installation

### Manual Installation

If `systemd-failmsg` was installed via a distro package, skip to the Post
Installation section

The `install.sh` script will create a deployment directory for this project
with a default PREFIX of `./systemd/failmsg-VERSION`. It's possible to run this
with a different prefix like `/usr` but this isn't recommended over using a
distro-specific package so clean uninstallation is possible.

This script is used to build releases and for distro-specific packaging.


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

Instructions for testing this are in the files `bin/failmsg.sh` and
`lib/systemd/system/failmsg@.service`


## Using systemd-failmsg

To use `failmsg@.service` from another unit add a line to the Unit section, like this:

    [Unit]
    OnFailure=failmsg@%n.service

This is also documented in the comments in `failmsg@.service`


## Development

The source repository is at <https://github.com/dino-/systemd-failmsg>

To change the version number of this project, modify the version variable
assignment in `install.sh`

Packaging for deployment is done with the `install.sh` script. It will make a
directory like `systemd-failmsg-VERSION` which can then be packed as a .tar.gz
or used by distro-specific packaging.

For building a Debian .deb package, use the `util/package.sh` script.


## Contact

Dino Morelli <[dino@ui3.info](mailto:dino@ui3.info)>
