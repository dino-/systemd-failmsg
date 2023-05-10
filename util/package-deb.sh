#! /bin/bash

projectName="systemd-failmsg"

# This script will build and package the project as a Debian .deb file for
# installation.

# Extract the project version from the generic install script
version=$(perl -ne "print \"\$1\n\" if /version=\"(.*)\"/" install.sh)

# Use it to make the top-level dist path
distRoot="${projectName}/${projectName}_${version}"

# Deploy the project's installation files to a prefix below the distRoot
PREFIX="${distRoot}" ./install.sh

# Copy the rest of the files needed for installation and Debian packaging
cp -rv util/resources/* "$distRoot"

# Update the Debian control file with the correct project version
perl -pi -e "s/Version: .*/Version: ${version}/" "${distRoot}/DEBIAN/control"

# Construct the .deb file
dpkg-deb --root-owner-group --build "$distRoot"

echo "Complete."
echo "To see the file's contents: $ dpkg-deb -c ${distRoot}.deb"
