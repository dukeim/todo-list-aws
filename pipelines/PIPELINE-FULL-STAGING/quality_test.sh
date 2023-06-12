#!/bin/bash

source todo-list-aws/bin/activate
set -x

flake8 src/*.py test/*.py > flake8_output.txt

# Verifica si flake8 encontró errores y, en caso afirmativo, muestra el detalle de los errores y termina el pipeline con error
if [ $? -ne 0 ]; then
    echo "Se encontraron los siguientes errores de calidad en el código:"
    cat flake8_output.txt
    exit 1
fi
