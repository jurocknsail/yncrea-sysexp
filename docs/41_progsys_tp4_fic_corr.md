# Programmation Système : TP4 - E/S Bas Niveau

---

## Exercice 1 : Chaine vs. Int

Écrire un programme en C qui :  

- Ouvre (créer si n’existe pas) un fichier « test » , en lecture et écriture.
- Affiche son descripteur de fichier
- Y écrit une chaine de caractères ainsi qu’un entier
- Affiche la position du curseur de fichier
- Le replace au début du fichier
- Relis le fichier
- Ferme les descripteur proprement et se termine.

??? example "Solution"

    ```c linenums="1"
    
    #include <stdio.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <fcntl.h>
    #include<sys/types.h>
    
    int main (void) {
        
        int desc = open ("test", O_RDWR|O_CREAT, 0750);  
        printf("Le desc de fichier vaut : %d\n", desc);
    
        char c [6]="chaine";
        int x = 97;
        write(desc,c,sizeof(c)); 
        write(desc,&x,sizeof(x));
    
        int pos = lseek(desc,0, SEEK_CUR);
        printf("Position courante du curseur : %d\n", pos);
        
        pos = lseek(desc,0, SEEK_SET);
        printf("Nouvelle position courante du curseur : %d\n", pos);
            
        char cl [6];
        int nb, xl;
        
        nb = read(desc,cl,6);
        printf (" C : '%s' avec nb octets lus : %d \n", cl, nb);
        nb = read(desc,&xl,sizeof(int));
        printf (" X : '%d' avec nb octets lus : %d \n", xl, nb);
        
        printf("Taille d'un INT :  %lu \n", sizeof(int));	
        
        close(desc);
        
        return 0; 
    }
    ```
    
   !!! tip 
       La valeur ``97`` correspond à la lettre ``a`` dans la table ASCII, d'où le fait qu'il apparait dans vi , qui arrive à décoder le premier octet de l'int comme un caractère !