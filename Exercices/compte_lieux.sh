ANNEE=$1
MOIS=$2
N=$3
CHEMIN=/Users/zhaoyinbo/desktop/TAL/Exercice1/ann/$1
cat $CHEMIN/${ANNEE}_${MOIS}_*.ann | grep "^T[0-9]*[[:space:]]Location" | cut -f3 | sort | uniq -c | sort -nr | head -n $N
