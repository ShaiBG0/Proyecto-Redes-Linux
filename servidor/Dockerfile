FROM fedora:latest

#aqui se actuliza el sitema y se instala todo lo necesario
RUN dnf update -y && dnf install -y \
    sudo \
    nano \
    procps-ng \
    passwd \
    cracklib \
    cronie \
    rsyslog \
    quota \
    e2fsprogs \
    util-linux \
    iputils \
    net-tools \
    at \
    tar \
    && dnf clean all

# Configuramos rsyslog para los logs del sistema
RUN echo 'module(load="imuxsock")' > /etc/rsyslog.conf && \
    echo '*.* /var/log/messages' >> /etc/rsyslog.conf

# Copiamos los scripts a la ruta bin del sistema
COPY ./scripts/setup_usuarios.sh /usr/local/bin/setup_usuarios.sh
COPY ./scripts/automatizacion.sh /usr/local/bin/automatizacion.sh

# Damos permisos de ejecución
RUN chmod +x /usr/local/bin/setup_usuarios.sh
RUN chmod +x /usr/local/bin/automatizacion.sh

# Configuramos cron para el respaldo automático (3 AM)
RUN echo "0 3 * * * root /usr/local/bin/automatizacion.sh" > /etc/cron.d/tarea_respaldo
RUN chmod 0644 /etc/cron.d/tarea_respaldo

# Exponemos puertos necesarios
EXPOSE 22

# El comando principal inicia los servicios y nos deja una terminal
# Importante: No ejecutamos setup_usuarios.sh aquí porque necesita que /data esté montado
CMD rsyslogd && crond && /bin/bash
