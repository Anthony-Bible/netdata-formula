
netdata_packages:
  pkg.installed:
    - pkgs:
      - curl
      - gnupg
      - apt-transport-https
      - debian-archive-keyring

netdata_repo:
  pkgrepo.managed:
    - name: deb https://packagecloud.io/netdata/netdata/debian/ {{ grains['oscodename'] }} main
    - key_url: https://packagecloud.io/netdata/netdata/gpgkey
    - require_in: 
      - netdata_install

netdata_install:
  pkg.installed:
    - pkgs:
      - netdata
#/etc/netdata/netdata.conf:
#  file.managed:
#    - source:
#      - salt://netdata-formula/netdata/files/netdata.conf
#    - user: root
#    - group: root
#    - mode: 644
netdata_bind_all:
  file.replace:
    - name: /etc/netdata/netdata.conf
    - pattern: "bind to = localhost"
    - repl: "bind to = *"
netdata_backend:
  file:
    - append
    - name: /etc/netdata/netdata.conf
    - sources:
      - salt://netdata-formula/netdata/files/netdata.conf
netdata:
  service.running:
    - enable: True
    - reload: True
  watch:
    - file: /etc/netdata/netdata.conf
