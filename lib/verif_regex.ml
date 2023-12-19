open Type;;

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
  |[_] -> raise (InvalidRegex "Union a un seul élément")
  |a::b::t -> Ou(a, b)::t

let inter (pile : regex list) = match pile with 
  |[] -> raise (InvalidRegex "Intersection vide")
  |[_] -> raise (InvalidRegex "Intersection a un seul élément")
  |a::b::t -> Et(a, b)::t

let kleene (pile : regex list) = match pile with 
  |[] -> raise (InvalidRegex "Kleene tout nu !")
  |a::t -> Etoile(a)::t

let un_ou_rien (pile : regex list) = match pile with 
  |[] -> raise (InvalidRegex "? est vide ????")
  |a::t -> Ou(a, Eps)::t

let str_en_regex (str: string) = 
  let pile = ref [] in
  let mult_concat = ref false in
  let mult_concat_ind = ref 0 in
  for i=0 to (String.length str) - 1 do
    match str.[i] with
    | '|' -> pile := union !pile
    | '@' -> pile := inter !pile
    | '*' -> pile := kleene !pile
    | '?' -> pile := un_ou_rien !pile
    | '(' -> mult_concat := true
    | ')' -> mult_concat := false; mult_concat_ind := 0
    |  c  -> pile := Var(Char.code c)::!pile; 
              if !mult_concat && !mult_concat_ind > 0 then 
                pile := inter !pile 
              else if !mult_concat then 
                mult_concat_ind := 1
  done;
  match !pile with
  | [a] -> if not !mult_concat then a else raise (InvalidRegex "Pensez a bien fermer les paranthèses !")
  | _ -> raise (InvalidRegex "Regex pas complète (il manque probablement des opérateurs)")
