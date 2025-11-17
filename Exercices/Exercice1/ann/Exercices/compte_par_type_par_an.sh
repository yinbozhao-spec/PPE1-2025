#!/bin/bash
TYPE=$1
CHEMIN=/Users/zhaoyinbo/Desktop/TAL/Exercice1/ann
echo "2016 : $(./compte_par_type.sh 2016 $TYPE $CHEMIN)"
echo "2017 : $(./compte_par_type.sh 2017 $TYPE $CHEMIN)"
echo "2018 : $(./compte_par_type.sh 2018 $TYPE $CHEMIN)"
