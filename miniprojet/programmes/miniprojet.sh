if [ $# -ne 2 ]
then
	echo "Le script attend un argument : le chemin vers le fichier d'URL et le chemin vers le fichier de sortie"
	exit
fi

FICHIER_URL=$1
FICHIER_SORTIE=$2

lineno=1
while read -r line;
do
    data=$(curl -I -L -w "%{http_code}\t%{content_type}" -o /dev/null -s "${line}")

    http_code=$(echo "$data" | cut -f1)
    content_type=$(echo "$data" | cut -f2)

    encodage=$(echo "$content_type" | grep -E -o "charset=[^;]*" | cut -d= -f2)

    word_count=$(curl -s -L "$line" | lynx -dump -stdin -nolist | wc -w)

    echo -e "${lineno}\t${line}\t${http_code}\t${encodage}\t${word_count}"
    lineno=$(expr $lineno + 1 )
done < "$FICHIER_URL" > "$FICHIER_SORTIE"
