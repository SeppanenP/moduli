apache2:
  pkg.installed

libapache2-mod-php:
  pkg.installed

#Public HTML
/var/www/html/index.html:
  file.managed:
    - source: salt://lamp/index.html

#enable PHP
/etc/apache2/mods-available/php7.2.conf:
  file.managed:
    - source: salt://lamp/php7.2.conf
    
#HTML for user newuser
/home/newuser/public_html/index.php:
  file.managed:
    - source: salt://lamp/index.php
    - makedirs: True

#sudo a2enmod userdir
/etc/apache2/mods-enabled/userdir.conf:
  file.managed:
    - source: salt://lamp/userdir.conf
    
/etc/apache2/mods-enabled/userdir.load:
  file.managed:
    - source: salt://lamp/userdir.load
    
apache2service:
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/mods-enabled/userdir.conf
      - file: /etc/apache2/mods-enabled/userdir.load
      - file: /etc/apache2/mods-available/php7.2.conf
      
#disable root login
openssh-server:
  pkg.installed
  
/etc/ssh/sshd_config:
  file.managed:
    - source: salt://lamp/sshd_config
    
sshd:
  service.running:
    - watch:
      - file: /etc/ssh/sshd_config
