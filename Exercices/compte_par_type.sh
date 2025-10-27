#!/bin/bash
ANNEE=$1
TYPE=$2
cat $ANNEE/* | grep "$TYPE" | wc -l
