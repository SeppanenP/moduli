# Palvelinten hallinta ICT4TN022, Tehtävä 6 ja oma moduli LAMP

Tämä moduli liittyy Haaga-Helian kurssiin Palvelinten hallinta ICT4TN022.Yhdistin tehtävät viimeiseltä viikolta ja oman modulin tekeminsen. Viimeisen viikon tehtävänä oli asentaa LAMP Saltilla ja sama oli oman lopputyöni pohjana. Pääasiallisena lähteenä käytin kurssin opettajan sivustoa:

http://terokarvinen.com/


## Modulin tekemiseen ja testaamiseen käytetyt työkalut

Käytin tehtävän tekeminseen Fujitsun kannettavaa tietokonetta Lifebook xxxx ja siinä livetikkua Ubuntu 18.04. Tämän lisäksi asensin koneelle virtuaalikoneita testaamiseen, eli asensin koneelle Vagrantin ja Virtualboxin. Käytin versionhallinnassa GitHubia. Tarkemmin koneiden käytöstä löytyy ohjeita kurssille tekemistäni aikaisemmista kotitehtävistä:

https://pseppanen296518693.wordpress.com/

Livetikkukoneen asennetut ohjelmat:

    sudo apt-get -y install git vagrant virtualbox salt-minion

ja Vagrantin avulla asennetuissa testikoneissa:

    sudo apt-get install -y git salt-minion
    
    


Kopidaan moduli koneelle ja ajetaan komento

    sudo salt-call --local state.highstate --file-root srv/salt

