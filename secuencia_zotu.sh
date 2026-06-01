#!/bin/bash

# Con este script queremos obtener las secuencias de los zotus cuya taxonomía queremos conocer. Lo que vamos a hacer es tomar aquellos zotus que cumplan
# que su frecuencia sea mayor al 0.001, su frecuencia sea mayor al 0.0005 y su número de muestras menor a 450 y su frecuencia sea mayor al 0.00025 y
# su número de muestras menor a 225.

# Inicializamos el valor de las muestras y las frecuencias
muestras=899
frecuencias=0.001

# iteramos para cada frecuencia y número de muestras deseadas 
for num in $(seq 1 4)
 do
 muestras=$(echo $muestras/$num | bc -l)
 frecuencias=$(echo $frecuencias/$num | bc -l)
 for seq in $(awk -v id1=$muestras -v id2=$frecuencias '$2 < id1 && $4>id2' Core_otus/16S/core_otus.tsv | cut -f1 | tail -n +2)
  do
  # Introducimos el identificador del zotu.
  echo ">$seq"
  # Sacamos la secuencia del zotu correspondiente.
  awk -v id=">$seq" '$0 == id {f=1; next} /^>/ {f=0} f' Core_otus/16S/zotus.fa 

  done
 done > Intermedio.fa

# El archivo anterior posee secuencias repetidas. Para eliminarlas, hacemos algo similar a lo anterior pero asegurándonos que no se repiten zotus.
for seq in $(grep '>' Intermedio.fa | sort | uniq)
 do
 echo $seq
 awk -v id="$seq" '$0 == id {f=1; next} /^>/ {f=0} f' Intermedio.fa
 done > secuencias.fa

rm Intermedio.fa
