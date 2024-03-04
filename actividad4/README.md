### Chat básico (únicamente dos participantes) utilizando Named Pipes y bash en Linux, sistemas basados en Debian/Ubuntu 

Este proyecto implementa un chat básico entre dos participantes utilizando Named Pipes (FIFOs) en Bash. Los Named Pipes, `pipe_in` y `pipe_out`, actúan como canales de comunicación unidireccionales entre los scripts `listen.sh` y `send.sh`.

## Creación de Named Pipes

Antes de iniciar los scripts, se crean dos Named Pipes para la entrada y salida de datos:

  ```bash
  mkfifo pipe_in
  mkfifo pipe_out
  ```

## Creación de archivos ejecutables
1. listen.sh
Este script está diseñado para escuchar mensajes del amigo y mostrarlos en la pantalla. La ejecución permanece en un bucle infinito, esperando a que lleguen mensajes a través de pipe_in. Si se recibe el mensaje "exit", el script informa que el chat ha finalizado y sale del bucle.

   ```bash
   #!/bin/bash
    while true
    do
        if read line < pipe_in
        then
            if [[ "$line" == "exit" ]]; then
                echo "Chat finalizado."
                exit 0
            fi
            echo "Amigo: $line"
        fi
    done
   ```

2. send.sh
Este script permite al usuario ingresar mensajes y los envía al amigo a través de pipe_in. Si el mensaje ingresado es "exit", se informa que el chat ha finalizado y el script se cierra.

    ```bash
     #!/bin/bash
    while true
    do
        read -p "Tú: " message
        if [[ "$message" == "exit" ]]; then
            echo "$message" > pipe_in
            echo "Chat finalizado."
            exit 0
        fi
        echo "$message" > pipe_in
    done
    ```

### Permiso de Ejecucion

1. Debes darle permiso de ejecucion a los archivos send.sh y listen.sh

   ```bash
   chmod +x listen.sh send.sh
   ```

### Funcionamiento

1. Ejecución de los Scripts: Ambos scripts pueden ejecutarse simultáneamente desde terminales separadas, estableciendo una conexión a través de los Named Pipes.

2. Envío y Recepción de Mensajes: El usuario que ejecuta send.sh puede ingresar mensajes, que se envían al amigo a través de pipe_in. El script listen.sh está constantemente a la espera de mensajes en pipe_in y muestra los mensajes recibidos.

3. Finalización del Chat: Para finalizar el chat, cualquiera de los participantes puede escribir "exit". Esto cierra ambos scripts y muestra un mensaje indicando que el chat ha finalizado.
