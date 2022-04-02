### apache y crontab sera de utilidad para el mismo
*archivo monitor_linux.sh*

Configurar tarea con cron

Acceder como usuario root

crontab -u root -e

Añadimos la tarea */5 * * * * sudo /opt/monitorlinux.sh 2>&1 | logger -t monitortag

Se ejecutará cada 5 minutos e imprimirá los logs en syslog con la etiqueta monitortag.
Para dar seguimiento a los logs generados por la tarea, utilizamos el comando:

grep monitortag /var/log/syslog
