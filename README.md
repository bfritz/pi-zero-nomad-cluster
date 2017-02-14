## Configure Raspberry Pi 3 manager:

 * Run [install_pi3.sh](install/install_pi3.sh) per the
   [instructions](install/README.md).

 * Install Python on manager for SaltStack:
   ```
   cd salt
   salt-ssh -i 'm*' --raw "test -f /usr/bin/python2 || pacman -Syu --noconfirm python2"
   ```

 * Finish configuration of manager with Salt:
   ```
   cd salt
   salt-ssh 'm*' state.apply
   ```
