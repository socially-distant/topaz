ARG MAJOR_VERSION="${MAJOR_VERSION:-9.5}"
FROM ghcr.io/ublue-os/config:latest@sha256:69fc2336720c1b2774d2c984a1ea2005612f0507a24de60a15e9564aca1d835c AS config
FROM quay.io/almalinuxorg/almalinux-bootc:$MAJOR_VERSION

# ARM should be handled by $(arch)
ARG ENABLE_DX="${ENABLE_DX:-0}"
ARG ENABLE_HWE="${ENABLE_HWE:-0}"
ARG ENABLE_GDX="${ENABLE_GDX:-0}"
ARG IMAGE_NAME="${IMAGE_NAME:-topaz}"
ARG IMAGE_VENDOR="${IMAGE_VENDOR:-socially-distant}"
ARG MAJOR_VERSION="${MAJOR_VERSION:-lts}"
ARG SHA_HEAD_SHORT="${SHA_HEAD_SHORT:-}"

COPY build_scripts /var/tmp/build_scripts

RUN mkdir -p /var/lib/alternatives
RUN --mount=type=tmpfs,dst=/tmp --mount=type=bind,from=config,src=/rpms,dst=/tmp/rpms /var/tmp/build_scripts/build.sh
