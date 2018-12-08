ufw:
  pkg.installed

#Set ufw rules
/etc/ufw/user.rules
  file.managed:
    - source: salt://firewall/user.rules
    
/etc/ufw/user6.rules
  file.managed:
    - source: salt://firewall/user6.rules

#Restart ufw
ufwservice:
  service.running:
    - name: ufw
    - watch:
      - file: /etc/ufw/user.rules
      - file: /etc/ufw/user6.rules
