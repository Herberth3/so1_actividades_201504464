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

