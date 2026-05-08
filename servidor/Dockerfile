# Usamos la imagen oficial de Fedora como base
FROM fedora:latest

# Actualizamos el sistema e instalamos todas las herramientas requeridas por la rúbrica
# Se incluye 'nano' porque vimos que no viene por defecto
# Se incluye 'cronie' para tareas programadas (cron) [cite: 38]
# Se incluye 'rsyslog' para la gestión de bitácoras/logs 
# Se incluye 'quota' para la administración de espacio en disco [cite: 35]
RUN dnf update -y && dnf install -y \
    sudo \
    nano \
    passwd \
    cracklib \
    cronie \
    rsyslog \
    quota \
    iputils \
    net-tools \
    && dnf clean all

# Copiamos el script de creación de usuarios que está en la carpeta de scripts
# Nota: La ruta es relativa al contexto que definimos en docker-compose
COPY ./scripts/setup_usuarios.sh /usr/local/bin/setup_usuarios.sh

# Damos permisos de ejecución y corremos el script para que los usuarios
# existan desde que el contenedor nace [cite: 25]
RUN chmod +x /usr/local/bin/setup_usuarios.sh && \
    /usr/local/bin/setup_usuarios.sh

# Exponemos el puerto 22 por si deciden configurar SSH más adelante
EXPOSE 22

# El comando principal iniciará rsyslog para los logs y mantendrá una terminal abierta
CMD rsyslogd && crond && /bin/bash
