# TP Regexp

Dans ce TP, vous apprendrez à utiliser les outils d'expression régulières.

---

## Travail sur les fichiers : sed, awk, diff, cut, sort

Sur le fichier C utilisé au TP précédent : 

- Transformer les commentaires // en /* */ – Affichage stdout

    ```bash linenums="1"
    sed -e 's://\(.*\):/*\1*/:g' bonjour.c
    ```
         
- Transformer les commentaires /* */ en // – Affichage dans un fichier bonjour.cpp

    ```bash linenums="1"
    sed -e 's:/\*\(.*\)\*/:// \1:g' bonjour.c > bonjour.cpp
    ``` 
        
- Comparer les fichiers bonjour.cpp et bonjour.c 

    ```bash linenums="1"
    diff bonjour.c bonjour.cpp
    ```
        
- Sous SE/TP1/script, créer le fichier titi.txt contenant les lignes suivantes :

    ```bash linenums="1"
    Alain DERUE
    Clothilde DERUE
    Adresse
    7 av du President Carter
    13000 Marseille cedex 01
    
    TP_OA :MSISDN :KI :IMSI :TP_UD
    TP_SCTS :TP_DA :TAC :IMEI: :TP_UD
  
    0100123456123
    0100123457123
    0100123458123
    0100123459123
    0100123460123
    0100123461123
    0100123462123
    0100123463123
    ```
         
- Remplacer le nom de famille DERUE par Christophe – Affichage stdout

     ```bash linenums="1"
     sed 's/DERUE/Christophe/g' titi.txt
     ```  
  
- Remplacer les lignes préfixées par 0100 et suffixée par 123, par le contenu situé entre ces deux occurrences – Affichage stdout.  
    Exemple :  
        0100123456123 devient 123456
 
     ```bash linenums="1"
     sed -e 's:0100\(.*\)123:\1:g' titi.txt
     ```   

- Ne garder que les chiffres du fichier – Affichage stdout

     ```bash linenums="1"
     sed -e 's/[a-zA-Z:_-]//g' titi.txt
     sed -e 's/[^0-9]//g' -e '/^$/d' titi.txt
     ``` 
  
- Afficher, sur stdout, les champs 1 et 4 issue du découpage à partir du token ``:`` du fichier titi.txt

     ```bash linenums="1"
     cut -d : -f 1,4 titi.txt
     awk -F ":" 'NF > 1 { OFS=":" ; print $1,$4  }' titi.txt
     ```
  
- Trier les lignes de titi.txt

     ```bash linenums="1"
     sort titi.txt
     ```
  
- Effacer les lignes vides contenues dans le fichier bonjour.c

     ```bash linenums="1"
     sed -e '/^$/d' bonjour.c
     awk ' NF != 0 {print $0 }' titi.txt
        ou implicitement :
     awk 'NF' test
     ```

- Ecrivez un script awk qui permet d'afficher chaque groupe disponible sur votre machine, suivit de son numéro GID, si et seulement si son GID est > 1.  
    Formattez la sortie comme ceci :   
    ``Nom du groupe : [groupName] / ID du groupe : [GID]``  
    Voici un example de fichier ``/etc/group`` si vous n'en avez pas :
    
    ```linenums="1"
    wheel:*:0:root
    daemon:*:1:root
    kmem:*:5:root
    jberger:*:200:user
    user1:*:201:user
    eleve:*:500:eleves
    ```  
    
     ```bash linenums="1"
     awk -F ":" '$3 > 1 { print "Nom du groupe : " $1 " / ID du groupe : " $3 }' /etc/group
     ```
        
## Archiver son travail : tar, gzip

- Se positionner sous votre home directory  et archiver SE en donnant votre nom à l'archive.

     ```bash linenums="1"
     tar -cvzf nom.tar.gz SE/
     ```