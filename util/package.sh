#! /bin/bash

# This script will build and package a release of the project as a generic
# .tar.gz file

# Extract the project version from the generic install script
version=$(perl -ne "print \"\$1\n\" if /version=\"(.*)\"/" install.sh)

# Use it to make the top-level dist path
distRoot="systemd-failmsg-${version}"

# Deploy the project's installation files in the distRoot directory
PREFIX="${distRoot}" ./install.sh

# Archive the files into a release
tar czvf "${distRoot}.tar.gz" "${distRoot}"

echo "Complete."
echo "To see the file's contents: $ tar tzvf ${distRoot}.tar.gz"
