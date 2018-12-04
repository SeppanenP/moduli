apache2:
  pkg.installed

libapache2-mod-php:
  pkg.installed

mariadb-server:
  pkg.installed

mariadb-client:
  pkg.installed

Kotisivu
/var/www/html/index.html:
  file.managed:
    - source: salt://lamp/index.html

PHP-aktiiviseksi
/etc/apache2/mods-enabled/php7.2.conf:
  file.managed:
    - source: salt://lamp/php7.2.conf
