#! /bin/bash



#Declación de variables
WEB_DIR=/var/www/html
os_name=`uname -v | awk {'print$1'} | cut -f2 -d'-'`
upt=`uptime`
ip_add=`ip -4 addr show wlp2s0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'`
os_version=`cat /etc/issue`


#Crea el directorio, si no existe. 
if [ ! -d $WEB_DIR/reportes ]
then
  mkdir $WEB_DIR/reportes
fi

rm -Rf $WEB_DIR/reportes/Reporte-Servidor.html
html="$WEB_DIR/reportes/Reporte-Servidor.html"
	
echo "Generando reporte"
#Generating HTML file
echo "<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">" >> $html
echo "<html>" >> $html
echo "<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>" >> $html

echo "<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">" >> $html

echo "<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>" >> $html
echo "<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>">> $html
echo "<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>" >> $html
echo "<body>" >> $html
echo "<fieldset>" >> $html
echo "<center>" >> $html
echo "<h2>Reporte de Servidor Linux" >> $html
#echo "<h3> desaarollado 
echo "</center>" >> $html
echo "</fieldset>" >> $html
echo "<br>" >> $html
echo "<center>" >> $html
echo "<h2>Detalles Sistema Operativo : </h2>" >> $html
echo "<table class="table">" >> $html
echo "<thead class='thead-dark'>" >> $html
echo "<tr>" >> $html
echo "<th>Nombre S.O</th>" >> $html
echo "<th>Versión O.S</th>" >> $html
echo "<th>Dirección IP</th>" >> $html
echo "<th>Tiempo ejecución</th>" >> $html
echo "</tr>" >> $html
echo "</thead>" >> $html
echo "<tbody>" >> $html
echo "<tr>" >> $html
echo "<td>$os_name</td>" >> $html
echo "<td>$os_version</td>" >> $html
echo "<td>$ip_add</td>" >> $html
echo "<td>$upt</td>" >> $html
echo "</tr>" >> $html

echo "</tbody>" >> $html
echo "</table>" >> $html
echo "<h2>Utilización de recursos : </h2>" >> $html
echo "<br>" >> $html

#Genera tabla con información de archivos de sistema de Linux
HOST=$(hostname)
echo "Uso de sistema de archivos para HOST: <strong>$HOST</strong><br>
Última actualización: <strong>$(date)</strong><br><br>
<table class='table' border='1'>
<thead class='thead-dark'>
<tr>
<th >Sistema de archivos</th>
<th >Tamaño</th>
<th >Uso %</th>
</tr>
</thead>" >> $html

# Lee la salida del comando linea por linea
while read line; do
echo "<tr><td align='center'>" >> $html
echo $line | awk '{print $1}' >> $html
echo "</td><td align='center'>" >> $html
echo $line | awk '{print $2}' >> $html
echo "</td><td align='center'>" >> $html
echo $line | awk '{print $5}' >> $html
echo "</td></tr>" >> $html
done < <( df -h | grep -vi filesystem)
echo "</table>" >> $html

echo "</body>" >> $html
echo "</html>" >> $html
