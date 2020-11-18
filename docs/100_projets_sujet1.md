# Mini Projets : Sujet 1 - Reveil

---

## Sujet 1 - Réveil

C'est le sujet le plus facile ... les notations seront donc très exigentes !

!!! success ""
    On veut créer un Logiciel sur plusieurs programmes

    - Un programme (processus) principal qui attends les commandes de l’utilisateur
    - Un processus fils (toujours présent) compte le temps d’exécution du logiciel depuis son lancement et le stock dans un fichier quand on quitte le programme
    - Selon les commandes reçue dans le processus principal , on lance **N processus fils en parallèle**

        -*^^Réveil^^* : qui sonne à l’heure donnée en paramètre (surprenez moi)  
        -*^^Chronomètre^^* : qui peut stocker trois temps intermédiaires sur événement clavier  
        -*^^Compte à rebours^^* : avec 2 temps de sonneries intermédiaires configurables  
        -*^^Statistiques^^* d’utilisation du logiciel (libre)   
        -*^^Monitoring^^* des processus du logiciel (statique (--) / dynamique (++))  

    - Le processus principal n’est ^^jamais bloqué^^
    - Les processus fils sont lancés dans des terminaux ==**distincts**==
    - Le programme final doit pouvoir être utilisé n’importe ou, sur n’importe quelle machine.
    - Automatisez le réveil pour qu’il sonne tous les matins à heure fixe
    
    
### Iterations 

!!! success ""
    Il est de la responsabilité de l'équipe de se committer sur une RoadMap des itérations avec le prof lors du premier cours !