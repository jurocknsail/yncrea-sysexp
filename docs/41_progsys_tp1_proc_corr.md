# Programmation Système : TP1 - Echauffement

---

## Programme avec Paramètres

### Exercice 1

Ecrire un programme qui affiche ses paramètres puis les variables d’environnement de votre OS.

??? example "Solution"

    ```c linenums="1"
    #include<stdio.h>
    #include<sys/types.h>
    #include<sys/wait.h>
    #include<unistd.h>
    #include<stdlib.h>
    
    int main (int argc, char *argv[], char *arge[])
    {
        
        //Partie variables d'env
    
    
        printf ("Nombre d'arguments = %d\n", argc);
        for (i = 0; i < argc; i++)
            printf ("Argument %d : %s\n", i, argv[i]);
            
        printf ("Variables d'env:\n");
        
        i=0;
        while(arge[i]!=NULL)
        {
            printf ("Variable d'Env[%d]=%s\n",i,arge[i]);
            i++;
        }
       
        return 0;
    }
    ```
    
### Exercice 2

Ecrire un programme de calculatrice simple, qui prends deux nombres ainsi que l'opérateur en paramètres.

??? example "Solution"

    ```c linenums="1"
    #include<stdio.h>
    #include<sys/types.h>
    #include<sys/wait.h>
    #include<unistd.h>
    #include<stdlib.h>
    
    int main (int argc, char *argv[], char *arge[])
    {
        //Partie Calculette
        int o1,o2;
        char op;
        int res;
        int i =0;
        
        if(argc!=4)
        {   
            printf("\tJ'attends 3 arguments passés au programme !\n");
            exit(0);
        }
        
        o1=atoi(argv[1]);
        o2=atoi(argv[3]);
        op=*(argv[2]);
    
        switch(op)
        {   
            case '+':
                res=o1+o2;
            break;
            case '-':
                res=o1-o2;
            break;      
            case '*':
                res=o1*o2;
            break;      
            case '/':
                res=o1/o2;
            break;
            default:
                printf("erreur d'operande\n");  
        }       
        printf("res=%d\n",res); 

        return 0;
    }
    ```

---

## Zombie War

### Exercice 3

1. Ecrire un programme en C qui créer **deux** processus et qui met en valeur le phénomène des *processus zombie*.

??? example "Solution"

    ```c linenums="1"
    #include<stdio.h>
    #include<sys/types.h>
    #include<sys/wait.h>
    #include<unistd.h>
    #include<stdlib.h>
    
    int main(void)
    {
        pid_t pid;
        pid = fork();
        if(pid==-1)
        {
                printf("Error on fork\n");
                exit(-1);
        }
    
     	if (pid == 0)
     	{
            printf("FILS :  mon pid = %d et celui de mon pere est %d \n",getpid(), getppid());
            sleep(10);
            printf(">>> mort du fils \n");	
     	}
     	else
     	{
            printf(" PERE : mon pid = %d, j'attends la mort de mon fils\n",getpid());
            sleep(20); //Pendant 10 sec on observe le zombie ...    
            exit(0);
        }
    }
    ```

1. Le corriger pour le rendre « propre » !


??? example "Solution"

    ```c linenums="1"
    #include<stdio.h>
    #include<sys/types.h>
    #include<sys/wait.h>
    #include<unistd.h>
    #include<stdlib.h>
    
    int main(void)
    {
        pid_t pid;
        pid = fork();
        if(pid==-1)
        {
                printf("Error on fork\n");
                exit(-1);
        }
    
     	if (pid == 0)
     	{
            printf("FILS :  mon pid = %d et celui de mon pere est %d \n",getpid(), getppid());
            sleep(10);
            printf(">>> mort du fils \n");	
            exit(0);
     	}
     	else
     	{
            printf(" PERE : mon pid = %d, j'attends la mort de mon fils\n",getpid());
       	    wait(NULL);
            printf ("Pere : j'ai recut la mort de mon fils, je peux mourir en Paix. RIP.\n");   
            
            sleep(10); // Pendant ces 10 sec, on n'observe PLUS de Zombie :) 
    
            exit(0);
        }
    }
    ```