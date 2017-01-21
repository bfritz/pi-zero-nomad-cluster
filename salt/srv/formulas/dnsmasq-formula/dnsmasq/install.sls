# vim: ft=sls
# How to install dnsmasq
{%- from "dnsmasq/map.jinja" import dnsmasq with context %}

dnsmasq_pkg:
  pkg.installed:
    - name: {{ dnsmasq.pkg }}

