# Programmation Système - Signaux

---

## Définition

!!! abstract ""
    Les signaux constituent un mécanisme de fondamental de communication entre processus :  
    Ils sont  utilisés par un processus pour signaler à un autre processus (ou à un groupe de processus) l’arrivée d’un événement qui peut être :  
    
    – matériel  
    – lié au fonctionnement multitâche  
    – lié à une application spécifique  

    Ce sont des ==**interruptions logicielles**== !
    
---

## Exemples de Signaux

!!! quote ""
    Liste non exhaustive ...  
    
| Nom  | N°  | Fonction  |
| --------- |--------------- | ----------------- |
| ``SIGHUP`` | 1 | déconnection du terminal |
| ``SIGINT`` | 2 | interruption ``^C`` |
| ``SIGQUIT`` | 3 | abandon ``^\`` (core) |
| ``SIGKILL`` | 9 | destruction (ne peut être ignoré) |
| **``SIGUSR1``** | **10** | **réservé à l’utilisateur (communication inter-processus)** |
| **``SIGUSR2``** | **12** | **réservé à l’utilisateur (communication inter-processus)** |
| ``SIGPIPE`` | 13 | essai d’écriture dans un pipe non ouvert |
| ``SIGALRM`` | 14 | horloge (arrêt de l’horloge d’un processus: ``alarm()``) |
| ``SIGTERM`` | 15 | terminaison normale d’un processus |
| ``SIGCHLD`` | 17 | mort d’un fils (envoyé au père) |
| ``...`` | ... | ... |

!!! tip ""
    Tout ces signaux se trouvent dans le fichier header : ``signal.h``

!!! danger ""
    Le comportement par défaut des signaux `SIGUSR1` et `SIGUSR2` est : `SIGKILL` !     
    Si non redéfinis, leur reception entrainera la mort du processus visé ...  

--- 

## Traitements

!!! abstract ""
    Il y a 3 actions possibles lors de la reception d'un signal par un processus :  
    - L'**ignorance** : ``SIG_IGN``  
    - La prise en compte pour effectuer une **action spécifique** : ``nomFonction``  
    - La restauration du **comportement par defaut**  : ``SIG_DFL``
    
!!! warning ""
    Certains signaux ne peuvent pas être ignorés, par exemple `SIGKILL`.
    
!!! tip ""
    Dans le cas d'une action **spécifique** :   
    - l’action est faite dans une fonction qui doit être spécifiquement attachée au signal donné.   
    - cet attachement est valable pour toute la durée du programme.   
    
    ^^A l’arrivée du signal^^ :   
    – le traitement en cours est ==**interrompu**==    
    – la fonction est exécutée  
    – le traitement est repris où il en était avant **l'interruption**  
    
    
---

## Primitives

### Signal  

!!! abstract ""
    La primitive `signal()` permet de spécifier le comportement d’un processus à la réception d’un signal donné.
    C'est une fonction **non bloquante** qu'il faut voir comme une configuration utilisée plus tard, lors de la reception du signal.  

```c linenums="1"
#include<signal.h>
void (*signal (int sig, void (*fcn)(int)))(int)  

- sig : numéro du signal
- (*fcn) : action après réception 
```    
 
!!! tip ""
    -> Intercepte le signal de numéro sig   
    -> Exécute la fonction fcn  

#### Exemples 

```c linenums="1"
signal(SIGUSR1, traite) ;
signal(SIGINT, SIG_IGN);
```   

### Kill

!!! abstract ""
    La primitive `kill()` permet **d’envoyer un signal** à un processus, via son **PID**.  
    L’envoi de signal ne peut se faire qu’entre tâches de même UID.  
    Si on utilise PID = 0 : tous les processus du ^^groupe^^ sont concernés (broadcast).


!!! danger ""
    Elle envoie n'importe quel signal, pas uniquement `SIGKILL` malgrès son nom !!
    
```c linenums="1"
#include<signal.h>
int kill(int pid,int no_signal);  

– pid no du process récepteur
– résultat : 0 si le signal a été envoyé, -1 sinon (erreur)
```         

#### Exemples

```c linenums="1"
kill (0,SIGUSR1);
kill (1234,SIGKILL);
```

### Pause

!!! abstract ""
    La primitive ``pause()`` correspond à de l’attente pure, d'un signal **quelconque**.
    C'est une fonction **bloquante**.  
    
```c linenums="1"
void pause(void);

- Elle ne fait rien
- Attend l’arrivée d’un signal quelconque
```  
  
#### Exemple

```c linenums="1"
pause();
```  

### Alarm

!!! abstract ""
    La primitive ``alarm()`` envoi un signal de type ``SIGALRM`` au processus appelant après laps de temps (en seconde).  
    C'est une fonction **non bloquante**.

```c linenums="1"
#include<unistd.h>
int alarm (int sec);

- resultat : temps écoulé depuis le dernier appel à alarm();

Note : 
- l'appel à  alarm(0); annule toutes les alarmes enregistrées !
- chaque appel enreigistre une nouvelle alarme, en indiquant en retour le temps restant pour l'alarme précédemment enregistrée.
```      

#### Exemple

```c linenums="1"
alarm(12);
```  

---

## Exemple complet

<table border="0">
<tr>
    <td>
        Dans le père :
    </td> 
    <td>
        Dans le fils :
    </td>
</tr>

<tr>
    <td>
```c hl_lines="8"
#include <signal.h>
int main(void)
{
    int pid ; 
    pid=fork(); 
    if(pid = = 0)
        execv("fille", NULL);
    signal(SIGUSR1,fonc); 
    for(;;)
    {
        printf(" je boucle\n ");
        sleep(1); 
    }
}

void fonc(int sig) {
    printf(" signal recu %d\n ", sig);
    exit(0);
}
```
    </td>
    <td>
```c hl_lines="4"
#include<signal.h>
int main(void) {
    sleep(5); 
    kill(getppid(),SIGUSR1); 
    exit(0);
}
```
    </td>
</tr>
</table>


!!! warning ""
    La position de l'appel à `signal()` dans le programme est très importante !  
    La configuration doit être faite avant la reception du signal en question !  