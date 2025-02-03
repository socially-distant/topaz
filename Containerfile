ARG MAJOR_VERSION="${MAJOR_VERSION:-9.5}"
FROM ghcr.io/ublue-os/config:latest@sha256:69fc2336720c1b2774d2c984a1ea2005612f0507a24de60a15e9564aca1d835c AS config
FROM quay.io/almalinuxorg/almalinux-bootc:$MAJOR_VERSION

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:stable
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
# 
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

COPY build_scripts /var/tmp/build_scripts

RUN mkdir -p /var/lib/alternatives
RUN --mount=type=tmpfs,dst=/tmp --mount=type=bind,from=config,src=/rpms,dst=/tmp/rpms /var/tmp/build_scripts/build.sh
