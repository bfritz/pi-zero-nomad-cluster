#!/bin/bash

set -e

source ./install_functions.sh

DISK="$1"
MNT="$(mktemp -d)"
# wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz
TARBALL=ArchLinuxARM-rpi-2-latest.tar.gz
SSH_PUB_KEY="${SSH_PUB_KEY:-$HOME/.ssh/id_rsa.pub}"


[[ $EUID -eq 0 && -b "$DISK" && -w "$DISK" ]] || usage
warning "$DISK"
partition_disk "$DISK"
format_partitions "$DISK"
install_tarball "$TARBALL" "$DISK" "$MNT"
reduce_gpu_allocation "$MNT"
authorize_ssk_key_for_root "$MNT" "$SSH_PUB_KEY"
