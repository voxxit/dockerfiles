#!/bin/bash

LIQUIDSOAP_VERSION=${1:-"2.2.0"}

if [ "$(id -u)" != "0" ]; then
  printf "You must be root to execute the script. Exiting.\n"
  exit 1
fi

if [ "$(uname -s)" != "Linux" ]; then
  printf "This script does not support '%s' Operating System. Exiting.\n" "$(uname -s)"
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y install --no-install-recommends wget ca-certificates

mkdir -p /etc/liquidsoap

if ! id -g liquidsoap >/dev/null 2>&1; then
  groupadd liquidsoap -g 1001
fi

if ! id -u liquidsoap >/dev/null 2>&1; then
  useradd -g liquidsoap -u 1001 -s /bin/false -d /etc/liquidsoap liquidsoap
fi

if ! command -v lsb_release; then
  apt-get -y --no-install-recommends install lsb-release
fi

# Detect OS version and architecture
OS_ID=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
OS_VERSION=$(lsb_release -cs)
OS_ARCH=$(dpkg --print-architecture)

# Check if the OS version is supported
SUPPORTED_OS=("bookworm" "bullseye" "focal" "jammy")
OS_SUPPORTED=false

for os in "${SUPPORTED_OS[@]}"; do
  if [ "$OS_VERSION" == "$os" ]; then
    OS_SUPPORTED=true
    break
  fi
done

if [ "$OS_SUPPORTED" = false ]; then
  printf "This script does not support '%s' OS version. Exiting.\n" "$OS_VERSION"
  exit 1
fi

# Set the liquidsoap package download URL based on OS version and architecture:
BASE_URL="https://github.com/savonet/liquidsoap/releases/download/v${LIQUIDSOAP_VERSION}/liquidsoap_${LIQUIDSOAP_VERSION}"
PACKAGE_URL="${BASE_URL}-${OS_ID}-${OS_VERSION}-1_${OS_ARCH}.deb"

# Ask for input for variables
DO_UPDATES="y"
USE_ST="y"

# Set the timezone to Europe/Amsterdam
if ! dpkg -s tzdata >/dev/null 2>&1; then
  apt-get -y --no-install-recommends install tzdata
fi
ln -fs /usr/share/zoneinfo/ /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

# Check if the DO_UPDATES variable is set to 'y'
if [ "$DO_UPDATES" == "y" ]; then
  apt-get -y upgrade && \
  apt-get -y autoremove --purge
fi

# Install FDKAAC and bindings
apt-get -y install fdkaac libfdkaac-ocaml libfdkaac-ocaml-dynlink

# Get deb package
wget "$PACKAGE_URL" -O "/tmp/liq_${LIQUIDSOAP_VERSION}.deb"

# Install deb package 
apt-get -y install "/tmp/liq_${LIQUIDSOAP_VERSION}.deb" --fix-broken

# Make dirs for files
mkdir -p /var/audio
chown -R liquidsoap:liquidsoap /etc/liquidsoap /var/audio