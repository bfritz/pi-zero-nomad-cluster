Usage:

 * Create base images using [install](install/) scripts.
 * Install python on cluster members to support SaltStack:
   ```
   cd salt
   salt-ssh -i '*' --raw "test -f /usr/bin/python2 || pacman -Syu --noconfirm python2"
   ```

 * Configure cluster with Salt:
   ```
   cd salt
   salt-ssh -i '*' state.apply
   ```
