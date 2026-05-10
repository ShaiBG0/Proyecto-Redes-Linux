#!/bin/bash

# Script de snapshot del contenedor servidor
# Se ejecuta desde el HOST (no desde dentro del contenedor)

FECHA=$(date +%Y-%m-%d_%H-%M-%S)
DIR_SNAPSHOTS="./snapshots"
NOMBRE="snapshot_servidor_$FECHA.tar"

mkdir -p $DIR_SNAPSHOTS

echo "Generando snapshot del contenedor linux_servidor..."
docker export linux_servidor -o $DIR_SNAPSHOTS/$NOMBRE

echo "Snapshot guardado en: $DIR_SNAPSHOTS/$NOMBRE"
echo "Para restaurarlo: docker import $DIR_SNAPSHOTS/$NOMBRE servidor_restaurado:latest"
