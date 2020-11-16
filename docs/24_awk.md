
# AWK

---

## Généralités

!!! abstract ""
    Awk est un outil pour la manipulation de fichiers (au format texte).  
    Il a été conçu en 1977 par Alfred **A**ho, Peter **W**einberger et Brian **K**ernighan (Laboratoires Bell) et intégré dans Unix V7 en 1979.  
    
    Awk est aujourd'hui dans la norme POSIX (donc intégré dans
    toutes les distributions Unix, Linux, etc.)

    Cette commande permet d'appliquer un certain nombre d'actions sur un fichier.   
    Elle est particulièrement adaptée au fichiers qui sont sous forme de **lignes/colonnes**, comme le CSV par exemple.    
    
    La syntaxe est inspirée du C.

---

## Syntaxe

````
awk [-Fs] [-v variable] [-f fichier de commandes] '**programme awk**' fichier 
-F : Spécifie les séparateurs de champs 
-v : Définie une variable utilisée à l'intérieur du programme. 
-f : les commandes sont lu à partir d'un fichier. 
````

---

## Fonctionnement

!!! abstract ""
    Le programme awk est une suite d'action de la forme :   
    
    ````
    motif { action }
    ````

!!! tip "Vacobulaire"
    Un ==enregistrement== est : une chaîne de caractères séparée par un retour chariot, **en général une ligne**.   
    Un ==champs== est : une chaîne de caractères séparée par un espace (ou par le caractère spécifié par l'option -F), **en général un mot**.   
    Le ==motif== : **condition** qui permet de déterminer sur quels enregistrements est appliquée **l'action**. 

### Variables prédéfinies

!!! quote ""
    Liste non exhaustive ...
    
| Variable  | Signification  | Valeur par défaut|
| --------- |--------------- | ---------------- |
| `ARGC` | Nombre d'arguments de la ligne de commande | - |
| `ARGV` | Tableau des arguments de la ligne de commande | - |
| `FNR` | Nombre d'enregistrements du fichier | - |
| `NF` | Nombre de champs dans l'enregistrement courant | - |
| `NR` | Nombre d'enregistrement déjà lus | - |
| `FS` | Séparateur de champs d'entrée | " " |
| `RS` | Séparateur d'enregistrement en entrée | "\n" |
| `OFS` | Séparateur de champs de sortie | " " |
| `ORS` | Séparateur d'enregistrement de sortie | "\n" |
| `...` | ... | ... |


### Le motif

!!! abstract ""
    Si le motif existe dans l'enregistrement, l'action sera appliquée à la ligne.  
    Le motif peut être : 
    
    - une expression régulière : 
        - ```/expression regulière/``` 
        -  ```$0 ~ /expression regulière/ ```
        - ``expression ~ /expression regulière/ ``
        -  ``expression !~ /expression regulière/ ``
    - une expression ``BEGIN`` ou ``END`` 
    - une expression de comparaison: ```<, <=, == , !=, >=, > ```
    - une combinaison des trois (à l'aide des opérateurs booléens ```||``` ou, ```&&``` et, ```!``` négation) 

    On accède à chaque champs de l'enregistrement courant par la variable $1, $2, ... $NF.  
    
    
!!! tip ""    
    **\$0** correspond à l'enregistrement complet.   
    La variable **NF** contient le nombre de champs de l'enregistrement courant, la variable **\$NF** correspond donc au ^^dernier champs^^.

### L'action

!!! abstract ""
    Une action transforme ou manipule des données, par défaut on ``print`` la ligne.   
    
    ^^Type des actions^^ :  
    - **fonctions prédéfinies**, numérique ou chaîne de caractères   
    - contrôle de flots   
    - affectation   
    - impression   
    
    
    ^^Actions possibles^^ : 
     
     - Les opérations arithmétiques usuelles : 
       ``+`` ``-`` ``*`` ``/`` ``%`` (reste division entière) et ``^`` (puissance).  
       Tous les calculs sont effectués en virgule flottante.  
       Vous pouvez aussi utiliser les opérateurs ``+=``, ``-=``, ``*=``, ``/=``, ``%=`` etc ...  
           
     - Les affectations : 
       ``var = expression``   
       
     - Références aux variables de champs :   
       Les champs de la ligne courant sont : \$1, \$2, ..., \$NF. La ligne entière est \$0.  
       Ces variables ont les mêmes propriétés que Les autres variables.   
       Elles peuvent être réaffectées. 
       Quand \$0 est modifiées, les variables \$1, \$2 ... sont aussi modifiées ainsi que NF.   
       Inversement si une des variables \$i est modifiées, \$0 est mise à jour.  
       Les champs peuvent être spécifiés par des expressions, comme $(NF-1) pour l'avant dernier champs.  
       
     - Impression :  
       `print $i` par exemple ...

     - If/Else, Boucles
       ````
       if (condition) 
       { ... }
       else
       { ... }

       while (condition) 
       { ... }
       
       for (init ;cond ;incr)
       { ... }
       ````
       
     - Commentaire : `#`  
       
     - ``next``: passe à l'enregistrement suivant. On reprend le script awk à son début.  
     
     - ``exit``: ignore le reste de l'entrée et execute les actions définie par END  

!!! quote ""
    Liste non exhaustive de fonction sur chaines de charactères :    
    Dans le tableau suivant ``s`` et ``t`` représentent des chaînes de caractères, ``r`` une expression régulière, ``i`` et ``n`` des entiers.  
    
| Fonction  | Signification  | 
| --------- |--------------- | 
| `length(s)` | Retourne la longueur de la chaine `s` |
| `gsub(r,s,t)` | Dans la chaine `t`, remplace toutes les occurences de `r` par `s` |
| `substr(s,i,n)` | Retroune la sous chaîne de `s` commençant en `i` et de taille `n`|
| `...` | ... |


!!! warning ""
    Concaténation de chaînes de caractères dans les actions :  
    Il n'y a pas d'opérateur de concaténation, il faut simplement lister les chaînes à concaténer.  
    
    ^^Exemples^^ :  
    ``awk '{ print NR " : " $0 }' fichier`` 
     
 
---

## Exemples 

| Script  | Resultat  | 
| --------- |--------------- | 
| `awk -F ":" '{ $2 = "" ; print $0 }' /etc/passwd` | Imprime chaqe ligne du fichier `/etc/passwd` après avoir effacé le 2nd champ  |
| `awk ' END { print NR }' fichier` | Imprime le nombre total de lignes du fichier |
| `awk '{ print $NF }' fichier` | Imprime le dernier champ de chaque ligne|
| `who | awk '{ print $1,$5 }'` | Imprime le login et le temps de connexion |
| `awk ' length($0) > 75 { print }' fichier` | Imprime les lignes de plus de 75 caractères ( `print` équivaut à `print $0` |

---

## Exercices

````bash
awk 'BEGIN { print "Verification des UID et GID dans le fichier /etc/passwd"; FS=":"}      
     $3 !~ /^[0-9][0-9]*$/ {print "UID  erreur ligne "NR" :\n"$0 }
     $4 !~ /^[0-9][0-9]*$/ {print "GID  erreur ligne "NR" :\n"$0 }
     END   { print "Fin" }' /etc/passwd 
````

??? example "Solution"
    ````
    Vérification des UID et GID dans le fichier /etc/passwd
    UID erreur ligne 14 : 
    clown:*:aaa:b:utilisateur en erreur:/home/clown:/bin:sh
    GID erreur ligne 14 : 
    clown:*:aaa:b:utilisateur en erreur:/home/clown:/bin/sh
    Fin 
    ````    
    
````bash
awk 'BEGIN { print "Verification du fichier /etc/passwd pour ..."; print "- les utilisateurs avec UID = 0 " ;  print "- les utilisateurs avec UID >= 60000" ; FS=":"}
     $3 == 0 { print "UID 0 ligne "NR" :\n"$0 }      
     $3 >= 60000  { print "UID >= 60000 ligne "NR" :\n"$0 }      
     END   { print "Fin" }' /etc/passwd       
````

??? example "Solution"
    ````
    Verification du fichier /etc/passwd pour ...
    - les utilisateurs avec UID = 0 
    - les utilisateurs avec UID >= 60000UID 0 ligne 5 : 
    root:*:0:b:administrateur:/:/bin/sh
    UID >= 60000 ligne 14 : 
    clown:*:61000:b:utilisateur en erreur:/home/clown:/bin/sh
    Fin 
    ````
    
````bash
awk 'BEGIN { print "Verification du fichier /etc/group"; print "le groupe 20 est t-il bien nommé users ? " ; FS=":"}      
     $1 == "users" && $3 ==20 { print "groupe "$1" a le GID "$3" !" }      
     END   { print "Fin" }' /etc/group 
````

??? example "Solution"
    ````
    Verification du fichier /etc/group
    le groupe 20 s'appelle t-il bien users ? 
    groupe users a le GID 20 ! 
    Fin 
    ````
    
````bash
awk 'NR == 5 , NR == 10 {print NR" : " $0 }' fichier 
````

??? example "Solution"
    ````
    Imprime de la ligne 5 à la ligne 10 , chaque ligne précédée par son numéro
    ````
    
    
````bash
awk 'BEGIN { FS=":" ; OFS=":"}      
	 $NF != "/bin/ksh" { print $0 }      
	 $7 == "/bin/ksh" && NF == 7  { $7 = "/bin/posix/sh" ; print $0 } '	/etc/passwd > /etc/passwdnew 
````

??? example "Solution"
    ````
    On crée un nouveau fichier de mot de passe /etc/passwd.new en remplaçant le shell /bin/ksh par /bin/posix/sh 
    ````                  