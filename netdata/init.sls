{% if salt['grains.get']('netdata') != 'installed' %}

netdata_packages:
  pkg.installed:
    - pkgs:
      - zlib1g-dev 
      - uuid-dev
      - libmnl-dev
      - gcc 
      - make 
      - git 
      - autoconf 
      - autoconf-archive 
      - autogen 
      - automake 
      - pkg-config 
      - curl
      - libuv1-dev
netdata_git:
  git.latest:
    - name: https://github.com/firehol/netdata.git
    
    - target: /tmp/netdata

netdata_install:
  cmd.run:
    - name: /tmp/netdata/netdata-installer.sh --dont-start-it --dont-wait
    - cwd: /tmp/netdata
  grains.present:
    - name: netdata
    - value: installed
/etc/netdata/netdata.conf:
  file.managed:
    - source:
      - salt://netdata-formula/netdata/files/netdata.conf
    - user: root
    - group: root
    - mode: 644

netdata:
  service.running:
    - enable: True

/tmp/netdata:
  file.absent:
    - order: last
{% endif %}

