#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 fichier_url"
    exit 1
fi

input_file="$1"
output_file="tableau-fr.tsv"

echo -e "Line\tURL\tHTTP_Code\tEncoding\tWord_Count\tStatus" > "$output_file"

lineno=1

while read -r url; do

    if [[ ! "$url" =~ ^https?:// ]]; then
        echo -e "${lineno}\t${url}\tN/A\tN/A\t0\tINVALID_URL" >> "$output_file"
        lineno=$((lineno+1))
        continue
    fi

    code=$(curl -o /dev/null -s -w "%{http_code}" -L "$url")

    if [ "$code" -eq 429 ]; then
        sleep 2
        code=$(curl -o /dev/null -s -w "%{http_code}" -L "$url")
    fi

    if [ "$code" -ne 200 ]; then
        encoding="N/A"
        words=0
        echo -e "${lineno}\t${url}\t${code}\t${encoding}\t${words}\tERROR" >> "$output_file"
        lineno=$((lineno+1))
        continue
    fi

    encoding=$(curl -sI -L "$url" | grep -i "Content-Type" | awk -F'charset=' '{print $2}')
    if [ -z "$encoding" ]; then
        encoding="N/A"
    fi

    words=$(curl -s -L "$url" | wc -w)

    echo -e "${lineno}\t${url}\t${code}\t${encoding}\t${words}\tOK" >> "$output_file"

        lineno=$((lineno+1))
    sleep 1
done < "$input_file"

echo "Finished. Results saved to $output_file"

