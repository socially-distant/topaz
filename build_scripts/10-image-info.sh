#!/usr/bin/env bash

set -xeuo pipefail

IMAGE_REF="ostree-image-signed:docker://ghcr.io/${IMAGE_VENDOR}/${IMAGE_NAME}"
IMAGE_INFO="/usr/share/ublue-os/image-info.json"
IMAGE_FLAVOR="main"

cat >$IMAGE_INFO <<EOF
{
  "image-name": "${IMAGE_NAME}",
  "image-ref": "${IMAGE_REF}",
  "image-flavor": "${IMAGE_FLAVOR}",
  "image-vendor": "${IMAGE_VENDOR}",
  "image-tag": "${MAJOR_VERSION_NUMBER}",
  "rhel-version": "${MAJOR_VERSION_NUMBER}"
}
EOF

OLD_PRETTY_NAME="$(sh -c '. /usr/lib/os-release ; echo $NAME $VERSION')"
IMAGE_PRETTY_NAME="Topaz"
IMAGE_LIKE="rhel fedora"
HOME_URL="https://distant.social"
DOCUMENTATION_URL="https://distant.social"
SUPPORT_URL="https://github.com/socially-distant/topaz/issues/"
BUG_SUPPORT_URL="https://github.com/socially-distant/topaz/issues/"
CODE_NAME="Achillobator Giganticus"

# OS Release File (changed in order with upstream)
sed -i -f - /usr/lib/os-release <<EOF
s/^NAME=.*/NAME=\"${IMAGE_PRETTY_NAME}\"/
s|^VERSION_CODENAME=.*|VERSION_CODENAME=\"${CODE_NAME}\"|
s/^ID=rhel/ID=${IMAGE_PRETTY_NAME,}\nID_LIKE=\"${IMAGE_LIKE}\"/
s/^VARIANT_ID=.*/VARIANT_ID=${IMAGE_NAME}/
s/^PRETTY_NAME=.*/PRETTY_NAME=\"${IMAGE_PRETTY_NAME} (FROM $OLD_PRETTY_NAME)\"/
s|^HOME_URL=.*|HOME_URL=\"${HOME_URL}\"|
s|^BUG_REPORT_URL=.*|BUG_REPORT_URL=\"${BUG_SUPPORT_URL}\"|
s|^CPE_NAME=\"cpe:/o:rhel:rhel|CPE_NAME=\"cpe:/o:universal-blue:${IMAGE_PRETTY_NAME,}|

/^REDHAT_BUGZILLA_PRODUCT=/d
/^REDHAT_BUGZILLA_PRODUCT_VERSION=/d
/^REDHAT_SUPPORT_PRODUCT=/d
/^REDHAT_SUPPORT_PRODUCT_VERSION=/d
EOF

tee -a /usr/lib/os-release <<EOF
DOCUMENTATION_URL="${DOCUMENTATION_URL}"
SUPPORT_URL="${SUPPORT_URL}"
DEFAULT_HOSTNAME="${IMAGE_PRETTY_NAME,,}"
BUILD_ID="${SHA_HEAD_SHORT:-testing}"
EOF
