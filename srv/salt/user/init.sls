#Add new user newuser
newuser:
  user.present:
    - fullname: newuser
    - shell: /bin/zsh
    - home: /home/newuser
    - groups:
      - adm
      - sudo
    - password: good_password_here
