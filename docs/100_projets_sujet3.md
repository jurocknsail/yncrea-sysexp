# Mini Projets : Sujet 3 - Equipes de Processus

---

C'est le sujet le plus difficile ... mais aussi le plus interessant !  
A vous de créer les iterations selon l'architecture choisie, et de s'engager sur la RoadMap avec votre client (le prof).  

## Sujet 3 : Equipes de processus

!!! danger ""
    - L'objectif est de créer **2 équipes de processus**, chacune composée d'un processus père et de **5 sous processus**.
    - Chaque sous-processus doit écrire dans un fichier son PID en binaire, et son PPID.
    - Les fichiers sont numérotés de 0000 à 9999. 
    - Le processus père envoie à ses sous-processus le numéro de fichier à conquérir. 
    - Le processus père est soumis à une tempo de 20s.
    
    - En outre, si un processus de l'autre equipe ouvre un fichier deja conquis par l'autre equipe, il recupère le pid de l'adversaire et le tue via ``SIG_QUIT``.
    - La partie s'arrête quand tous les processus d'une équipe sont morts.
    
    - Enfin, un programme qui compte les points par equipe devra être mis à disposition.... Ce comptage de point est persistant, est est rechargé à chaque démarrage du programme.
    
!!! danger ""
    Un programme ou plusieurs programmes distincts : archi libre !  
    A vous de justifier vos choix.  

### Iterations 

!!! danger ""
    Il est de la responsabilité de l'équipe de se committer sur une RoadMap des itérations avec le prof lors du premier cours !
