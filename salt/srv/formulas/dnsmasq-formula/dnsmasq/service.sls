# vim: ft=sls
# Manage service for service dnsmasq
{%- from "dnsmasq/map.jinja" import dnsmasq with context %}

'dnsmasq-service not configured':
  test.succeed_without_changes

#dnsmasq_service:
#  service.running:
#    - name: dnsmasq
#    - enable: True
#    - watch:
#        - file: dnsmasq_config

