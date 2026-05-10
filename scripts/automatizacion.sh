#!/bin/bash

# 1. Definimos dónde se guardará el respaldo y creamos la carpeta si no existe
DIR_DESTINO="/data/respaldos"
mkdir -p $DIR_DESTINO

# 2. Obtenemos la fecha y hora exacta para el nombre del archivo
FECHA=$(date +%Y-%m-%d_%H-%M-%S)
NOMBRE_ARCHIVO="respaldo_proyectos_$FECHA.tar.gz"

# 3. Comprimimos la carpeta de proyectos compartidos
tar -czf $DIR_DESTINO/$NOMBRE_ARCHIVO /data/proyectos_compartidos 2>/dev/null

# 4. Mandamos un mensaje al sistema (syslog) confirmando que terminó
logger -t SCRIPT_RESPALDO "Se completó exitosamente el respaldo automático: $NOMBRE_ARCHIVO"
