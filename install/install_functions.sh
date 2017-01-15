usage() {
    echo "sudo $0 DEVICE"
    echo "  e.g. sudo $0 /dev/mmcblk0"
    exit 1
}

warning() {
    local disk="$1"

    echo
    echo "=========================================================================="
    echo
    echo "WARNING: About to erase contents of $disk !!!  Use CTRL-C to abort."
    echo
    echo "=========================================================================="
    echo
    echo "Current partitions:"
    echo
    sfdisk -l "$disk"
    echo
    sleep 5
}

function partition_disk() {
    local disk="$1"

    sfdisk "$disk" <<EOF
    8192,100M,c,*
    8192,3G,L
EOF
}

function format_partitions() {
    local disk="$1"

    mkfs.vfat "${disk}p1"
    mkfs.ext4 "${disk}p2"
}

function install_tarball() {
    local tarball="$1"
    local disk="$2"
    local mnt="$3"

    mount "${disk}p2" "$mnt"
    mkdir "$mnt/boot"
    mount "${disk}p1" "$mnt/boot"

    echo -n "Copying files..."
    bsdtar -xpf "$tarball" -C "$mnt"
    echo "done."

    echo -n "Syncing..."
    sync
    echo "done."
}

function _next_hw_addr() {
    local last_in_dec last_in_hex test_mac first_hw_addr assignment_log
    first_hw_addr="$1"
    assignment_log="$2"

    for last_in_dec in {10..254}
    do
        last_in_hex=$(printf '%.2x' $last_in_dec)
        test_mac=${first_hw_addr/%??/$last_in_hex}
        if ! grep -q "$test_mac" "$assignment_log" > /dev/null ; then
            echo "$test_mac" | tee -a "$assignment_log"
            return
        fi
    done
}

function configure_mac_addr() {
    local mnt="$1"
    local first_hw_addr="$2"
    local log="$3"

    local hw_addr
    hw_addr=$(_next_hw_addr "$first_hw_addr" "$log")

    cat <<EOF > "$mnt/etc/modprobe.d/gadget.conf"
# See http://linux-sunxi.org/USB_Gadget/Ethernet#Loading_the_driver_.28on_the_device.29
# and http://serverfault.com/a/40720
options g_cdc    host_addr=02:00:00:00:2c:01 dev_addr=$hw_addr
options g_ether  host_addr=02:00:00:00:2c:01 dev_addr=$hw_addr
EOF
}

function enable_services() {
    local mnt="$1"

    # pull address for usb0 interface via dhcp
    ln -s /usr/lib/systemd/system/dhcpcd.service "$mnt/etc/systemd/system/multi-user.target.wants/dhcpcd.service"

    # start TTY on USB gadget serial port
    ln -s /usr/lib/systemd/system/getty@.service "$mnt/etc/systemd/system/getty.target.wants/getty@ttyGS0.service"

    # disable systemd-resolved because it interferes with dhcpcd
    rm "$mnt/etc/systemd/system/multi-user.target.wants/systemd-resolved.service"
}

function configure_boot_options() {
    local mnt="$1"

    # 16m for GPU
    sed -i 's/^gpu_mem=[0-9]\+$/gpu_mem=16/' \
        "$mnt/boot/config.txt"

    # enable dwc2 driver for USB gadget mode
    if ! grep -q '^dtoverlay=dwc2' "$mnt/boot/config.txt" >/dev/null; then
        echo "dtoverlay=dwc2" >> "$mnt/boot/config.txt"
    fi

    # load dwc2 and g_cdc (ethernet + serial) modules on boot
    sed -i 's/rootwait console/rootwait modules-load=dwc2,g_cdc console/' \
        "$mnt/boot/cmdline.txt"
}

function authorize_ssk_key_for_root() {
    local mnt="$1"
    local pubkey="$2"

    mkdir -p "$mnt/root/.ssh"
    chmod 0700 "$mnt/root/.ssh"
    cat "$pubkey" >> "$mnt/root/.ssh/authorized_keys"
    chmod 0600 "$mnt/root/.ssh/authorized_keys"
}
