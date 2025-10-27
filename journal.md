# Séance 1
Je trouve que la partie la plus difficile de cette séance est de comprendre les fonctionnalités des commandes, par exemple :

`cd` Changer de répertoire                       
`ls` Lister les fichiers                             
`pwd` Afficher le répertoire courant                     
`cat` Afficher le contenu d’un fichier                  
`less` Lecture paginée d’un fichier                       
`wc` Compter lignes, mots, caractères                    
`echo`  Afficher du texte ou une variable                 
`head`  Afficher le début d’un fichier                     
`tail`  Afficher la fin d’un fichier                       
`mkdir` Créer un répertoire                                 
`cp` Copier fichiers ou répertoires                      
`mv` Déplacer ou renommer                               
`rm` Supprimer un fichier                                
`rmdir` Supprimer un répertoire vide                      
`file`  Obtenir des informations sur un fichier             
`man`   Consulter le manuel d’une commande                 
`touch` Créer un fichier vide ou mettre à jour le timestamp
`zip/unzip` Compresser/décompresser un fichier zip             
`tar`   Manipuler les archives tar                          
 `cut`  Extraire une ou plusieurs colonnes  

 Ensuite, il est important de différencier les chemins absolus et relatifs.

 

# Séance 2 
Lors de cette séance, nous avons appris à utiliser GitHub, ce qui m’a été très difficile à comprendre au début. Je ne comprenais pas vraiment comment cela fonctionnait, en particulier certaines commandes de Git, comme git add, git commit et git push. Ces concepts me semblaient très abstraits. Cependant, après avoir relu attentivement les diapos et consulté des ressources en ligne après le cours, j’ai l’impression de mieux comprendre. En effet, pendant le cours, nous suivions les instructions du professeur étape par étape, sans réfléchir vraiment à l’utilité de chaque action. Il est donc nécessaire de pratiquer davantage après le cours pour bien maîtriser le processus.
Lorsque je faisais les devoirs après le cours, comme je devais classer les fichiers, créer des tags et les uploader sur GitHub, j’ai finalement utilisé les commandes suivantes :
```bash
git clone git@github.com:yinbozhao-spec/PPE1-2025.git
clean
clear
cd ~/desktop/TAL/Plurital
git clone git@github.com:yinbozhao-spec/PPE1-2025.git
cd PPE-2025/
cd ./PPE-2025/
cd PPE1-2025
git status
git log
git status
git tag -a gitinto -m "version finie intro git"\n
git tag
git push origin gitinto
```
Dans ce processus, je faisais des erreurs très inattentives, par exemple je tapais mal un mot très simple comme `clear`, que je mettais souvent `clean`. C’est en faisant constamment des erreurs que j’ai progressivement compris et exploré l’ensemble du processus :
```bash
- git status
- git add .
- git commit
- git push origin main
- git tag "nom de tag"
- git push origin "nom de tag"
```




# Séance 3
Cette fois, le cours a été plus difficile pour moi, principalement à cause du contenu suivant :
```bash
(base) zhaoyinbo@Einstein 2016 % echo "Nombre de lieu en 2016:" >>../output1.txt
# Écrit cette ligne dans le fichier output1.txt.

(base) zhaoyinbo@Einstein 2016 % cat 2016*.ann | grep Location | wc -l >>../output1.txt
# Ajoute le nombre de "Location" de l'année 2016 dans output1.txt.

(base) zhaoyinbo@Einstein 2016 % echo "Nombre de lieu en 2017:" >>../output1.txt
# Répète la même opération pour 2017.

(base) zhaoyinbo@Einstein 2016 % cd ../2017
# Change de dossier pour passer à l'année 2017.

(base) zhaoyinbo@Einstein 2017 % cat 2017*.ann | grep Location | wc -l >>../output1.txt
# Ajoute le nombre de "Location" de 2017 dans output1.txt.

(base) zhaoyinbo@Einstein ann % cd ../2018
(base) zhaoyinbo@Einstein 2018 % echo "Nombre de lieu en 2018:" >>../output1.txt
# Répète les étapes pour 2018.

(base) zhaoyinbo@Einstein 2018 % cat 2018*.ann | grep Location | wc -l >>../output1.txt

(base) zhaoyinbo@Einstein 2018 % cat ../output1.txt
Nombre de lieu en 2016:
    3144
Nombre de lieu en 2017:
    2466
Nombre de lieu en 2018:
    3110
# Affiche le contenu du fichier output1.txt
```

