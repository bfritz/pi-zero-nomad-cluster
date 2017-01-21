# vim: ft=sls
# Init dnsmasq
{%- from "dnsmasq/map.jinja" import dnsmasq with context %}
{# Below is an example of having a toggle for the state #}

{% if dnsmasq.enabled %}
include:
  - dnsmasq.install
  - dnsmasq.config
  - dnsmasq.service
{% else %}
'dnsmasq-formula disabled':
  test.succeed_without_changes
{% endif %}

