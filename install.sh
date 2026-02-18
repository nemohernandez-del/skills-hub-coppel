#!/bin/bash
# Uso: ./install.sh java 3-capas

LANGUAGE=$1
ARCHITECTURE=$2
SKILLS_REPO="https://github.com/tu-empresa/skills-hub"
DEST="$HOME/.vscode/skills/$LANGUAGE/$ARCHITECTURE"

mkdir -p $DEST
git clone --depth=1 --filter=blob:none --sparse $SKILLS_REPO /tmp/skills-hub
cd /tmp/skills-hub
git sparse-checkout set skills/$LANGUAGE/$ARCHITECTURE
cp -r skills/$LANGUAGE/$ARCHITECTURE/* $DEST

echo "Skills instalados en $DEST"