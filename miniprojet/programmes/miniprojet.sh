if [ $# -ne 2 ]; then
    echo "Le script attend deux arguments : fichier URL et fichier HTML de sortie"
    exit
fi

FICHIER_URL=$1
FICHIER_SORTIE_HTML=$2

echo "<table border='1'><tr><th>lineno</th><th>URL</th><th>HTTP_Code</th><th>Encodage</th><th>Word_count</th></tr>" > "$FICHIER_SORTIE_HTML"

lineno=1
while read -r line; do
    data=$(curl -I -L -w "%{http_code}\t%{content_type}" -o /dev/null -s "${line}")
    http_code=$(echo "$data" | cut -f1)
    content_type=$(echo "$data" | cut -f2)
    encodage=$(echo "$content_type" | grep -E -o "charset=[^;]*" | cut -d= -f2)
    word_count=$(curl -s -L "$line" | lynx -dump -stdin -nolist | wc -w)

    echo "<tr><td>$lineno</td><td>$line</td><td>$http_code</td><td>$encodage</td><td>$word_count</td></tr>" >> "$FICHIER_SORTIE_HTML"
    lineno=$((lineno+1))
done < "$FICHIER_URL"

echo "</table>" >> "$FICHIER_SORTIE_HTML"

