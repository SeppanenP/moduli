#Add new user newuser
#Just a test. Not in top.sls
newuser:
  user.present:
    - fullname: newuser
    - shell: /bin/zsh
    - home: /home/newuser
    - groups:
      - adm
      - sudo
    - password: good_password_here
