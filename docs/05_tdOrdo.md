# TD Ordonnancement

---

## Objectifs 

- Comparaison basique de deux systèmes d'exploitation (Windows et Linux). 
- Se rendre compte du travail effectué par le CPU : Ordonnancement manuel de processus.

---

## Prérequis

:fontawesome-solid-download: Télécharger ce fichier [BlankTables.xls](assets/files/BlankTables.xls) pour noter vos résultats des exos 2 & 3 :muscle:

---

## Exercice 1 : Comparatif rapide

Un système d'exploitation peut être vu comme un ensemble de logiciels organisés en couches, entre l'utilisateur et la partie matérielle de l'ordinateur.  
 
Vous avez a disposition des machine sous Windows et sous Linux ou Mac (la votre, une VM, WSL, chez votre voisin ...).  
Vous allez donc essayer de reconnaître les différentes composantes de ces deux systèmes d'exploitation.   

Pour vous aider, voici une liste (non exhaustive) de points à regarder : 

- Où est le noyau du SE ? est-il protégé ? 
- Quel est l'interpréteur de commande par défaut du SE ? Quelles en sont ses fonctionnalités ? En existe-t-il d'autres (interpreteurs) ? 
- Un SE digne de ce nom doit fournir de nombreux utilitaires de programmation (éditeurs, compilateurs, interpréteurs, débogueurs) : quels sont ceux présents par défaut avec le SE ? 
- … 

!!! warning 
    Si vous observez que le noyaux n'est pas protégé sur windows ... Ne le supprimez **PAS** !!  
    Vous rendrier votre machine inutilisable ...
    
!!! tip 
    Pour toutes ces recherches, google est votre ami :wink:  
    A la place de "noyau" on parle souvent historiquement de **"Kernel"** !
    
---

## Exercice 2 : Ordonnancement simple

Soit 5 processus A, B, C, D et E qui sont soumis à un CPU dans cet ordre, mais quasi simultanément.   
Ces travaux ne font pas d'entrées-sorties. Leurs durées respectives sont :  

| Processus    | durée(s) | 
| ------------ | -------- | 
| `A`          | 10s      |    
| `B`          | 6s       |
| `C`          | 2s       |
| `D`          | 4s       |
| `E`          | 8s       |

### Question 1

Déterminer les **temps de réponse** de chacun des processus, ainsi que le **temps de réponse moyen**, pour les disciplines :  
Pour le moment, on est en algos ==**non préemptifs**==.

- FIFO (First In First Out)  
- SJF (Shortest Job First)   
- Priorités, avec le plus petit chiffre égal à la priorité la plus forte et :

    | Processus    | durée(s) | Priorité | 
    | ------------ | -------- | ---------|
    | `A`          | 10s      | 3        |  
    | `B`          | 6s       | 5        |
    | `C`          | 2s       | 2        |
    | `D`          | 4s       | 1        |
    | `E`          | 8s       | 4        |
 
- PS (Proc. Sharing ou Tourniquet/Round Robin) et un **quantum de 2s**. 

### Question 2

On considère ces 5 processus ordonnancés par la politique à **priorité** précédente.  
A présent, les 5 processus  ==ne sont pas soumis en même temps==.  
Les dates d’arrivée des processus sont respectivement : 

| Processus    | durée(s) | Priorité | **Soumis à (s)** |
| ------------ | -------- | ---------| ---------------- |
| `A`          | 10s      | 3        | **2s**           |  
| `B`          | 6s       | 5        | **0s**           |
| `C`          | 2s       | 2        | **5s**           |
| `D`          | 4s       | 1        | **5s**           |
| `E`          | 8s       | 4        | **3s**           | 

Tracez le schéma d’exécution des processus en considérant que :  

1. L’ordonnancement est **non préemptif** comme précédemment.
1. Puis qu’il est **préemptif**. 

---

## Exercice 3 : Ordonnancement plus complexe

On considère un système **monoprocesseur** (avec capacité de préemption), de type Linux dans lequel les processus **partagent un disque comme seule ressource autre que le processeur**.  

Cette ressource (le **HDD**) n’est accessible qu’en ==**accès exclusif** et **non requérable**==, c’est-à-dire qu’une commande disque lancée pour le compte d’un processus se termine normalement avant de pouvoir en lancer une autre.  

Un processus peut être en {++exécution++}, {++en attente d’entrées-sorties++}, {++en entrées-sorties++} ou en {++attente du processeur++}.  

Les **demandes d’entrées-sorties** sont gérées à l’**ancienneté**.  

Dans ce système, on considère 4 processus soumis à t=0 dans l'ordre P1, P2, P3, P4, pour lesquels on sait que:  

- P1 et P2 sont des processus appartenant à la classe **SCHED_PRIO**.  
  Dans cette classe, le processeur est donné au processus de plus haute priorité.  
  Ce processus ==peut être préempté par un processus de la même classe ayant une priorité supérieure== 

- P3 et P4 sont des processus appartenant à la classe **SCHED_RR**.  
  Dans cette classe, le processeur est donné au processus de plus haute priorité pour un quantum de temps égal à **10 ms**.  
  La politique appliquée est celle du tourniquet. 

Les processus de la classe **SCHED_PRIO** sont toujours ==**plus prioritaires**== que les processus de la classe **SCHED_RR**.   

Les priorités des processus sont égales à *50* pour le processus P1, *49* pour le processus P2, P3 et P4.  
La plus grande valeur correspond à la priorité la plus forte. 


| P1                            | P2                            |     P3                             | P4                      |
| ----------------------------- | ----------------------------- | -----------------------------------| ----------------------- |
|  P1 Calcul pendant 40 ms      | P2 Calcul pendant 30 ms       | P3 Calcul pendant 40 ms            | P4 Calcul pendant 100 ms|
|  Lecture disque pendant 50 ms | Lecture disque pendant 80 ms  | Lecture disque pendant 40 ms       ||
|  Calcul pendant 30 ms         | Calcul pendant 70 ms          | Calcul pendant 10 ms               ||
|  Lecture disque pendant 40 ms | Lecture disque pendant 20 ms  |||
|  Calcul pendant 10 ms         | Calcul pendant 10 ms          |||

Établissez le chronogramme d’exécution des 4 processus en figurant les états {++prêt (attente du processeur)++}, {++exécution++}, {++attente I/O (attente du HDD)++}, {++I/O (lecture/ecriture HDD)++} .  



