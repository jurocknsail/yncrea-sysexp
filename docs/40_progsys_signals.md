# Programmation Système - Signaux

---

## Definition

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


--- 

## Traitements