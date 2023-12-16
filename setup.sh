#!/bin/bash

# Couleurs
RESET='\033[0m'  # Réinitialisation des couleurs
ROUGE='\033[0;31m'
VERT='\033[0;32m'
JAUNE='\033[1;33m'

# Vérifier si OPAM est correctement configuré
if command -v opam &> /dev/null; then
    echo "OPAM est correctement configuré."
else
    echo "Erreur: OPAM n'est pas configuré correctement. Assurez-vous qu'OPAM est installé et configuré."
    exit 1
fi
#Opam dependencies
echo -e "${ROUGE} Installation des dépendances... ${RESET}"
eval $(opam env)
opam install . --deps-only

# Compiler le projet avec Dune
echo -e "${ROUGE} Construction de l'executable... ${RESET}"
dune build

nouveau_nom="glushkov.opam" 
ancien_nom="glushkov.exe"

mv "$PWD/_build/install/default/bin/$ancien_nom" "$PWD/_build/install/default/bin/$nouveau_nom"

# Ajouter le chemin au PATH
export PATH=$PATH:$PWD/_build/install/default/bin
echo -e "${VERT} Le projet a été construit et ajouté au PATH temporairement ${RESET} \n Pour commencer taper : glushkov [-rc] [regex] [fichier ou dossier]"
echo "  -r = récursif"
echo "  -c = determinise l'automate"