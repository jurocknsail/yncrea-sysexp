# TP Commandes Linux

Dans ce TP, vous apprendrez à utiliser les commandes de base d'Unix.

---

## Exercice 1 : Variables d’environnements

- Afficher l’ensemble de vos variables d’environnement.
    
    ??? example "Solution"
        ```bash linenums="1"
        env
        ```
- Afficher le contenu de la variable PATH.
    
    ??? example "Solution"
        ```bash linenums="1"
        echo $PATH
        ```
        
- Donner la signification de PATH, PS1, HOME, et TERM
    
    ??? example "Solution"
        **PATH** : Liste des chemins (absolus) des dossiers contenant des binaires (executables).  
        **PS1**  : Aspect du Prompt principal.  
        **HOME** : Chemin du Home Directory de l'utilisateur courant.  
        **TERM** : Type de terminal en cours d'usage pour l'utilisateur courant.
     
---
   
## Exercice 2 : Initiation aux commandes de base d'Unix
    
!!! tip 
    Ne pas oublier que le descriptif des commandes est disponible en utilisant le manuel (commande man).  
    Pour savoir où se trouve un fichier ou commande = whereis, which, apropos
         
### Utilisation des commandes : alias et unalias

- Quels sont les alias présents sur votre machine ?
    
    ??? example "Solution"
        ```bash linenums="1"
        alias
        ```

- Créer un alias lu qui réalise la commande ls -lrt
    
    ??? example "Solution"
        ```bash linenums="1"
        alias lu='ls -lrt'
        ```
            
- Utiliser cet alias
    
    ??? example "Solution"
        ```bash linenums="1"
        lu
        ```
            
- Supprimer cet alias
    
    ??? example "Solution"
        ```bash linenums="1"
        unalias lu
        ```

### Utilisation des commandes : mkdir, rm, cd, cp, mv, touch, chmod, pwd

- Créer, dans votre environnement de travail (`/home/{==username==}`), l’arborescence de dossiers suivante :  
  (Bonus :  en une seule commande !)
  
    ```bash linenums="1"
    .
    `-- SE
        |-- TP1
        |   |-- delivery
        |   |-- dpc
        |   `-- script
        `-- TP2
            |-- bin
            |-- inc
            |-- obj
            `-- src
    ```

    ??? example "Solution"
        ```bash linenums="1"
        mkdir -p SE/{TP1/{dpc,script,delivery},TP2/{bin,obj,src,inc}}
         ```

- Installer la commande `tree` qui permet d'afficher l'arborescence ci-dessus

    ??? example "Solution"
        ```bash linenums="1"
        sudo apt-get install tree
        tree
        ```

- Afficher son répertoire courant
    
    ??? example "Solution"
        ```bash linenums="1"
        pwd
        ```

- Créer le fichier `bonjour.c` sous `SE/TP2/src` contenant les lignes suivantes :  
  (En utilisant un editeur en ligne de commande ou graphique, au choix)
    
      ```c linenums="1"
      // directive du préprocesseur
      #include <stdio.h>
      
      /* prototype des fonctions */
      
      /* programme principal */
      int main() {
      
        printf("Bonjour\n") ;
        /*
         0100123456123
         0100123457123
         0100123458123
         0100123459123
         0100123450123
         0100123451123
         0100123451123
        */
      }
      ```
      
- Déplacer vous sous votre **home directory** et créer le fichier vide ``config.txt``

    ??? example "Solution"
        ```bash linenums="1"
        cd
        touch config.txt
        ```
        
- Déplacer vous par un déplacement **absolu** sous le répertoire ``src`` et compiler le programme  
  ``bonjour.c`` en un programme exécutable **``bonjour``**. Le résultat de la compilation est déplacé   
  sous ``bin``.

    ??? example "Solution"
        ```bash linenums="1"
        cd /home/my_user/SE/TP2/src
        gcc bonjour.c -o ../bin/bonjour
        ```
        
- Afficher les types des fichiers ``bonjour`` et ``bonjour.c``

    ??? example "Solution"
        ```bash linenums="1"
        file bonjour.c
        file ../bin/bonjour
        ```
        
- Déplacez vous par un déplacement relatif sous ``TP2/bin``

    ??? example "Solution"
        ```bash linenums="1"
        cd ../bin
        ```
        
- Modifier les droits du fichier ``bonjour`` afin qu’il soit :  
    - en lecture, écriture, exécution pour le owner
    - en lecture, exécution pour le groupe
    - et non accessible pour les autres.

    ??? example "Solution"
        ```bash linenums="1"
        chmod 750 bonjour
        ```
        
- Déplacez vous sous votre home directory et modifiez de façon récursive l’ensemble des droits (directories + fichiers) de TP2 selon les conditions de la question précédente.
 
    ??? example "Solution"
         ```bash linenums="1"
         cd
         chmod -R 750 SE/TP2/
         ```
         
- Copier le fichier bonjour.c en salut.c en local.
    
    !!! tip 
        Pour faire une copie **locale** il faut etre dans le repertoire concerné, et copier au même endroit.
        
    ??? example "Solution"
         ```bash linenums="1"
         cd SE/TP2/src/
         cp bonjour.c salut.c
         ```
         
