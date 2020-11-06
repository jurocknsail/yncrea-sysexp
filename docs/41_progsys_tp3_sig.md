# Programmation Système : TP3 - Signaux

---

## Sur Papier

### Exercice 1

Donner les différents affichages possibles pouvant se produire avec le programme suivant :

```c linenums="1"
void interruption (int sig) {
    printf("UN\n");
}

int main (void) {
    signal(SIGCHLD, interruption);
    if ( fork() ) {
        printf("DEUX\n");
        wait(NULL);
    }
    else 
        printf("TROIS\n");
    exit(0);
}
```

### Exercice 2

Donner les différents affichages possibles pouvant se produire avec le programme suivant :


```c linenums="1"
#include <signal.h>
#include <stdlib.h>
#include <stdio.h>

void stop (int sig);

int main (void) {
    
    int pid;
    pid = fork();

    if (pid == 0){
        pause();
        signal(SIGUSR1, stop);
        printf("ici le fils: j'attends un signal de mon père\n);
    } else {
        sleep(1);
        printf("ici le pere: j'envoie un signal a mon fils\n");
        kill(pid, SIGUSR1);
        sleep(1);
        kill(pid, SIGKILL);
        wait(NULL);
        printf("ici le pere: j'ai arreté mon fils\n");
    }
}

void stop (int sig) {
    printf("ici le fils mon pere m'a tué\n");
    exit(0);
}
```

---

## A coder !

### Exercice 3 

Ecrire un programme ex3 qui contrôle la frappe du caractère "ctrl C".  
Les 5 premières fois: affichage de "Vous avez tape CTRL C" sur l'écran, la 6ème : arrêt de la tâche. 

### Exercice 4  

Une tâche mère ex4 active une tâche fille (sur un seul programme).   
La tâche fille se met en boucle infinie.  
La tâche mère lui envoie un signal, la débloquer et attend la fin de la fille.

!!! tip
    Attention à la position de l'appel à ``signal()`` : par défaut, la reception de `SIGUSR1` tue le process ...   
    Il faut donc etre sur que le cablage est fait coté fils **avant** l'appel à ``kill()`` coté père !

### Exercice 5

Une tâche mère ex5 active une tâche fille ex5f (sur deux programmes)..   
La tâche fille se met en boucle infinie.   
Lorsqu'on tape sur une touche, la mère envoie à sa fille un signal, la débloque et attend la fin de celle-ci. 

### Exercice 6  

Ecrire un programme qui simule un réveil en utilisant le signal SIGALRM. 

### Exercice 7

Réaliser un dispositif réveil sans l'utilisation du signal SIGALRM :  
La tâche mère ex7 active une tâche fille ex7-2 et lui demande de la réveiller au bout d'un certain temps.