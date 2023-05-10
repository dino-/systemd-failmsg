# systemd-failmsg


## Synopsis

A systemd service and script to send failure emails


## Description

This is a generic systemd service and script intended to be used as the
`OnFailure=` unit of other systemd units. The idea is to send an email to the
system operator(s) on failure. Any behavior could be substituted in place of
email by modifying the unit and/or script.


## Installation

### Manual Installation

If `systemd-failmsg` was installed via a distro package, skip to the Post
Installation section

The `install.sh` script will create a deployment directory for this project
with a default PREFIX of `./systemd-failmsg-VERSION`. It's possible to run this
with a different prefix like `/` but this isn't recommended over using a
distro-specific package so clean uninstallation is possible.

This script is used by other scripts in the source distribution to build
releases and for distro-specific packaging.


### Post Installation

This service will install by default with a toplevel-override setting it as the
`OnFailure` unit for every service on the system. This is achieved through the
files

    /usr/lib/systemd/system/service.d/toplevel-override.conf
    /usr/lib/systemd/system/failmsg@.service.d/toplevel-override.conf`

If this behavior is not desired, remove the two files above and manually add
the following line to any services you would like to use failmsg:

    [Unit]
    OnFailure=failmsg@%n.service

You will need a functioning sendmail-like installed on the system to be able to
send email. Installing and configuring this is beyond the scope of this
project.

You will also need to edit the `/etc/aliases` file, similarly to this:

    root: smedley@somewhere.com,someotherinterestedparty@somewhereelse.com
    smedley: smedley@somewhere.com

This service can also be used by unprivileged users by copying its systemd
files to a user unit directory, example:

    $ install -Dm0644 /usr/lib/systemd/system/failmsg@.service $HOME/.config/systemd/user/failmsg@.service
    $ install -Dm0644 /usr/lib/systemd/system/service.d/toplevel-override.conf $HOME/.config/systemd/user/service.d/toplevel-override.conf
    $ install -Dm0644 /usr/lib/systemd/system/failmsg@.service.d/toplevel-override.conf $HOME/.config/systemd/user/failmsg@.service.d/toplevel-override.conf

Regardless of the installation method, if the system hasn't been rebooted, it
may be necessary to daemon-reload systemd as is customary when adding/modifying
systemd unit files in general.

    # systemctl daemon-reload
    $ systemctl --user daemon-reload

### Testing your installation

To test, run with a dummy service:

    # /usr/bin/failmsg.sh foo.service  # Test the script
    # systemctl start failmsg@foo.service.service  # Test that the unit can call the script

If things are working properly, both of these commands should send you an email

To test more fully, try starting a service on your system that fails. For
convenience, one has been included in this distribution: always-fails.service


## Development

The source repository is at <https://github.com/dino-/systemd-failmsg>

To change the version number of this project, modify the version variable
assignment in `install.sh`

Packaging for deployment is done with the `install.sh` script. It will make a
directory like `systemd-failmsg-VERSION` which can then be packed as a .tar.gz
or used by distro-specific packaging.

To build a generic release .tar.gz of the distributable files, use the
`util/package.sh` script. This type of archive is used by the Arch AUR build.

To build a Debian .deb package, use the `util/package-deb.sh` script.


## Contact

Dino Morelli <[dino@ui3.info](mailto:dino@ui3.info)>
