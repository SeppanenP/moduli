newuser:
  user.absent:
    - fullname: newuser
    - shell: /bin/zsh
    - home: /home/newuser
    - uid: 4000
    - gid: 4000
    - groups:
      - adm
      - testi
    - password: goodpassword
    - enforce_password: True
# - key.pub: True
