# Programmation Système : TP5 - Pipes

---

## Exercice 1 : Pipe anonyme

Ecrire un programme qui permet à deux taches (sur un seul programme) de communiquer entre elles en utilisant un pipe **non nommé** :   
On saisi un message au clavier dans la tache fille, qui l’envoie, caractère par caractère, à la mère qui l’affiche (la mère affiche tout d'un coup).  


---

## Exercice 2 : Pipe Nommé

Ecrire un système de deux taches sur deux programmes différents tel que :  

````
pere2 :
    active fils2
    lit un fichier dont le nom (chemin) est transmit comme paramètre au programme
    écrit le contenu du fichier dans le pipe nommé « pipe »

fils2 :
    lit dans le pipe
    écrit ce qu’il lit à l’écran.
````


---

## Exercice 3 : Ecriture et lecture de nombres dans un pipe nommé


Ecrire un système de deux taches sur deux programmes différents tel que :

````
pere3 :
    active fils3
    écrit un nombre entier dans le pipe nommé « pipe2 »
fils3 :
    lit dans le pipe
    écrit ce qu’il lit à l’écran.
````

---

## Exercice 4 : Calculette efficace !

Créer, dans un même programme, un mécanisme pour réaliser une calculette sur des réels où la saisie de l'opération est faite par une tâche, et le calcul par une autre tâche, celle-ci communiquant le résultat à la première qui l'affiche.   
De plus une session de la calculette ne doit pas se limiter à une opération mais à autant que le désire l'opérateur (chaque opération est gérée par un programme différent). 