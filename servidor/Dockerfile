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
    at \
    tar \
    && dnf clean all

# Configuramos rsyslog para que escuche los mensajes locales en Docker
RUN echo 'module(load="imuxsock")' > /etc/rsyslog.conf && \
    echo '*.* /var/log/messages' >> /etc/rsyslog.conf

# Copiamos el script de creación de usuarios que está en la carpeta de scripts
# Nota: La ruta es relativa al contexto que definimos en docker-compose
COPY ./scripts/setup_usuarios.sh /usr/local/bin/setup_usuarios.sh

# Copiamos y damos permisos al script de automatización
COPY ./scripts/automatizacion.sh /usr/local/bin/automatizacion.sh
RUN chmod +x /usr/local/bin/automatizacion.sh

# Configuramos cron para el respaldo automático
RUN echo "0 3 * * * root /usr/local/bin/automatizacion.sh" > /etc/cron.d/tarea_respaldo
RUN chmod 0644 /etc/cron.d/tarea_respaldo

# Damos permisos de ejecución y corremos el script para que los usuarios
# existan desde que el contenedor nace [cite: 25]
RUN chmod +x /usr/local/bin/setup_usuarios.sh && \
    /usr/local/bin/setup_usuarios.sh

# Exponemos el puerto 22 por si deciden configurar SSH más adelante
EXPOSE 22

# El comando principal iniciará rsyslog para los logs y mantendrá una terminal abierta
CMD rsyslogd && crond && /bin/bash
