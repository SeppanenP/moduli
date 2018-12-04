apache2:
  pkg.installed

libapache2-mod-php:
  pkg.installed

mariadb-server:
  pkg.installed

mariadb-client:
  pkg.installed

#Public HTML
/var/www/html/index.html:
  file.managed:
    - source: salt://lamp/index.html

#enable PHP
/etc/apache2/mods-available/php7.2.conf:
  file.managed:
    - source: salt://lamp/php7.2.conf
    
#User WWW
/Home/public_html/index.php
  file.managed:
    - source: salt://lamp/index.php
    
# Restart Apache-server
#apache2service:
#  service.running:
#    - name: apache2
#    - watch:
#      -file: /etc/apache2/mods-available/php7.2.conf
