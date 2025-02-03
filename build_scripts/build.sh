#!/bin/bash

set -ouex pipefail


dnf install -y tmux

systemctl enable podman.socket

/var/tmp/build_scripts/packages-image-base.sh
/var/tmp/build_scripts/packages.sh
/var/tmp/build_scripts/cleanup.sh
