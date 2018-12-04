# Palvelinten hallinta ICT4TN022, Oma moduli LAMP

Tämä moduli liittyy Haaga-Helian kurssiin Palvelinten hallinta ICT4TN022. Tehtävänä on tehdä oma moduli valitsemastaan aiheesta. Valitsin aiheekseni LAMP-asennuksen.


Kopidaan moduli koneelle ja ajetaan komento

    sudo salt-call --local state.highstate --file-root srv/salt
