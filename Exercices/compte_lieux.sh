ANNEE=$1
MOIS=$2
TOPN=$3
cat ./${ANNEE}_${MOIS}*.ann | grep Location | cut -f3 | sort | uniq -c | sort -n | tail -n $TOPN
