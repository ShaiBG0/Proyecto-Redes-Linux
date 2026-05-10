#!/bin/bash

# aqui se crean los grupos
groupadd -f admin_redes
groupadd -f auditores

# Creacion de usuarios solo si no existen, se hizo mas seguro a comparacion de la primera version
id admin1 &>/dev/null || useradd -m -G admin_redes -s /bin/bash admin1
id admin2 &>/dev/null || useradd -m -G admin_redes -s /bin/bash admin2
id auditor_visitante &>/dev/null || useradd -m -G auditores -s /bin/bash auditor_visitante

# agregamos politicas de acceso
mkdir -p /data/proyectos_compartidos
chown root:admin_redes /data/proyectos_compartidos
chmod 770 /data/proyectos_compartidos

# Mejora: se automatiza la creacion de cuotas, antes se hacia a mano

if [ ! -f /data/quotalimits.img ]; then
    dd if=/dev/zero of=/data/quotalimits.img bs=1M count=50
    mkfs.ext4 -F /data/quotalimits.img
fi

mkdir -p /mnt/almacen_auditores
[ -e /dev/loop0 ] || mknod /dev/loop0 b 7 0
mountpoint -q /mnt/almacen_auditores || mount -o loop,usrquota /data/quotalimits.img /mnt/almacen_auditores

tune2fs -O quota /data/quotalimits.img &>/dev/null
quotaon -bu /mnt/almacen_auditores 2>/dev/null || true
setquota -u auditor_visitante 10240 12288 0 0 /mnt/almacen_auditores

# Crear archivo para evidencia
touch /mnt/almacen_auditores/archivo_control.txt
chown auditor_visitante /mnt/almacen_auditores/archivo_control.txt
