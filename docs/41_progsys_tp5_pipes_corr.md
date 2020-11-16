# Programmation Système : TP5 - Pipes

---

# Programmation Système : TP5 - Pipes

---

## Exercice 1 : Pipe anonyme

Ecrire un programme qui permet à deux taches (sur un seul programme) de communiquer entre elles en utilisant un pipe **non nommé** :   
On saisi un message au clavier dans la tache fille, qui l’envoie, caractère par caractère, à la mère qui l’affiche (la mère affiche tout d'un coup).  


```c linenums="1"
#include <stdio.h>
#include <sys/types.h>
//#include <sys/wait.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>


int main(void)
{
	char bufmere[80];
	char buffille[80]; 
	int p[2];
	int pid, nb_car, i;
	pipe(p);
	pid=fork(); 
	if (pid==0) {
		close(p[0]);
		printf("ici la fille... que voulez vous ecrire a ma mere? \n"); 
		while(buffille[0] != '\n')
		{
			buffille[0]= getchar();	
			write(p[1],&buffille[0],sizeof(char));
		 }
	} else {
		close(p[1]);
		i=read(p[0],bufmere,80) ;
		bufmere[i]='\n' ;
		
		printf("ici la mere...je recois ce message de ma fille:\n") ; 
		printf("%s",bufmere) ;
	}
}
```
    
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

```c linenums="1"
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
//#include <sys/wait.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <fcntl.h> 
#include <errno.h>
#include <string.h>


int main(int argc,char *argv[])
{
	char fic[512], buf[512];
	int dp,df,nb_char,pid;

	printf("\nici le processus producteur....\n");
	pid=fork();
	if(pid==0)
		execv("exo2F",NULL); 

	mkfifo("pipe",0750);
	dp=open("pipe",O_WRONLY) ; 
	if( dp==-1)
		printf("probleme d ouverture du pipe en ecriture par la mere") ;

	df=open(argv[1],O_RDONLY) ; 
	if(df==-1)
		printf("probleme d ouverture du fichier en lecture par la mere ");

	printf("READ FILE\n");

	nb_char =-1;
	while(nb_char != 0){
		nb_char=read(df,fic,80);
		printf("PERE : je lis %d char \n", nb_char);
		printf("jai lu : %s", fic);
		write(dp,buf,nb_char);
	}

	close(df); 
	close(dp); 
	wait(NULL); 
	exit(0);
}
```

```c linenums="1"
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
//#include <sys/wait.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <fcntl.h> 
#include <errno.h>
#include <string.h>


void erreur(char *mes);

int main(void)
{
	char buf[80] ;
	int dp,nb_char ;
	printf("\nici le processus consommateur...\n") ; 
	
	dp=open("pipe",O_RDONLY) ;
	nb_char=read(dp,buf,80) ; 
	buf[nb_char]='\0';
	printf("lu %d\n", nb_char);
	if(nb_char==-1)
		erreur("erreur de lecture dans le pipe par la fille"); 
	
	while(nb_char!=0)
	{	
		printf("1 Fils reste %d \n", nb_char);
		printf("%s\n",buf);
		write(1,buf,nb_char);
		nb_char=read(dp,buf,80);
		buf[nb_char]='\0';
		printf("2 Fils reste %d \n", nb_char);
		if(nb_char==-1) 
			erreur("erreur de lecture dans le pipe par la fille");
	} 
	printf("FIN FILS\n");	
	close(dp) ; 
  exit(0) ;
}

void erreur(char *mes)
{
	printf("\nErreur %s \n", mes) ; 
	exit(0);
}
```

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

```c linenums="1"

#include <stdio.h>
#include <fcntl.h>

int main(int argc, char * argv[]){
	int p1 = 0;
	int tmp = 25310;
	int dp, f;
	char buf;

	unlink("pipe");
	mkfifo("pipe" ,0666);


	p1 = fork();
	if(p1 != 0){
		dp=open("pipe",O_WRONLY);
		write(dp, &tmp,sizeof(int));
		close(dp);
	}
	else{
		execv("ex3_1",NULL);
	}

	return 0;
}
```

```c linenums="1"

#include <stdio.h>
#include <fcntl.h>

int main(void){
	int des;
	int buf;

	des=open("pipe",O_RDONLY);
	read(des,&buf,sizeof(int));
	printf("%d", buf);


	close(des);

	return 0;
}
```

---

## Exercice 4 : Calculette efficace !

Créer, dans un même programme, un mécanisme pour réaliser une calculette sur des réels où la saisie de l'opération est faite par une tâche, et le calcul par une autre tâche, celle-ci communiquant le résultat à la première qui l'affiche.   
De plus une session de la calculette ne doit pas se limiter à une opération mais à autant que le désire l'opérateur. 

```c linenums="1"
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>


int main(int argc, char * argv[]){
	int p1 = 0;
	int dp, des, dp1, des1;
	char buf;

	float op1 = 0, op2 = 0, res = 0;
	char opt;
	int c;


	unlink("pipe");
	mkfifo("pipe" ,0666);
	unlink("pipe1");
	mkfifo("pipe1" ,0666);


	p1 = fork();
	if(p1 != 0){			//pere
		dp=open("pipe",O_WRONLY);
		dp1=open("pipe1",O_RDONLY);
		while(1){
			printf("\n\nEntrer le nouveau calcul : ");
			scanf("%f", &op1);
			while((c=getchar()) != '\n' && c != '\n');
			//fseek(stdin, 0, SEEK_END);
			scanf("%c", &opt);
			while((c=getchar()) != '\n' && c != '\n');
			scanf("%f", &op2);
			while((c=getchar()) != '\n' && c != '\n');


			write(dp, &op1,sizeof(float));
			write(dp, &opt,sizeof(char));
			write(dp, &op2,sizeof(float));
			while(!read(dp1,&res,sizeof(float)));
			printf("\n%.2f %c %.2f = %.2f\n", op1, opt, op2, res);
		}
		close(dp);
		close(dp1);
	}
	else{			//fils
		des=open("pipe",O_RDONLY);
		des1=open("pipe1",O_WRONLY);
		while(1){
			while(!read(des,&op1,sizeof(float)));
			while(!read(des,&opt,sizeof(char)));
			while(!read(des,&op2,sizeof(float)));


			if(opt == '+'){
				res = op1+op2;
			}
			else if(opt == '-'){
				res = op1-op2;
			}
			else if(opt == '*'){
				res = op1*op2;
			}
			else if(opt == '/'){
				res = op1/op2;
			}

			write(des1, &res,sizeof(float));
		}
		close(des);
		close(des1);
	}

	return 0;
}
```