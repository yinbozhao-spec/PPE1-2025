# Journal de bord du projet encadré
# PPE1-2025

## Séance 1 
### Les couches d'un ordinateur 
Les couches d’un ordinateur : hardware, kernel, shell, utilities.
### Le système de fichiers – Les chemin 
/ désigne la racine de l’arbre 
∼/ désigne le dossier personnel de l’utilisateur ( “HOME") 
./ désigne le dossier courant (working directory) 
../ désigne le dossier parent
#### Chemin absolu et chemin relatif
/home/pierre/PPE1 désigne un chemin **absolu** (indique la position d’un fichier en partant de la racine)
**../../dev/input/mouse3** désigne un chemin **relatif** (indique la position d’un fichier en partant du dossier courant)
Au début, c'était difficile de comprendre la différence entre le chemin absolu et le chemin relatif. Mais les deux exemples m'aident à la comprendre enfin.
#### Jokers
? peut remplacer n’importe quel caractère (unique) 
* peut remplacer n’importe quelle suite de caractères
### Github
Fichiers : les fichiers sont dans un dossier.
### Les commandes
#### Se promener dans l’arbre
pwd print working directory
ls lister le contenu d’un dossier
cd change directory
#### Copier, déplacer, supprimer ou créer des fichiers
cp copier
mv move déplacer
rm remove supprimer
mkdir make directory créer un dossier
touch crée un fichier (effet de bord bien pratique)
zip compresser une archive zip
unzip décompresser une archive zip
tar manipuler les archives tar
#### Voir et manipuler le contenu des fichiers
file donne des informations sur le type de fichier
cat lit le contenu d’un ou plusieurs fichiers
head lit le début d’un fichier
tail lit la fin d’un fichier
cut sélectionne une ou plusieurs colonnes dans un fichier tabulé
less lecteur (interactif)

Et surtout: man
La plupart des commandes ont aussi une option --help qui permet d’obtenir une description concise du fonctionnement et des option de la
commande

## Travail du 6 octobre 2025 
**Créer le dépôt dupuis Github**
**Code**
```bash
- 388  git clone git@github.com:yinbozhao-spec/PPE1-2025.git
- 389  clean
- 390  clear
- 391  cd ~/desktop/TAL/Plurital
- 392  git clone git@github.com:yinbozhao-spec/PPE1-2025.git
- 393  cd PPE-2025/
- 394  cd ./PPE-2025/
- 395  cd PPE1-2025
- 396  git status
- 397  git log
- 398  q
- 399  history
- 400  git status
- 401  git tag -a gitinto -m "version finie intro git"\n
- 402  git tag
- 403  git push origin gitinto
```

**Difficultés et résolutions**
- Avant de faire ces exercices, j'ai bien révisé les diapos et refait l'arborescence que nous avons corrigée lors du dernier cours. Grâce à cette révision, je retiens les notions déjà vues, par exemple :
  - `/` : la racine de l'arbre
  - `~/` : le dossier personnel de l'utilisateur
  - `./` : le dossier courant
  - `../` : le dossier parent
    
- Ensuite, je sais maintenant la différence entre un chemin absolu et un chemin relatif. De plus, certaines commandes sont très utiles, comme : `cd`, `ls`, `mkdir`, `mv`, `rm`.
  
- Enfin, quand j'ai commencé les exercices, j'ai mal tapé `clear` pour effacer les anciens codes. Ensuite, j'ai trouvé que je connais pas très bien les commandes comme "git status, git log, git tag et git bush". 
  
- Cependant, pour le moment, je ne connais pas bien Markdown, parce que c'est la première fois que j'utilise.



# Séance 4
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

