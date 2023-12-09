# Construction-de-Glushkov

## Setup le projet en local

Pour obtenir le projet en local :
```bash
git clone https://github.com/Osakah-py/-Construction-de-Glushkov.git
```
Pour installer les bonnes dépendances :
```bash
opam install . --deps-only
```
Pour compiler : 
```bash
dune build
```
## Objectifs
- **Alex**: Vérifier regex + créer regex (pile) (ordre postfixe) ✓ 
- **Daniel / Anna**: Linéariser le regex (fonction phi + préfixe, suffixe et facteur)
- **Daniel**: Implémenter l'automate local + enlever les étiquettes
- **Alex / Anna**: Vérifier si le mot appartient à l'automate (simuler les états en même temps / déterminisation)
- **Tous**: Implémenter l'entrée et la sortie (À LA FIN)


## Syntaxe des regex
- . : une lettre quelconque de l’alphabet
- @ : concaténation
- | : alternative
- \* : étoile de Kleene (zéro, une ou plusieurs fois)
- ? : optionel (zéro ou une fois) 
