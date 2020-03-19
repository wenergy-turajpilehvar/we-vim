##!/bin/bash

####
#### To add TAR data to bash script:
####    cat payload.tar >> script.sh
####
#### To remove TAR data from bash script:
####    tac script.sh | awk '!f && /__TARFILE_FOLLOWS__/ { f=1 }; f' | tac | sponge script.sh
####

# Make sure we're super
echo "██ Checking for root ... "
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

# Script Varibles
SCRIPT_DIR="$(cd -P "$( dirname "${BASH_SOURCE[0]}" )" ; pwd)"
SKIP=$(awk '/^__TARFILE_FOLLOWS__/ { print NR + 1; exit 0; }' $0)

# Extract
echo "██ Extracting install ... "
tail -n +${SKIP} $0 | tar -ipx

# Install Vim
echo "██ Installing vim ... "
yum install -y vim
cp alias-we-vim.sh /etc/profile.d/alias-we-vim.sh
chmod 664 /etc/profile.d/alias-we-vim.sh
chown root:root /etc/profile.d/alias-we-vim.sh

# Move global vimrc
echo "██ Installing global vim settings ... "
mv vimrc /etc/vimrc
chmod 644 /etc/vimrc
chown root:root /etc/vimrc

# Confirm version
echo "██ Install complete."
echo ""
vim --version | grep "IMproved"
echo ""

exit 0

# NOTE: Don't place any newline characters after the last line below.
#
#
#
#
#
__TARFILE_FOLLOWS__
