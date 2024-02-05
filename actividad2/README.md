### Comandos necesarios para Ejecutar getGitHubUser.sh en Ubuntu

1. Instalar el comando jq, ya que se necesita para procesar el JSON. Puedes instalarlo en sistemas basados en Debian/Ubuntu con:

   ```bash
   sudo apt-get install jq

2. Instalar el comando curl, este es una herramienta que permite realizar solicitudes HTTP desde la línea de comandos, y es utilizado en el script para consultar el webservice de GitHub. Puedes instalarlo con:

   ```bash
   sudo apt-get install curl

### Crear un Cronjob para Ejecutar getGitHubUser.sh cada 5 minutos en Ubuntu

1. Abre un terminal en tu sistema Ubuntu.
2. Asegúrate de que el script.sh  tenga permisos de ejecución. Si no los tiene, puedes darle permisos utilizando el siguiente comando (reemplaza '/ruta/a/tu_script.sh' con la ubicación  real de tu script):

   ```bash
   chmod +x /ruta/a/tu_script.sh

3. Escribe el siguiente comando para abrir el archivo crontab en modo edición:

   ```bash
   crontab -e

4. Si es la primera vez que abres crontab, se te pedirá que elijas el editor de texto para abrirlo.
5. Añade una nueva linea al archivo crontab con la siguiente sintaxis:

   ```javascript
   */5 * * * * /ruta/a/tu_script.sh

6. La sintaxis anterior indica que el script se ejecutará cada 5 minutos. Los campos significan lo siguiente:
   - `*/5`: Indica que el script se debe ejecutar cada 5 minutos.
   - `*` (en los otros campos): Significa que el cronjob se ejecutará en cualquier valor válido para ese campo (cualquier hora, cualquier día del mes, cualquier día de la semana, etc.).

7. Una vez que hayas agregado la línea al archivo crontab y guardado los cambios, el cronjob comenzará a ejecutarse cada 5 minutos en tu sistema Ubuntu.
