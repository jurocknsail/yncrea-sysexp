# Mini Projets : Partie Commune

---

## Organisation

On va utiliser une façon ``agile`` de travailler, insprirée de SCRUM, mais adaptée à nos besoins.

### Groupes

!!! abstract ""
    Vous formerez des groupes de **4**.  
    Tout le monde est DEV avec des *spécialités* :  
    - Chef de projet / SCRUM Master qui gère l’équipe + lien avec le client  
    - Archi Soft : Respo design produit  
    - Commercial : Respo Pitch / Vente  
    - Admin Sys : Respo machine (Rpi si dispo) / RZO / Sécu etc …  

### Dailys

!!! abstract ""
    Ce sera des « **Courlys Meetings** » par **mail** : <julien.berger1421@gmail.com>[ ](mailto:julien.berger1421@gmail.com).

### Iterations

!!! abstract ""
    Chaque 8h : Le groupe doit être capable de fournir un **Incrément Fonctionnel**.

### Note finale

!!! abstract ""
    Livrable (Commun) (75%) + Note de Rôle (25%)



---

## Règles de bases

!!! abstract ""
    - On privilégiera toujours la performance
    - On privilégiera l’économie de ressources matérielles   
    - Si on est bloqué, on trouve une solution de contournement  
    - Si l’on ne parvient pas techniquement au résultat escompté, on négocie avec le client (le prof !)   
    - On se divise les taches efficacement   
    - Tout le monde doit à la fin, connaître toutes les parties du projet

!!! danger ""
    On parle d'incréments fonctionnels : il vaut donc mieux rendre un programme fonctionel et sans bug, mais auquel il manque une feature,  
    plutôt que de rendre toutes les features, mais buggées !!
    
---

## Partie commune

!!! quote ""
    Pour tous les sujets :   
    
  
    - Ajouter un **user « isen »** avec un **groupe associé**, un **home directory**, un **shell** etc …     
    - Créer un répertoire de travail dans le home directory de l’utilisateur « isen »    
    - Le code sera fait dans ce répertoire en tant qu’utilisateur « isen »  
    - Le code sera hebergé sur **github**
    - Le repo github sera **accompagné d'une documention** au format `md`
    - ==**A l'issue du jour 1**, vous êtes engagé sur votre scope avec le client (le prof).==  
      Un document sera écrit et approuvé des deux parties.
    - A vous de "rassurer" le client tout au long du projet grace au daylies
    
    
!!! success "Bonus"
    1) ^^Si vous avez un Raspberry Pi à dispo^^ :  
  
    - Installer Raspbian  
    - Faire toute les mises à jours       
    - Configurer le RPi pour s’y connecter en SSH en **Wifi Direct**    
      (Sans passer par un réseau Wifi tel qu’une box internet ou un tel en AP)  
    - Utiliser le RPI pour hoster votre programme, tel un server en acces WIFI Direct (donc pas sur internet).
    
    2) ^^Documentation^^ :  
    
    - Doc en ligne via [github pages](https://pages.github.com/)
    - Bonus ++ : utiliser mkdocs material pour le theme de la doc, dans ce cas la doc sera mise à jour `on push` en utilisant des github actions.  
    - Vous pouvez vous inspirer du gihtub du cours ...  
    
    3) ^^Mise en place d'un Framework de Tests^^ :  
    
    - Au choix ...  
    
    4) ^^Surprenez moi^^ avec des killer features ! 