# Programmation Système : TP2 - Fork/Execv

---

## Sur Papier

### Exercice 1 : Arbre généalogique

On a le code suivant :

```c linenums="1"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main()
{
	int p1,p2,p3;
	p1=p2=p3=-1;
	p1=fork();
	p2=fork();
	p3=fork();
	if(p1==0)
		execv("F1",NULL);
	if(p2==0)
		execv("F2",NULL); 
	if(p3==0)
		execv("F3",NULL);
    pause();
	exit(0);
}
```

1. Combien de processus s'executent ?
1. Sur quels programmes (Père, F1, F2 et F3) ?

Justifiez vos réponses en dessinant un arbre généalogique.

### Exercice 2 : Lecture de code

On suppose que le pid du père est 100 et celui du fils 200, quelles sont les valeurs affichées par le programme ci-dessous ?  

```c linenums="1"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main(void)
{
	int pid;
	int x = 0;
	x++;
	printf(" mon pid est %d x = %d \n",getpid(),x);
	pid = fork();
	if(pid == 0)
	{
		x++;
		printf(" mon pid est %d x = %d \n", getpid(), x );
	} else
		printf(" mon pid est %d x = %d \n", getpid(), x ); 
	printf(" mon pid est %d x = %d \n", getpid(), x );
}
```

---

## A coder !

### Exercice 3 : fork()

Dans **un même programme**, un processus en active un autre et se met en attente de la fin de celui-ci, récupère le **mot d’état** (valeur retournée par *exit()*) transmis et l’affiche.  

Chacun des processus affiche son PID et celui de son père.  
Le père affiche en plus le PID de son fils.  

!!! tip 
    Les simples mots "Dans un même programme" impliquent un *``fork()``* !

### Exercice 4 : execv()

Un processus (programme P) en active **un autre** F en lui transmettant une chaine de caractères saisie au clavier.  

- **F** calcule la longueur de la chaine et la transmet **comme mot d’état** à **P**.  
- **P** affiche la longueur.

!!! tip 
    Les simples mots "Un programme ... en active **un autre**" impliquent : *``fork() + execv()``* !