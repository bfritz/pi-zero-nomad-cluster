
Shell scripts to install Arch Linux ARM on Raspberry Zero or
Raspberry Pi 3 for experimental [Nomad](https://www.nomadproject.io/)
cluster.

Scripts roughly follow the Arch Linux ARM installation instructions:

 * [Pi Zero](https://archlinuxarm.org/platforms/armv6/raspberry-pi#installation)
 * [Pi 3 32-bit](https://archlinuxarm.org/platforms/armv7/broadcom/raspberry-pi-2#installation)

After installing Arch, the Pi Zero script enables:

 * USB ethernet gadget and DHCP for `usb0`
 * USB serial gadget and TTY on `ttyGS0`

Scripts are intended for building Nomad cluster with [ClusterHAT](https://clusterhat.com/),
but might be useful for other purposes.

## Instructions

After connecting empty 4gb or larger MicroSD card to host computer
and assuming the MicroSD card is `/dev/mmcblk0`:

### For Pi Zero:

    cd pi-zero-nomad-cluster/install
    curl -OL http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-latest.tar.gz

    export SSH_PUB_KEY=$HOME/.ssh/id_rsa.pub   # private half will have root access to Arch install
    sudo -E ./install_pizero.sh /dev/mmcblk0   # WARNING!  Erases everything on `/dev/mmcblk0`!
    sudo umount /dev/mmcblk0p1
    sudo umount /dev/mmcblk0p2

### For Pi3 (or Pi2)

    cd pi-zero-nomad-cluster/install
    curl -OL http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz

    export SSH_PUB_KEY=$HOME/.ssh/id_rsa.pub   # private half will have root access to Arch install
    sudo -E ./install_pi3.sh /dev/mmcblk0      # WARNING!  Erases everything on `/dev/mmcblk0`!
    sudo umount /dev/mmcblk0p1
    sudo umount /dev/mmcblk0p2
