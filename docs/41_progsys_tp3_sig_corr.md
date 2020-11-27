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

|  **Solution 1**  | **Solution 2** | **Solution 3** |
| --- | --- | --- |
| DEUX -> TROIS -> UN | TROIS -> UN -> DEUX | TROIS -> DEUX -> UN |

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

Réponse :  

````
ici le pere: j'envoi un signal a mon fils
ici le pere: j'ai arrete mon fils
````

---

## A coder !

### Exercice 3 

Ecrire un programme ex3 qui contrôle la frappe du caractère "ctrl C".  
Les 5 premières fois: affichage de "Vous avez tape CTRL C" sur l'écran, la 6ème : arrêt de la tâche. 

??? example "Solution"

    ```c linenums="1"
    
    #include <stdlib.h>
    #include <stdio.h>
    #include <sys/types.h>
    #include <unistd.h>
    #include <sys/wait.h>
    #include <signal.h>
     
    void catchCtrlC()
    {
        static int cpt = 0;
       
        if(cpt++ < 5)
        {
            printf("\rVous avez tapé CTRL C (x%d)\n", cpt);
           
            if(cpt == 5)
                signal(SIGINT, SIG_DFL); // On rétablit le comportement par défaut du CTRL C
        }
    }
     
    int main()
    {
        printf("--- DEBUT ---\n");
       
        signal(SIGINT, catchCtrlC); // On connecte le nouveau signal pour modifier le comportement lors d'un CTRL C
        for(;;); // On boucle à l'infinie
       
        printf("--- FIN ---\n");
        return 0;
    }
    ```

Version variable globale (moins bien ...) : 

??? example "Solution"

    ```c linenums="1"
    
    #include <stdio.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <signal.h>
    
    int n=0;
    void fonc(int sig);
    int main(void)
    {
            signal(SIGINT,fonc);
    
            printf("[Main] je boucle\n");
            while(n<5)
            {
                    printf("[Main] appuyer sur CTRL C\n");
                    pause();
            }
        return 0;
    }
    
    void fonc(int sig)
    {
            printf("[fonc] num signal reçu =<%d>\n",sig);
            n++;
            printf("[fonc] appuyer sur CTRL C- <%d>\n",n);
    }
    
    ```

### Exercice 4  

Une tâche mère ex4 active une tâche fille (sur un seul programme).   
La tâche fille se met en boucle infinie.  
La tâche mère lui envoie un signal, la débloquer et attend la fin de la fille.

??? example "Solution"

    ```c linenums="1"
    
    #include <stdio.h>
    #include <sys/types.h>
    //#include <sys/wait.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <signal.h>
    
    void stop(int sig){
        printf(" FILLE : Ma mère m'arrête en m'envoyant le signal %d\n",sig);
        exit(0);
    }
    
    int main (void){
        int pid;
        pid = fork();
        signal(SIGUSR1,stop);
        if(pid == 0){
            for(;;){
                printf(" FILLE BOUCLE\n");
                sleep(1);
            }
        }
        else{
            printf(" MERE : j'arrête la fille\n");
            kill(pid,SIGUSR1);
            wait(NULL);
        }
    
    }
    ```

### Exercice 5

Une tâche mère ex5 active une tâche fille ex5f (sur deux programmes)..   
La tâche fille se met en boucle infinie.   
Lorsqu'on tape sur une touche, la mère envoie à sa fille un signal, la débloque et attend la fin de celle-ci. 

??? example "Solution"
    
    Père :

    ```c linenums="1"
    #include <stdio.h>
    #include <sys/types.h>
    //#include <sys/wait.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <signal.h>
    
    
    int main(void)
    {
        int pid, status ;
        char ch;
        char * argv[2];
    
        pid=fork();
     
        if(pid == 0){
            argv[0]="exo5F";
            argv[1]=NULL;
            execv("exo5F",argv);
        }
        else{
            printf("PARENT : press key to stop child\n");
            scanf("%c",&ch);
            kill(pid,SIGUSR1);
            wait(&status);
            printf("PARENT : Child stopped with status %d\n", status>>8);
        }
    }
    ```
        
    Fils :
        
    ```c linenums="1"
    #include <stdio.h>
    #include <sys/types.h>
    //#include <sys/wait.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <signal.h>
    
    void stop(int sig){
        printf("CHILD : Stopped by parent with signal %d\n",sig);
        exit(3);
    }
    
    int main(void)
    {
        signal(SIGUSR1, stop);
        for(;;)
        {
            printf("CHILD : LOOPING\n");
            sleep(1);
        }
    }
    ```
    

### Exercice 6  

Ecrire un programme qui simule un réveil en utilisant le signal SIGALRM. 

??? example "Solution"

    ```c linenums="1"
    #include <stdio.h>
    #include <sys/types.h>
    //#include <sys/wait.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <signal.h>
    
    void reveil(int sig){
        printf(" BIP BIP BOP !!!! \n");
        exit(0);
    }
    
    int main(void)
    {
        int i=0;
        int car;
        printf("Dans cb de temps veux-tu te lever ?");
        scanf("%d", &car);
        alarm(car);
        signal(SIGALRM, reveil);
        for(;;){
            i++;
            printf("\rTu dors depuis %d sec",i); // \r used for next line
            fflush(stdout); // flushing stdout allows to erase previous printf so it appears updated instead of new line !
            sleep(1);
        }
    }
    ```

    !!! tip
        On pouvait aussi simplement utiliser la fonction ``pause()`` à la place de la dernière boucle si l'on ne souhaite pas l'affichage du décompte :wink:  
    
    
### Exercice 7

Réaliser un dispositif réveil sans l'utilisation du signal SIGALRM :  
La tâche mère ex7 active une tâche fille ex7-2 et lui demande de la réveiller au bout d'un certain temps.

??? example "Solution"
    
    Père :

    ```c linenums="1"
    #include <stdio.h>
    #include <sys/types.h>
    //#include <sys/wait.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <signal.h>
    
    void reveil(int sig){
        printf(" BIP BIP BOP !!!! \n");
        wait(NULL);
        exit(0);
    }
    
    int main(void)
    {
        int delai, pid;
        char heure [10];
        char * argv[3];
        
        signal(SIGUSR1, reveil);
        printf("MERE : Entrez l'heure de reveil : ");
        scanf("%d", &delai);
        sprintf(heure, "%d", delai);
        
        pid=fork();
        if(pid==0)
        {
            argv[0]="exo7F";
            argv[1]=heure;
            argv[2]=NULL;
            execv("exo7F",argv);
        }
        printf("MERE : J'attends le reveil de ma fille dans %d sec\n", delai);
        pause();
    }
    ```
        
    Fils :
        
    ```c linenums="1"
    #include <stdio.h>
    #include <sys/types.h>
    //#include <sys/wait.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <signal.h>
    
    
    int main(int argc, char * argv[])
    {
    	int delai, i;
    	delai = atoi(argv[1]);
    	printf("FILLE \n");
    	for(i=delai;i>0;i--)
    	{
    		printf(" Je reveille ma mère dans %d \n", i);
    		sleep(1);
    	}
    	kill(getppid(),SIGUSR1);
    	exit(0);
    }
    ```