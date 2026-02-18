#!/bin/bash
# Uso: ./install.sh [lenguaje] [arquitectura] [ruta-destino]

LANGUAGE=$1
ARCHITECTURE=$2
DEST=$3

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" &> /dev/null && pwd)
SKILLS_SOURCE="$SCRIPT_DIR/skills/$LANGUAGE/$ARCHITECTURE"
SKILLS_STANDARD="$SCRIPT_DIR/skills/$LANGUAGE/Estandares.md"


# Validar si el origen existe antes de copiar
if [ -d "$SKILLS_SOURCE" ]; then
    cp -r "$SKILLS_SOURCE" "$DEST/.skills"
	cp -r "$SKILLS_STANDARD" "$DEST/.skills"

    echo "✅ Skills copiados a $DEST/.skills"
else
    echo "❌ Error: No se encontró la ruta $SKILLS_SOURCE"
    exit 1
fi