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

