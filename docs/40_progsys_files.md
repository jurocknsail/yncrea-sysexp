# Programmation Système - E/S bas niveau

---

## Manipuler des fichiers

!!! abstract ""
    Le but est de savoir manipuler tous les fichiers quels que soient leur type.  
    Ainsi nous sauront aussi bien gérer un fichier ASCII ou un Pipe depuis notre code C :wink: !  
    
    Nous allons nous intéresser aux fonctions suivantes :  
    - `open` : ouverture  
    - `read` : lecture  
    - `write` : écriture  
    - `close` : fermeture  
    - `lseek` : positionnement  
    
!!! tip ""
    Il faudra ajouter les includes suivants :  
    
    ```c linenums="1"
    #include <fcntl.h>
    #include <sys/types.h>    
    ```  
    
---

## Descripteurs de fichiers

!!! abstract ""
    Ils sont utilisés pour **==désigner== le fichier** dans les opérations: `open`, `read`, `write`, `close` ...  
    C'est le **nom local** du fichier dans le processus.  
    
    On dispose de **20** descripteurs seulement pour chaque processus (0 .. 19) dont **3** descripteurs alloués automatiquement :  
    – 0 entrée standard  
    – 1 sortie standard  
    – 2 sortie erreur    
    
    De plus, un **curseur** (pointeur) dans le fichier est associé à chaque descripteur.  
    Ce curseur se deplace lors des léctures/écritures et peut être déplacé.  
    Cela permet d'aller lire ou écrire uniquement certains octets !  
     
--- 

## Primitives

### Open

!!! abstract ""
    Permet d'ouvrir un fichier afin de la manipuler.  
    C'est la seule primitive qui utilisera la nom du fichier pour s'y référer, puis lui assignera un descripteur à utiliser dans les autres primitives.  
    
    
```c linenums="1"
int open( char *path, int mode);
int open( char *path, int mode, int perm);

– path : chemin d’accès au fichier
– mode ; mode d’ouverture :
    • O_RDONLY
    • O_WRONLY 
    • O_RDWR
    • O_APPEND 
    • O_CREAT
    • O_TRUNC 
    • etc ...

– perm : droits d’accès du fichier en cas de création
– résultat : descripteur de fichier
```  


#### Exemple

```c linenums="1"
int desc;
desc = open (" fichier ", O_RDONLY);

int desc;
desc = open (" fichier ", O_WRONLY|O_CREAT, 0666);
``` 

### Write

!!! abstract ""
    Permet d'écrire des données dans un fichier, en s'y référant par son descripteur.  
    Chaque écriture déplace le curseur dans le fichier (vers le bas).  
    
```c linenums="1"
int write (int desc, void *buf, int nboct);

– desc : descripteur de fichier
– buf : adresse de tampon des données à écrire 
– nboct : nombre d’octets à écrire

– résultat : nombre d’octets effectivement écrits, -1 en cas d’erreur
```  

#### Exemple

```c linenums="1"
char ch[10]= "exemple"; 
int x = 1; 
write(desc,ch,sizeof(ch); 
write(desc,&x,sizeof(int));
``` 

### Read

!!! abstract ""
    Permet de lire des données dans un fichier, en s'y référant par son descripteur.  
    Chaque lecture déplace le curseur dans le fichier (vers le bas).  
    Pour lire une donnée, il faut donc que le curseur se situe au début de celle-ci avant de lire !  
    
```c linenums="1"
int read (int desc, void *buf, int nboct);

– desc : descripteur de fichier
– buf : adresse de tampon des données à lire 
– nboct : nombre d’octets lus

– résultat : nombre d’octets effectivement lus, 0 si fin de fichier, -1 en cas d’erreur
```  

#### Exemple

```c linenums="1"
char ch[10]; 
int x, nb;
nb = read (desc, ch, 10);
nb = read (desc, &x, sizeof(int));
``` 

### Close

!!! abstract ""
    Permet la fermeture du fichier et la libération de son descripteur.  
    
```c linenums="1"
int close (int desc);

– desc : descripteur de fichier

– résultat : -1 en cas d’echec, 0 sinon
```  

#### Exemple

```c linenums="1"
close (desc);
``` 

### Lseek

!!! abstract ""
    Permet de déplacer manuellement le curseur dans un fichier.  
    On le deplacer d'un **offset positif ou négatif** (en ==octets==), à partir de trois références :  
    - `SEEK_SET` : Le début du fichier  
    - `SEEK_END` : La fin du fichier  
    - `SEEK_CUR` : La position courante du curseur  
    
```c linenums="1"
int lseek (int desc, int offset, int whence);

– desc : descripteur de fichier
– whence : origine du déplacement -> SEEK_SET, SEEK_CUR, SEEK_END
– offset : valeur du déplacement en octet

– résultat : nouvelle position (en octets) depuis le début du fichier
```  

#### Exemple

```c linenums="1"
int newPos = lseek(1, 4, SEEK_CUR);
``` 