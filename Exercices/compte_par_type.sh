#!/bin/bash
ANNEE=$1
TYPE=$2
CHEMIN=$3
cat "$CHEMIN/$ANNEE/"* | grep -w "$TYPE" | wc -l
