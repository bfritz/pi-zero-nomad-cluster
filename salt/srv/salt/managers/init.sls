# install clusterhat binary to control power to LED and Pi Zeros
install_clusterhat:
  file.managed:
    - name: /usr/local/bin/clusterhat
    - source: https://github.com/bfritz/clusterhat/releases/download/v0.0.1/clusterhat
    - source_hash: sha256=b2e38979b5137ad8560c018aadec48e504f1aa7f24b10fc8ec82bbb8bc85a733
    - user: root
    - group: root
    - mode: 0755
