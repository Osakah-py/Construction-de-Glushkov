# Construction-de-Glushkov

## Setup le projet en local

Pour obtenir le projet en local :
```bash
git clone https://github.com/Osakah-py/-Construction-de-Glushkov.git
```

OPAM offre une fonctionnalité appelée **sandboxes** qui peut être utilisée pour isoler les dépendances de vos projets OCaml.
Voici comment créer et utiliser une sandbox avec OPAM :

1. **Créer une nouvelle sandbox :**
   ```bash
   opam switch create glushkov 4.14.0
   ```
sur windows c'est plutot ```opam switch create glushkov 4.14.0+mingw64```
(la 4.14.0 est la version qu'on utilise mais il se peut que une erreur soit retourné comme quoi elle est pas disponible, essayer alors de mettre a jour opam ```opam update``` )
2. **Activer la sandbox :**
   ```bash
   eval $(opam env)
   ```

   Cette commande ajuste l'environnement OPAM pour utiliser la sandbox nouvellement créée.

3. **Installer des paquets dans la sandbox :**
   Vous pouvez maintenant installer les paquets OCaml spécifiques au projet sans interférer avec le reste de votre système. Pour cela, il faut installer les dépendances avec :
```bash
opam install . --deps-only
```
4. **Compiler :**
```bash
dune build
```
4. **Désactiver la sandbox :**
   Lorsque vous avez terminé de travailler sur votre projet dans la sandbox, vous pouvez désactiver celle-ci pour revenir à l'environnement global :
   ```bash
   eval $(opam env --unset-switch)
   ```

   Cela rétablit l'environnement global OPAM.

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
