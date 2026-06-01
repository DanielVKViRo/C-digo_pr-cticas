#!/bin/bash

for genero in $(cat generos_zotus.txt)
 do
 if ! grep -q $genero generos_BBDD.txt; then
  echo $genero
 fi
 done > generos_definitivos.txt
