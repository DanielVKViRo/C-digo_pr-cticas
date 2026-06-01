#!/bin/bash

for seq in $(cut -f1 resultados_16S_filtro94.tsv | sort | uniq)
 do
 echo ${seq}
 grep -w $seq resultados_16S_filtro94.tsv | cut -f3,9
 done > tabla_especie.txt

awk '{split($2,a," "); print $1, a[1]}' tabla_especie.txt > tabla_genero.txt

rm tabla_especie.txt
