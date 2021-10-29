# Noyau (Kernel)

C'est le Programme qui assure :
 
- La gestion de la mémoire  
- Le partage du processeur entre les différentes tâches à exécuter et les entrées/sorties de bas niveau.  
- Une bonne répartition des ressources de l’ordinateur (mémoire, processeur(s), espace disque, imprimante(s), accès réseaux) sans intervention des utilisateurs  

!!! tip ""
    Il est lancé au démarrage du système (le boot) et s’exécute jusqu’à son arrêt.
 
C’est un programme relativement petit, qui est chargé en mémoire principale.   

Il s’exécute en **mode superviseur**, c’est-à-dire qu’il a accès à toutes les fonctionnalités de la machine :  

- accès à toute la mémoire  
- à tous les disques connectés  
- manipulations des interruptions, etc...  

!!! tip "" 
    Tous les autres programmes qui s’exécutent sur la machine fonctionnent en mode utilisateur.   
    Ils leur est *interdit d’accéder directement au matériel et d’utiliser certaines instructions*.   
    
    Chaque programme utilisateur n’a ainsi accès qu’à une certaine partie de la mémoire principale, et il lui est impossible de lire ou écrire les zones mémoires attribuées aux autres programmes.   
    
    Lorsque l’un de ces programmes désire accéder à une ressource gérée par le noyau, par exemple pour effectuer une opération d’entrée/sortie, **il exécute un appel système**.   
    
    Le **noyau** exécute alors la fonction correspondante, ==après avoir vérifié que le programme appelant est autorisé à la réaliser==.
