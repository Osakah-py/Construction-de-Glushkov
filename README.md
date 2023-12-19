# Construction-de-Glushkov

## Setup le projet en local

Pour obtenir le projet en local :
```bash
git clone https://github.com/Osakah-py/Construction-de-Glushkov.git
```
> [!TIP]\
> Version ultra rapide : àllez a la racine du fichier et taper ```source setup.sh```, cela va effectuer les commandes si dessous tout seul.

> [!NOTE]\
> Vous êtes pas obligé de faire une sandboxe, et vous pouvez directement passer à la partie 3.

OPAM offre une fonctionnalité appelée **sandboxes** qui peut être utilisée pour isoler les dépendances de vos projets OCaml.
Voici comment créer et utiliser une sandbox avec OPAM :

1. **Créer une nouvelle sandbox :**
   ```bash
   opam switch create glushkov 4.14.0
   ```
> [!WARNING]\
> sur windows c'est plutot ```opam switch create glushkov 4.14.0+mingw64```

> [!WARNING]\
>la 4.14.0 est la version qu'on utilise mais il se peut que une erreur soit retourné comme quoi elle est pas disponible, essayer alors de mettre a jour opam ```opam update``` 


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
4. **Compiler & éxecuter :**
```bash
dune build
```
Et ensuite pour essayer le projet : 
```bash
dune exec glushkov
```
> [!TIP]
> Pour utiliser avec des arguments le projet il faut taper : ```dune exec -- glushkov [regex] [file]```

4. **Désactiver la sandbox :**
   Lorsque vous avez terminé de travailler sur votre projet dans la sandbox, vous pouvez désactiver celle-ci pour revenir à l'environnement global :
   ```bash
   eval $(opam env --unset-switch)
   ```

   Cela rétablit l'environnement global OPAM.

## ✨ Spécial pour Anna ✨
Une fois le projets en local voici comment l'envoyer vers le répértoire git 
1. **Verifier les modifs des autres**
Pour éviter les conflits on peut commencer par récuper les modifications des autres pour cela taper dans le terminal :
```bash
git pull origin
```
> [!NOTE]
> En soit cette étape est pas obligatoire mais c'est une mesure de sécurité, si jamais t'as un conflit dit le nous :p

2. **Ajouter les modifs**
D'abord on choisi les fichiers a envoyer (```.``` pour indiquer tout ceux du répertoire)
```bash
git add .
```
Puis on explique ce qu'on a fait
```bash
git commit -m "mes super modifs !"
```

3. **On envoit les modifs a Github**
```bash
git push origin
```
## Objectifs
- **Alex**: Vérifier regex + créer regex (pile) (ordre postfixe)  ✓
- **Daniel / Anna**: Linéariser le regex (fonction phi + préfixe, suffixe et facteur + enlever les étiquettes de l'automate local)
- **Daniel**: Implémenter l'automate local ✓
- **Alex / Anna**: Vérifier si le mot appartient à l'automate (simuler les états en même temps ✓ / déterminisation)
- **Tous**: Implémenter l'entrée et la sortie (À LA FIN)


## Syntaxe des regex
- ```.``` : une lettre quelconque de l’alphabet
- ```@``` : concaténation, notez que `(flop)` est équivalent a `fl@o@p@` pour faciliter l'ecriture.
- ```|``` : alternative
- ```*``` : étoile de Kleene (zéro, une ou plusieurs fois)
- ```?``` : optionel (zéro ou une fois) 
