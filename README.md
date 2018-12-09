# Palvelinten hallinta ICT4TN022, Tehtävä 6 ja oma moduli LAMP

Tämä moduli liittyy Haaga-Helian kurssiin Palvelinten hallinta ICT4TN022.Yhdistin tehtävät viimeiseltä viikolta ja oman modulin tekemisen. Viimeisen viikon tehtävänä oli asentaa LAMP Saltilla ja sama oli oman lopputyöni pohjana. Pääasiallisena lähteenä käytin kurssin opettajan sivustoa:

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
     
## LAMP ja MariaDB

Asennetaan LAMP-kilkeet, aktivoi PHP:n, tekee uuden oletussivun, käyttäjän oman sivun ja tekee MariaDB:lle products-tietokannan, käyttäjän ja sille oikeudet tietokantaan. Tämän lisäksi estetään root-kirjautuminen.

MariaDB on uusi tuttavuus minulle ja ohjeita asennukseen ja käyttöön löysin Tero Karvisen sivuilta:
http://terokarvinen.com/2018/install-mariadb-on-ubuntu-18-04-database-management-system-the-new-mysql
    
## Palomuuri

Tein asennuksen ensin manuaalisesti ja sen jälkeen katsoin mitä tiedostoja on muutettu komentojen yhteydessä /etc -kansiossa. Kansion löytämisessä auttoi sivusto https://www.comentum.com/unix-linux-ip-firewall.html. Komento löytyy kurssin opettajan sivulta http://terokarvinen.com/2018/apache-user-homepages-automatically-salt-package-file-service-example
 
     sudo find -printf '%T+ M %p\n%A+ A %p\n%C+ C %p\n'|sort
     
 Viimeisimmät muutokset oli tehty tiedostoihin:
 
    2018-12-08+18:54:28.9220822350 A ./user.rules
    2018-12-08+18:54:28.9220822350 A ./user6.rules
    
Kopioin nämä moduliin firewall-kansioon ja tein sinne myös init.sls -tiedoston. Palomuurin aktivointiin löysin apua sivustolta https://github.com/joonaleppalahti/CCM/blob/master/salt/srv/salt/firewall.sls.
    
## Modulin testaus

Tein DigitalOcean palveluun koneen johon tein uuden sudo-käyttäjän, asensin paketit git ja salt-minion. Koneen ip on 68.183.223.125. Tein mutaman testin ennen kuin ajoin modulin paikallisesti.

    seppanen@SlaveXub:~$ sudo ufw status
    Status: inactive
    
Kokeilin myös oman koneeni selaimella saanko ip-osoitteella näkyviin modulin oletussivua, mutta sain näkyviin vain tekstin

    Could Not Connect
    Description: Could not connect to the requested server host. 
    
Tämän jälkeen kopioin git-varaston koneelle ja ajoin modulin paikallisesti:

    sudo salt-call --local state.highstate --file-root srv/salt
    
### Testauksen tulokset

    Summary for local
    -------------
    Succeeded: 19 (changed=17)
    Failed:     0
    -------------
    Total states run:     19
    Total run time:   80.083 s
    
 Apachen uudelleenkäynnistys:
 
           ID: apache2service
    Function: service.running
        Name: apache2
      Result: True
     Comment: Service restarted
 
 sshd uudelleenkäynnistys:
 
              ID: sshd
    Function: service.running
      Result: True
     Comment: Service restarted
     Started: 20:15:10.228059
    Duration: 61.482 ms
     Changes:
              ----------
              sshd:
                  True

Palomuurin aktivointi:

              ID: ufw-enable
    Function: cmd.run
        Name: ufw --force enable
      Result: True
     Comment: Command "ufw --force enable" run
     Started: 20:15:49.896523
    Duration: 423.155 ms


Palomuurin asetuksen komentorivillä:

    seppanen@SlaveXub:~$ sudo ufw status
    Status: active
    To                         Action      From
    --                         ------      ----
    22/tcp                     ALLOW       Anywhere
    4505                       ALLOW       Anywhere
    4506                       ALLOW       Anywhere
    80/tcp                     ALLOW       Anywhere
    22/tcp (v6)                ALLOW       Anywhere (v6)
    4505 (v6)                  ALLOW       Anywhere (v6)
    4506 (v6)                  ALLOW       Anywhere (v6)
    80/tcp (v6)                ALLOW       Anywhere (v6)

Kun laittoi palvelimen ip-osoitteen (68.183.223.125) oman koneen selaimelle avautui oletussivu. Kun perään laittoi vielä käyttäjän 68.183.223.125/~seppanen, niin avautui käyttäjän oma sivu ja PHP toimi sivulla.

Kirjautuminen root-tunnuksella ei onnistunut

    root@68.183.223.125's password:
    Access denied
    
MariaDB avautui käyttäjälle test ja hän näki luodun tietokannan sisällön ja pystyi tekemään muutoksia kantaan

    MariaDB [products]> select * from products;
    +----+-------------+-------+
    | id | name        | price |
    +----+-------------+-------+
    |  1 | Product 1   |  99.9 |
    |  2 | Product 2   |  55.5 |
    |  3 | New Product | 15.45 |
    +----+-------------+-------+
    3 rows in set (0.00 sec)




## Lähteet

http://terokarvinen.com/

https://www.richterich.me/index.php/salt-states/ufw/ 

https://www.comentum.com/unix-linux-ip-firewall.html

https://github.com/joonaleppalahti/CCM/blob/master/salt/srv/salt/firewall.sls

