(* Syntaxe des regex :
      . : une lettre quelconque de l’alphabet
      @ : concaténation
      | : alternative
      * : étoile de Kleene (zéro, une ou plusieurs fois)
      ? : optionel (zéro ou une fois)   
*)

let reconnaitre_regex (str: string) = 
  let pile = ref [] in
  for i=0 to (String.length str) - 1 do
    if str.[i] = '!' then
      Printf.printf("bouh !")
  done 
