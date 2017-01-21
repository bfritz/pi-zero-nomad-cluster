# vim: ft=sls
# How to configure dnsmasq
{%- from "dnsmasq/map.jinja" import dnsmasq with context %}

dnsmasq_main_config:
  file.managed:
    - name: '/etc/dnsmasq.conf'
    - source: salt://dnsmasq/files/dnsmasq.conf
    - user: root
    - group: root
    - mode: 0640

dnsmasq_conf.d_directory:
  file.directory:
    - name: '/etc/dnsmasq.d'
    - user: root
    - group: root
    - mode: 0750

dnsmasq_nodes_config:
  file.managed:
    - name: '/etc/dnsmasq.d/nodes.conf'
    - source: salt://dnsmasq/files/nodes.conf
    - user: root
    - group: root
    - mode: 0640
