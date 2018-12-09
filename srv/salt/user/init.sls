#just a test. don't work
newuser:
  user.present:
    - fullname: newuser
    - shell: /bin/bash
    - home: /home/newuser
    - uid: 4000
    - gid: 4000
    - groups:
      - adm
    - password: goodpassword
# - key.pub: True
