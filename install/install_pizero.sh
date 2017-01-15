#!/bin/bash

set -e

source ./install_functions.sh

DISK="$1"
MNT="$(mktemp -d)"
# wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-latest.tar.gz
TARBALL=ArchLinuxARM-rpi-latest.tar.gz
SSH_PUB_KEY="${SSH_PUB_KEY:-$HOME/.ssh/id_rsa.pub}"

MAC_ASSIGNMENT_LOG=assignment.log
HOST_MAC_ADDR=02:00:00:00:2c:01


#[[ $EUID -eq 0 && -b "$DISK" && -w "$DISK" ]] || usage
warning "$DISK"
partition_disk "$DISK"
format_partitions "$DISK"
install_tarball "$TARBALL" "$DISK" "$MNT"
configure_mac_addr "$MNT" "$HOST_MAC_ADDR" "$MAC_ASSIGNMENT_LOG"
enable_services "$MNT"
configure_boot_options "$MNT"
authorize_ssk_key_for_root "$MNT" "$SSH_PUB_KEY"
