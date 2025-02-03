#!/bin/bash

set -ouex pipefail

MAJOR_VERSION_NUMBER="$(sh -c '. /usr/lib/os-release ; echo $VERSION_ID')"
export MAJOR_VERSION_NUMBER

dnf install -y tmux

systemctl enable podman.socket

/var/tmp/build_scripts/packages-image-base.sh
/var/tmp/build_scripts/packages.sh
/var/tmp/build_scripts/cleanup.sh
