#MariaDB packets
mariadb-server:
  pkg.installed

mariadb-client:
  pkg.installed
  
#Create database and user
/tmp/mariasettings.sql:
  file.managed:
    - mode: 600
    - source: salt://setmariadb/mariasettings.sql
'cat /tmp/mariasettings.sql|mariadb -u root':
  cmd.run:
    - unless: "echo 'show databases'|sudo mariadb -u root|grep '^products$'"
