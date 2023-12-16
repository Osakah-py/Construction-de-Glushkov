(lang dune 3.4)

(name glushkov)

(generate_opam_files true)

(source
 (github osakah-py/construction-de-glushkov))

(authors "Daniel Luo, Anna Merle, Alexandre Lescot")

(maintainers "Daniel Luo, Anna Merle, Alexandre Lescot")

(license "Apache License 2.0")

(documentation https://url/to/documentation)

(package
 (name glushkov)
 (synopsis "une version de grep")
 (description "avec la construction glushkov pour les automates")
 (depends ocaml dune)
 (tags
  (grep "glushkov construction" regex project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
