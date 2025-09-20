#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
#dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

#systemctl enable podman.socket

# Create a /nix directory for the determinate systems installed to bind to
mkdir /nix

# Set up Steam Game Mode https://github.com/shahnawazshahin/steam-using-gamescope-guide
SCRIPT_PERMISSIONS="755"
SESSION_FILE_PERMISSIONS="644"
SOURCE_DIR="/tmp/steam-scripts"

mkdir $SOURCE_DIR
tar -xzf /ctx/steam-scripts.tar.gz -C $SOURCE_DIR --strip-components=1

mkdir /usr/bin/steamos-polkit-helpers

cp $SOURCE_DIR/usr/bin/gamescope-session /usr/bin/gamescope-session
chmod $SCRIPT_PERMISSIONS /usr/bin/gamescope-session

cp $SOURCE_DIR/usr/bin/jupiter-biosupdate /usr/bin/jupiter-biosupdate
chmod $SCRIPT_PERMISSIONS /usr/bin/jupiter-biosupdate
cp $SOURCE_DIR/usr/bin/steamos-polkit-helpers/jupiter-biosupdate /usr/bin/steamos-polkit-helpers/jupiter-biosupdate
chmod $SCRIPT_PERMISSIONS /usr/bin/steamos-polkit-helpers/jupiter-biosupdate

cp $SOURCE_DIR/usr/bin/steamos-select-branch /usr/bin/steamos-select-branch
chmod $SCRIPT_PERMISSIONS /usr/bin/steamos-select-branch

cp $SOURCE_DIR/usr/bin/steamos-session-select /usr/bin/steamos-session-select
chmod $SCRIPT_PERMISSIONS /usr/bin/steamos-session-select

cp $SOURCE_DIR/usr/bin/steamos-update /usr/bin/steamos-update
chmod $SCRIPT_PERMISSIONS /usr/bin/steamos-update
cp $SOURCE_DIR/usr/bin/steamos-polkit-helpers/steamos-update /usr/bin/steamos-polkit-helpers/steamos-update
chmod $SCRIPT_PERMISSIONS /usr/bin/steamos-polkit-helpers/steamos-update

cp $SOURCE_DIR/usr/bin/steamos-polkit-helpers/steamos-set-timezone /usr/bin/steamos-polkit-helpers/steamos-set-timezone
chmod $SCRIPT_PERMISSIONS /usr/bin/steamos-polkit-helpers/steamos-set-timezone

cp $SOURCE_DIR/usr/share/wayland-sessions/steam.desktop /usr/share/wayland-sessions/steam.desktop
chmod $SESSION_FILE_PERMISSIONS /usr/share/wayland-sessions/steam.desktop
