# TP Commandes Linux


## Objectifs
Le second objectif du cours est de maitriser **les bases du Shell Unix**, via un TP.

---

## Exercice 1 : Variables d’environnements

- Afficher l’ensemble de vos variables d’environnement.
- Afficher le contenu de la variable PATH.      
- Donner la signification de PATH, PS1, HOME, et TERM
     
---
   
## Exercice 2 : Initiation aux commandes de base d'Unix
    
!!! tip 
    Ne pas oublier que le descriptif des commandes est disponible en utilisant le manuel (commande man).  
    Pour savoir où se trouve un fichier ou commande = whereis, which, apropos
         
### Utilisation des commandes : alias et unalias

- Quels sont les alias présents sur votre machine ?
- Créer un alias lu qui réalise la commande ls -lrt
- Utiliser cet alias
- Supprimer cet alias

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

- Installer la commande `tree` qui permet d'afficher l'arborescence ci-dessus

    !!! tip
        Pour afficher les droits, users et groups avec tree :   
        ``tree -ugp``
    
- Afficher son répertoire courant
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
- Déplacer vous par un déplacement **absolu** sous le répertoire ``src`` et compiler le programme  
  ``bonjour.c`` en un programme exécutable **``bonjour``**. Le résultat de la compilation est déplacé   
  sous ``bin``.
 
- Afficher les types des fichiers ``bonjour`` et ``bonjour.c``

- Déplacez vous par un déplacement relatif sous ``TP2/bin``

- Modifier les droits du fichier ``bonjour`` afin qu’il soit :  
    - en lecture, écriture, exécution pour le owner
    - en lecture, exécution pour le groupe
    - et non accessible pour les autres.

- Déplacez vous sous votre home directory et modifiez de façon récursive l’ensemble des droits (directories + fichiers) de TP2 selon les conditions de la question précédente.
 
    !!! tip 
        Vous pouvez vérifier avec la commande ```tree -p```
         
- Copier le fichier bonjour.c en salut.c en local.
    
    !!! tip 
        Pour faire une copie **locale** il faut etre dans le repertoire concerné, et copier au même endroit.

         
- Copier le répertoire TP2 en TP3 avec l’ensemble de ses fichiers
- Déplacer le fichier salut.c de TP3 dans SE/TP2/src en l’appelant salut1.c
- Effacer le fichier bonjour.c de TP3     
- Effacer TP3
   
### Utilisation des commandes : chmod, chown, chgrp, ls, ln

- Changer le owner du fichier `TP2/src/salut.c` par n'importe quel autre utilisateur présent sur votre machine, monitorer le résultat

    !!! tip 
        Pour connaitre les users disponible, allez voir le contenu du fichier ``/etc/passwd`` avec la command ``cat``  
        Filtrer les users qui possedent un home directory dans ``/home``  
        ``cat /etc/passwd | grep home ``

        
- Changer le groupe de ce fichier par un groupe connu sur la machine

    !!! tip 
        Pour connaitre les groupes disponible, allez voir le contenu du fichier ``/etc/group`` avec la command ``cat``  
        ``cat /etc/group``
         
- Changer en une seule commande le owner et goupe de TP2 et des fichiers qu’il contient pour vous les redonner

    !!! tip 
        Utilisez la commande `id` pour connaitre votre user:groupe

- Se positionner sur son home directory et créer un lien symbolique vers le fichier salut.c de TP2

- Editer ce lien. Expliquer la différence entre un lien permanent et un lien symbolique.        

### Monitoring disques

- Quel est l’espace disponible sur votre disque ?
- Quelles sont les partitions disques présentent sur votre système ?    
         
### Utilisation de la commande export

- Modifier le contenu de la variable d’environnement PATH afin d’y ajouter le chemin **absolu** vers le répertoire `TP2/bin`.
    
    !!! warning
        Attention à ne pas écraser totalement la variable PATH !
         
- Vérifier que depuis n'importe quel folder, vous pouvez lancer ``bonjour`` de la façon suivante : `bonjour ↵`   
- Vérifiez que ```bonjour``` execute bien votre binaire avec `which bonjour`
- Modifier votre profil utilisateur afin de modifier PATH comme précédemment, de manière permanente.
         
### Script

- Déplacez vous sous SE/TP1/script et créer, en 1 seule commande, un fichier essai.bash contenant ``#!/bin/bash``
- Ajouter à la fin de essai.bash la ligne « ls –lrt » (en une seule commande)
- Exécutez essai.bash

    !!! warning
        Pensez à vous donner les droits d'execution avant ...  
        ``chmod u+x essai.bash``


### Utilisation de grep, ps, netstat,wc

- Rechercher l’occurrence « include » dans le fichier `bonjour.c`
- Afficher l’ensemble des processus en cours
- Afficher l’ensemble des sockets en état ‘ESTABLISHED’ sur votre machine et comptez les.

### Utilisation de la commande find 

- Rechercher à partir de votre repertoire ``SE`` l’ensemble des fichiers .c contenus dans ce répertoire et ses sous répertoires    
- Rechercher à partir de votre repertoire ``SE`` l’ensemble des occurrences de « printf » dans l’ensemble des fichiers .c contenus dans ce répertoire et ses sous répertoires
         
### Utilisation de la commande xargs

- Créer une sauvegarde de l’ensemble des fichiers c se trouvant sous ``SE/TP2/src`` en le copiant en ``nom_du_fichier.c_backup``  
    
    !!! tip
        bonjour.c est copié en bonjour.c_backup
        
### Machine/user/système/terminal

- Afficher qui est loggé sur votre machine ?
- Afficher quel est le nom de votre machine ?
- Afficher quel est le nom de votre système ?
- Afficher quel votre numéro utilisateur et groupe ?

### Les Process : utilisation des commandes ps, top, jobs, CTRL^Z, fg, bg, kill

- Monitorer de manière dynamique l’ensemble des process en cours

- Dans un autre terminal, lancer un process long en background, par example ``firefox``, ou ajouter une boucle infinie au programme bonjour et utiliser ``bonjour`.
    
    !!! tip "bonjour.c"
         ```c linenums="1"
         // directive du préprocesseur
         #include <stdio.h>
         #include <unistd.h>
                  
         /* programme principal */
         int main() {
           while(1){
            printf("Bonjour\n") ;
            sleep (2);
           }
         }
         ```
         
- Monitorer le de façon statique

- Tuer le violemment
         
- Lancer un process, l’interrompre et le mettre en exécution en background
         
- Monitorer le

- Basculer ce process en foreground
         
- Stopper le par un signal d’interruption


## Exercice 3 : Executer un script

- Téléchargez ce script : [install_env_student.sh](assets/files/install_env_student.sh).
- Verifier que vous possedez les droits *d'execution* sur le script. Sinon utilisez `chmod` !
- Executez le script
- Verifier qu'aucune erreur ne s'est produite.

!!! success ""
    Votre environnement est pret pour faire du C dans la suite du cours :)