- Copier le répertoire TP2 en TP3 avec l’ensemble de ses fichiers

    ??? example "Solution"
         ```bash linenums="1"
         cd ../../
         cp -R TP2 TP3
         ```

- Déplacer le fichier salut.c de TP3 dans SE/TP2/src en l’appelant salut1.c

    ??? example "Solution"
         ```bash linenums="1"
         mv TP3/src/salut.c TP2/src/salut1.c
         ```
         
- Effacer le fichier bonjour.c de TP3

    ??? example "Solution"
         ```bash linenums="1"
         rm TP3/src/bonjour.c
         ```
         
- Effacer TP3

    ??? example "Solution"
         ```bash linenums="1"
         rm -R TP3/
         ```
   
### Utilisation des commandes : chmod, chown, chgrp, ls, ln

- Changer le owner du fichier `TP2/src/salut.c` par n'importe quel autre utilisateur présent sur votre machine, monitorer le résultat

    !!! tip 
        Pour connaitre les users disponible, allez voir le contenu du fichier ``/etc/passwd`` avec la command ``cat``  
        Filtrer les users qui possedent un home directory dans ``/home``  
        ``cat /etc/passwd | grep home ``

    ??? example "Solution"
         ```bash linenums="1"
         chown new_owner TP2/src/salut.c
         ls -la
         ```
        
- Changer le groupe de ce fichier par un groupe connu sur la machine

    !!! tip 
        Pour connaitre les groupes disponible, allez voir le contenu du fichier ``/etc/group`` avec la command ``cat``  
        ``cat /etc/group``

    ??? example "Solution"
         ```bash linenums="1"
         chgrp new_group TP2/src/salut.c
         ls -la
         ```
         
- Changer en une seule commande le owner et goupe de TP2 et des fichiers qu’il contient pour vous les redonner

    !!! tip 
        Utilisez la commande `id` pour connaitre votre user:groupe
        
    ??? example "Solution"
         ```bash linenums="1"
         chown -R mon_user:mon_groupe TP3/
         ```
         
- Se positionner sur son home directory et créer un lien symbolique vers le fichier salut.c de TP2

    ??? example "Solution"
         ```bash linenums="1"
         cd
         ln -s SE/TP2/src/salut.c monLien
         ls -la
         ```
         
- Editer ce lien. Expliquer la différence entre un lien permanent et un lien symbolique.

    ??? example "Solution"
         ```bash linenums="1"
         cd
         cat monLien
         ```
         
    !!! note
        Un lien symbolique pointe vers le nom d'un fichier existant.
        Un lieu permanent (ou physique) pointe vers l'esapace mémoire où se siture le fichier.
        

### Monitoring disques

- Quel est l’espace disponible sur votre disque ?

    ??? example "Solution"
         ```bash linenums="1"
         df -h
         ```
         
- Quelles sont les partitions disques présentent sur votre système ?    

    ??? example "Solution"
         ```bash linenums="1"
         sudo fdisk -l
         ```
         
### Utilisation de la commande export :
- Modifier le contenu de la variable d’environnement PATH afin d’y ajouter le répertoire local.
- Vérifier que, situé sous SE/TP2/bin, vous pouvez lancer ``bonjour`` de la façon suivante :
    bonjour ↵    
    ( Attention de ne pas effacer PATH)
- Modifier votre profil utilisateur afin de modifier PATH comme précédemment, de manière permanente.

### Script :
- Déplacez vous sous SE/TP1/script et créer, en 1 seule commande, un fichier essai.bash contenant ``#!/bin/bash``
- Ajouter à la fin de essai.bash la ligne « ls –lrt » (en une seule commande)
- Exécutez essai.bash

### Utilisation de grep, ps, netstat,wc :
- Rechercher l’occurrence « include » dans le fichier bonjour.c
- Afficher l’ensemble des processus en cours
- Afficher l’ensemble des sockets en état ‘ESTABLISHED’ sur votre machine et comptez les.

### Utilisation de la commande find :
- Rechercher à partir de votre home directory l’ensemble des fichiers .c contenus dans ce répertoire et ses sous répertoires
- Rechercher à partir de votre home directory l’ensemble des occurrences de « printf » dans l’ensemble des fichiers .c contenus dans ce répertoire et ses sous répertoires

### Utilisation de la commande xargs et find:
- Créer une sauvegarde de l’ensemble des fichiers c se trouvant sous ``./SE/TP2/src`` en le copiant en ``nom_du_fichier.c_backup``  
    Ex : bonjour.c est copié en bonjour.c_backup
- Rechercher à partir de votre home directory l’ensemble des fichiers d’extension .c et .c_backup en une seule commande.

### Machine/user/système/terminal
- Afficher qui est loggé sur votre machine ?
- Afficher quel est le nom de votre machine ?
- Afficher quel est le nom de votre système ?
- Afficher quel votre numéro utilisateur et groupe ?

### Les Process : utilisation des commandes ps, top, jobs, CTRL^Z, fg, bg, kill
- Monitorer de manière dynamique l’ensemble des process en cours (rafraichissement de la commande 2 secondes)
- Lancer un process en background, par example ``firefox``
- Monitorer le de 2 façons différentes
- Tuer le violemment
- Lancer un process, l’interrompre et le mettre en exécution en background
- Monitorer le
- Basculer ce process en foreground
- Stopper le par un signal d’interruption