# TP Regexp

Dans ce TP, vous apprendrez à utiliser les outils d'expression régulières.

---

## Travail sur les fichiers : sed, awk, diff, cut, sort

Sur le fichier C utilisé au TP précédent : 

- Transformer les commentaires // en /* */ – Affichage stdout
- Transformer les commentaires /* */ en // – Affichage dans un fichier bonjour.cpp
- Comparer les fichiers bonjour.cpp et bonjour.c 
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
- Ne garder que les chiffres du fichier – Affichage stdout
- Afficher, sur stdout, les champs 1 et 4 issue du découpage à partir du token ``:`` du fichier titi.txt
- Trier les lignes de titi.txt
- Effacer les lignes vides contenues dans le fichier bonjour.c


## Archiver son travail : tar, gzip

- Se positionner sous SE et archiver TP1 et TP2
- Compresser l’archive précédemment obtenue