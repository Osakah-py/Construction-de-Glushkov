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
  |a::b::t -> Ou(a, b)::t

let inter (pile : regex list) = match pile with 
  |[] -> raise (InvalidRegex "Intersection vide")
  |[a] -> raise (InvalidRegex "Intersection a un seul élément")
  |a::b::t -> Et(a, b)::t

let kleene (pile : regex list) = match pile with 
  |[] -> raise (InvalidRegex "Kleene tout nu !")
  |a::t -> Etoile(a)::t

let un_ou_rien (pile : regex list) = match pile with 
  |[] -> raise (InvalidRegex "? est vide ????")
  |a::t -> Ou(a, Eps)::t

let str_en_regex (str: string) = 
  let pile = ref [] in
  for i=0 to (String.length str) - 1 do
    match str.[i] with
    | '|' -> pile := union !pile
    | '@' -> pile := inter !pile
    | '*' -> pile := kleene !pile
    | '?' -> pile := un_ou_rien !pile
    |  c  -> pile := Var(Char.code c)::!pile
  done;
  match !pile with
  | [a] -> a
  | _ -> raise (InvalidRegex "Regex pas complète")
