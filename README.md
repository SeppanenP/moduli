# Palvelinten hallinta ICT4TN022, Tehtävä 6 ja oma moduli LAMP

Tämä moduli liittyy Haaga-Helian kurssiin Palvelinten hallinta ICT4TN022.Yhdistin tehtävät viimeiseltä viikolta ja oman modulin tekeminsen. Viimeisen viikon tehtävänä oli asentaa LAMP Saltilla ja sama oli oman lopputyöni pohjana. Pääasiallisena lähteenä käytin kurssin opettajan sivustoa:

http://terokarvinen.com/


## Modulin tekemiseen ja testaamiseen käytetyt työkalut

Käytin tehtävän tekeminseen Fujitsun kannettavaa tietokonetta Lifebook xxxx ja siinä livetikkua Ubuntu 18.04. Tämän lisäksi asensin koneelle virtuaalikoneita testaamiseen, eli asensin livetikkukoneelle Vagrantin ja Virtualboxin. Käytin versionhallinnassa GitHubia. Tarkemmin eri vaiheista (mm. vagrant ja virtuaalikoneen tekeminen) löytyy ohjeita samalle kurssille tekemistäni aikaisemmista kotitehtävistä:

https://pseppanen296518693.wordpress.com/

Livetikkukoneen asennetut ohjelmat:

    sudo apt-get -y install git vagrant virtualbox salt-minion

ja Vagrantin avulla asennetuissa testikoneissa:

    sudo apt-get install -y git salt-minion
    
Aina kun aloitin modulin teon kopioin Githubin viimeisimmän varaston koneelle

     git clone https://github.com/SeppanenP/moduli.git
     
    
    
    
## Firewall
Tein asennuksen ensin manuaalisesti ja sen jälkeen katsoin mitä tiedostoja on muutettu komentojen yhteydessä /etc -kaniossa. Komento löytyy kurssin opettajan sivulta http://terokarvinen.com/2018/apache-user-homepages-automatically-salt-package-file-service-example
 
     sudo find -printf '%T+ M %p\n%A+ A %p\n%C+ C %p\n'|sort
     
 Viimeisimmät muutokset oli tehty tiedostoihin:
 
    2018-12-08+18:54:28.9220822350 A ./user.rules
    2018-12-08+18:54:28.9220822350 A ./user6.rules
    
Kopioin nämä moduliin firewall-kansioon ja tein sinne myös init.sls -tiedoston. Palomuurin aktivointiin löysin apua sivustolta https://www.richterich.me/index.php/salt-states/ufw/ .

 

     

## Modulin käyttö

Kopidaan moduli koneelle, mennään kansioon /moduli ja ajetaan komento

    sudo salt-call --local state.highstate --file-root srv/salt
