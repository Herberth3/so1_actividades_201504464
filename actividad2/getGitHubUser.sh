#!/bin/bash

# Leer la variable GITHUB_USER desde la variable de entorno GITHUB_USER_ENV
GITHUB_USER="$GITHUB_USER_ENV"

# Verifica que la variable de entorno exista

if [ -z "$GITHUB_USER" ]; then
	echo "La variable de entorno GITHUB_USER_ENV no esta definida."
	exit 1
fi

# Consultar la URL del webservice y guardar la respuesta en una variable
JSON_RESPONSE=$(curl -s "https://api.github.com/users/${GITHUB_USER}")

# Extraer los datos del JSON
github_user=$(echo "$JSON_RESPONSE" | jq -r '.login')
user_id=$(echo "$JSON_RESPONSE" | jq -r '.id')
created_at=$(echo "$JSON_RESPONSE" | jq -r '.created_at')

# Imprimir el mensaje con los datos del usuario
echo "Hola $github_user. User ID: $user_id. Cuenta fue creada el: $created_at."

# Crear el directorio para el log con la fecha actual
log_dir="/tmp/$(date +'%Y%m%d')"
mkdir -p "$log_dir"

# Crear el archivo de log con el mensaje
log_file="$log_dir/saludos.log"
echo "Hola $github_user. User ID: $user_id. Cuenta fue creada el: $created_at." > "$log_file"

echo "Se ha generado el archivo de log en: $log_file"

