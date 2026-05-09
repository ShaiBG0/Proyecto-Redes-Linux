#!/bin/bash

# 1. Se crean los grupos
echo "Creando grupos"
groupadd admin_redes
groupadd auditores

# 2. Se crean los usuarios y se les asigna a grupos
echo "Creando usuarios"
useradd -m -G admin_redes -s /bin/bash admin1
useradd -m -G admin_redes -s /bin/bash admin2
useradd -m -G auditores -s /bin/bash auditor_visitante

# 3. Politicas de acceso y seguridad en directorios
echo "Configurando permisos de seguridad"
mkdir -p /data/proyectos_compartidos
chown root:admin_redes /data/proyectos_compartidos
chmod 770 /data/proyectos_compartidos

echo "Estructura de usuarios y carpetas completada."
echo "IMPORTANTE: Las contraseñas deben ser asignadas manualmente por el administrador."
