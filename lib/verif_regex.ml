(* Syntaxe des regex :
      . : une lettre quelconque de l’alphabet
      @ : concaténation
      | : alternative
      * : étoile de Kleene (zéro, une ou plusieurs fois)
      ? : optionel (zéro ou une fois)   
*)

exception InvalidRegex of string

let union (pile : regex list) = match pile with 
  |[] -> raise (InvalidRegex "Union vide")
  |[a] -> raise (InvalidRegex "Union a un seul élément")
  |a::b::t -> Union(a, b)



let reconnaitre_regex (str: string) = 
  let pile = ref [] in
  for i=0 to (String.length str) - 1 do
    if str.[i] = '!' then
      let valid     
      Printf.printf("bouh !")
  done 
