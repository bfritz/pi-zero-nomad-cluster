
Shell script that roughly follows Arch Linux ARM
[installation instructions](https://archlinuxarm.org/platforms/armv6/raspberry-pi#installation)
for the Raspberry Pi Zero.  After installing Arch, it enables:

    * USB ethernet gadget and DHCP for `usb0`
    * USB serial gadget and TTY on `ttyGS0`

Makes it easy to bootstrap a Pi Zero to the point where
you can plug it in to a host computer via USB and connect
via SSH or serial console.

## Example Usage:

After connecting empty 4gb or larger MicroSD card to host computer
and assuming the MicroSD card is `/dev/mmcblk0`:

    $ cd arch-pizero-gadget
    $ curl -OL http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-latest.tar.gz
    $ sudo ./install_arch.sh /dev/mmcblk0   # WARNING!  Erases everything on `/dev/mmcblk0`!
    $ sudo umount /dev/mmcblk0p1
    $ sudo umount /dev/mmcblk0p2

Then remove MicroSD card from host computer, insert it into
Pi Zero, and connect Pi to host computer via USB using the
`USB`, not `PWR`, connector.