# Séance 4
Le devoir de ce cours consiste à expliquer le code suivant :
```bash
#!/usr/bin/bash

# Vérifie si un argument a été passé au script
# $# représente le nombre d'arguments. 
# Si le nombre d'arguments n'est pas égal à 1, un message est affiché et le script s'arrête.
if [ $# -ne 1 ]; then
  echo "ce programme demande un argument"
  exit
fi

# On assigne le premier argument à la variable FICHIER_URLS
FICHIER_URLS=$1

# Initialisation des compteurs
OK=0
NOK=0

# Boucle WHILE : lit chaque ligne du fichier FICHIER_URLS
# -r empêche read d'interpréter les caractères d'échappement comme "\"
while read -r LINE; do
  echo "la ligne : $LINE"
  
  # Vérifie si la ligne correspond à une URL valide (http:// ou https://)
  # =~ est l'opérateur de correspondance avec expression régulière en Bash
  if [[ $LINE =~ ^https?:// ]]; then
    echo "ressemble à une URL valide"
    OK=$(expr $OK + 1)    # Incrémente le compteur OK
  else
    echo "ne ressemble pas à une URL valide"
    NOK=$(expr $NOK + 1)  # Incrémente le compteur NOK
  fi
done < $FICHIER_URLS  # Redirection : le contenu du fichier FICHIER_URLS est utilisé comme entrée de la boucle

# Affiche le total d'URLs valides et de lignes douteuses
echo "$OK URLs et $NOK lignes douteuses"
```

#  Séance 5
Le script pour miniporjet - l'exercice 1 :
```bash
#!/bin/bash

# Vérifier qu'un argument a été passé
if [ $# -eq 0 ]; then
    echo "Erreur : vous devez fournir un fichier en argument."
    exit 1
fi

FICHIER=$1

# Vérifier que le fichier existe
if [ ! -f "$FICHIER" ]; then
    echo "Erreur : le fichier '$FICHIER' n'existe pas."
    exit 1
fi

# Lire le fichier ligne par ligne
NUMERO=1
while read -r line; do
    # Afficher le numéro de ligne et l'URL, séparés par une tabulation
    echo -e "${NUMERO}\t${line}"
    NUMERO=$((NUMERO + 1))
done < "$FICHIER"
```

L'exercice 2 est plus compliqué.
Après l’exercice 1 fait, on va rajouter des informations à chaque ligne, toujours séparées par des tabulations :
1. le code HTTP de réponse à la requête
  1.1 les erreurs peuvent être corrigées
2. l’encodage de la page, s’il est présent
3. le nombre de mots dans la page
   
```bash
#!/bin/bash

# Vérification des arguments
# Si aucun argument n’est fourni, on affiche un message d’usage et on arrête le script
if [ $# -eq 0 ]; then
    echo "Usage: $0 fichier_url"
    exit 1
fi

# Définition des fichiers
# $1 = premier argument du script = fichier d’URLs
input_file="$1"
# Fichier de sortie
output_file="tableau-fr.tsv"

# Création de l’entête du fichier de sortie
echo -e "Line\tURL\tHTTP_Code\tEncoding\tWord_Count\tStatus" > "$output_file"

# Initialisation du compteur de lignes
lineno=1

# Lecture ligne par ligne du fichier d’URLs
while read -r url; do

    # Vérification du format de l’URL
    # Si ce n’est pas une URL valide (ne commence pas par http:// ou https://), on écrit INVALID_URL
    if [[ ! "$url" =~ ^https?:// ]]; then
        echo -e "${lineno}\t${url}\tN/A\tN/A\t0\tINVALID_URL" >> "$output_file"
        ((lineno++))
        continue
    fi

    # Récupération du code HTTP sans télécharger la page
    code=$(curl -o /dev/null -s -w "%{http_code}" -L "$url")

    # Gestion du code 429 (trop de requêtes)
    if [ "$code" -eq 429 ]; then
        sleep 2
        code=$(curl -o /dev/null -s -w "%{http_code}" -L "$url")
    fi

    # Si le code HTTP n’est pas 200, on écrit ERROR et des valeurs par défaut
    if [ "$code" -ne 200 ]; then
        encoding="N/A"
        words=0
        echo -e "${lineno}\t${url}\t${code}\t${encoding}\t${words}\tERROR" >> "$output_file"
        lineno=$((lineno+1))
        continue
    fi

    # Récupération de l’encodage de la page à partir des en-têtes HTTP
    encoding=$(curl -sI -L "$url" | grep -i "Content-Type" | awk -F'charset=' '{print $2}')
    if [ -z "$encoding" ]; then
        encoding="N/A"
    fi

    # Comptage du nombre de mots dans la page
    words=$(curl -s -L "$url" | wc -w)

    # Écriture des résultats dans le fichier de sortie avec tabulations
    echo -e "${lineno}\t${url}\t${code}\t${encoding}\t${words}\tOK" >> "$output_file"

    # Incrémentation du numéro de ligne
        lineno=$((lineno+1))
    # Pause d’1 seconde pour ne pas surcharger le serveur
    sleep 1
done < "$input_file"

echo "Finished. Results saved to $output_file"
```




