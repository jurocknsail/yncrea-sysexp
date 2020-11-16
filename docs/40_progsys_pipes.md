# Programmation Système - Pipes

---

!!! abstract ""
    Les pipes sont des objets permettant l’échange de données entre processus sur **une même machine**.    
    Les lectures/écritures dans un pipe se font avec les fonctions ``read()`` et ``write()`` classiques.  
    
    Il existe **deux** types de pipes :  
    - Anonymes  
    - Nommés    
    
---

## Echanges

### Chronologiques

!!! abstract ""
    Les échanges se font de manière ==**chronologique**==, en **FIFO** : les données lues sont celles écrites depuis le plus longtemps.  
    
    ![fifopipe](./assets/images/processus/fifopipe.jpg "fifopipe")

!!! warning ""
    Les lectures sont ==**destructrices**== !
    
    
### Atomiques

!!! abstract ""
    Les échanges se font de manière ==**atomique**== : si 2 tâches écrivent dans un même pipe respectivement ``m`` et ``n`` octets en "même temps" ces octets restent disjoints.  
    
    ![atompipe](./assets/images/processus/atompipe.jpg "atompipe")
    
### Synchronisés

!!! abstract ""
    Les échanges se font de manière ==**synchronisés**== :  
    
    - une tâche qui veut lire dans un pipe **vide** est suspendue jusqu’à l’écriture d’octets  
    - une tâche qui veut ouvrir en lecture un pipe qui n’est pas déjà ouvert en écriture est suspendue  
    - une tâche qui veut ouvrir en écriture un pipe qui n’est pas déjà ouvert en lecture est suspendue  
    - une tâche qui veut lire dans un pipe vide qui n’est plus ouvert en écriture reçoit le compte-rendu"fin de fichier"  