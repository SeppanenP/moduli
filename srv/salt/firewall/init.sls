ufw:
  pkg.installed

#Set these rules
#22/tcp                     ALLOW       Anywhere                  
#4505                       ALLOW       Anywhere                  
#4506                       ALLOW       Anywhere                  
#80/tcp                     ALLOW       Anywhere                  
#22/tcp (v6)                ALLOW       Anywhere (v6)             
#4505 (v6)                  ALLOW       Anywhere (v6)             
#4506 (v6)                  ALLOW       Anywhere (v6)             
#80/tcp (v6)                ALLOW       Anywhere (v6)             

/etc/ufw/user.rules:
  file.managed:
    - source: salt://firewall/user.rules
    
/etc/ufw/user6.rules:
  file.managed:
    - source: salt://firewall/user6.rules
    
ufw-enable:
  cmd.run:
    - name: 'ufw --force enable'
    - watch:
      - file: /etc/ufw/user.rules
      - file: /etc/ufw/user6.rules
