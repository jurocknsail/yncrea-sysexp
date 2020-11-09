# Programmation Système : TP1 - Echauffement

---

## Programme avec Paramètres

### Exercice 1

Ecrire un programme qui affiche ses paramètres puis les variables d’environnement de votre OS.

!!! tip
    En C, il existe 3 prototypes de fonction ``main`` : 
    
    ```c linenums="1"
    int main(void);
    int main (int argc, char *argv[]);
    int main (int argc, char *argv[], char *arge[]);
    ```
    
    A vous de choisir celle appropriée ! Un petit coup de Google ne fait pas de mal ...
    
### Exercice 2

Ecrire un programme de calculatrice simple, qui prends deux nombres ainsi que l'opérateur en paramètres.

Ex d'éxecution attendue : 
   
```bash linenums="1"
calc 5 + 3 
  résultat = 8
```

