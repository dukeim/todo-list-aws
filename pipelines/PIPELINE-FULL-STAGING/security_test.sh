#!/bin/bash

source todo-list-aws/bin/activate
set -x

# Ejecuta las pruebas de seguridad con Bandit en las carpetas src/ y test/
bandit -r src/*.py test/*.py -f json -o bandit_results.json -lll

# Verifica si Bandit encontró fallos de nivel alto y, en caso afirmativo, muestra las líneas de código con potenciales riesgos de seguridad y falla el pipeline
if grep -q "\"issue_severity\": 2" bandit_results.json; then
    echo "Se encontraron fallos de seguridad de nivel alto."
    echo "Detalles de los fallos:"
    grep "\"issue_severity\": 2" bandit_results.json
    exit 1
fi