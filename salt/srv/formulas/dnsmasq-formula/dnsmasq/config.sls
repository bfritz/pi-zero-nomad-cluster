# vim: ft=sls
# How to configure dnsmasq
{%- from "dnsmasq/map.jinja" import dnsmasq with context %}

dnsmasq_config:
  file.managed:
    - name: '/tmp/config.conf'
    - source: salt://dnsmasq/files/config.conf
    - user: root
    - group: root
    - mode: 0600
    - template: jinja
    - local_string: 'test string please ignore'

