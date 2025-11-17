#!/usr/bin/env bash

if [ $# -ne 1 ]
then
	echo "Le script attend exactement un argument"
	exit 1
fi

fichier_urls=$1

echo "
<html lang='fr'>
<head>
  <meta charset='UTF-8'/>
  <title>Tableau</title>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/versions/bulma-no-dark-mode.min.css'>
</head>
<body>
  <section class='section has-background-grey'>
    <div class='table-container has-background-white'>
     <div class='hero has-text-centered'>
      <div class='hero-body'>
       <h1 class='title'>Tableau</h1>
      </div>
     </div>

     <table class='table is-bordered is-striped is-narrow is-hoverable is-fullwidth'>
      <thead>
       <tr class='is-selected'>
        <th>Numéro</th>
        <th>URL</th>
        <th>Code</th>
        <th>Encodage</th>
        <th>Nombre de mots</th>
       </tr>
      </thead>
      <tbody>" > tableaux/tableau-fr.html

lineno=1
while read -r line
do
	data=$(curl -s -i -L -w "%{http_code}\n%{content_type}" -o ./.data.tmp "$line")
	http_code=$(echo "$data" | head -1)
	encoding=$(echo "$data" | tail -1 | sed -n 's/.*charset=\([^ ]*\).*/\1/p')

	if [ -z "${encoding}" ]
	then
		encoding="N/A"
	fi

	nbmots=$(cat ./.data.tmp | lynx -dump -nolist -stdin | wc -w)

	echo -e "
    <tr>
     <td>$lineno</td>
     <td>$line</td>
     <td>$http_code</td>
     <td>$encoding</td>
     <td>$nbmots</td>
    </tr>" >> tableaux/tableau-fr.html

	lineno=$(expr $lineno + 1)
done < "$fichier_urls"

echo "
      </tbody>
     </table>
	</div>
  </section>
</body>
</html>" >> tableaux/tableau-fr.html


rm ./.data.tmp


echo "
<html lang='fr'>
<head>
 <meta charset='UTF-8'/>
  <title>Tableau</title>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/versions/bulma-no-dark-mode.min.css'>
</head>
<body>
 <section class='section has-background-grey'>
  <div class='container has-background-white'>
   <div class='hero has-text-centered'>
    <div class='hero-body'>
     <h1 class='title'>Miniprojet</h1>
    </div>
   </div>

   <div class='block'>
    Le projet vise à étudier l'usage d'un mot à travers différentes langues et de les comparer.
   </div>

   <div class='block'>
    <ol style='margin-left: 1em;'>
     <li>Choisir un mot en trois langues</li>
     <li>Chacun étudie l'usage de ce mot dans une langue sur le web</li>
     <li>Constituer un corpus multilingue</li>
     <li>Nettoyer le corpus et l'analyser</li>
    </ol>
   </div>

   <div class='block'>
   Voici le lien vers le tableau de résultats,<a href='https://github.com/yinbozhao-spec/PPE1-2025/blob/main/miniprojet/tableaux/tableau-fr.html' target='_blank'>cliquez ici</a>
  </div>
  </div>
 </section>
</body>
</html>
" > ../index.html

