#MariaDB packets
mariadb-server:
  pkg.installed

mariadb-client:
  pkg.installed
  
#Create database and user
/tmp/
  file.managed:
    - mode: 600
    - source: salt://setmariadb/
- source: salt://mariadb/createuser.sql 
'cat /tmp/createuser.sql|mariadb -u root':
cmd.run:
  - unless: "echo 'show databases'|sudo mariadb -u root|grep '^products$'"
