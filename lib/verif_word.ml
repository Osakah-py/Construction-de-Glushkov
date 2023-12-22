(* Nous utiliserons deux méthodes selon la préférence de l'utilisateur : *)
(*   - La déterminisation de l'automate                                  *)
(*   - Le parcours en direct de l'automate non déterministe              *)
(*************************************************************************)

open Type;;

(* Automate de test *)
(**********************)
(* Denote l'expression reguliere ( a(ab)* )* || (ba)*     *)
let afnd_test_wikipedia = {
  nb_etats = 6;
  initial = 0;
  terminaux = [|true; true; false; true; false; true|];
  transition_nd = [| [(Char.code 'a', 1); (Char.code 'b', 4)]; [(Char.code 'a', 1); (Char.code 'a', 2)]; [(Char.code 'b', 3)]; [(Char.code 'a', 1); (Char.code 'a', 2)]; [(Char.code 'a', 5)];[(Char.code 'b', 4)]|]
}
 
let emptyafnd = {
  nb_etats = 0;
  initial = 0;
  terminaux = [||];
  transition_d = [||]
}
(* Parcours en Direct *)
(**********************)
let parcours_direct (str: string) (automate : afnd) =
  let lgt = (String.length str) in
  let rec changement_etat (i:int) (curr_state:int) =
    if i = lgt then
       automate.terminaux.(curr_state)
    else
      parcours_vosins i automate.transition_nd.(curr_state)
  and parcours_vosins (i:int) (voisins : (int * int) list) = match voisins with
  | [] -> false
  | (a, state)::q -> if a = Char.code (str.[i]) || a = Char.code '.' then 
                        changement_etat (i+1) (state) || (parcours_vosins i q)
                      else
                        (parcours_vosins i q)
  in changement_etat 0 automate.initial
(***********************)
exception Break
let meta_terminal (meta_state : bool array) (auto : afnd) =
  let length = Array.length meta_state in
  try for i = 0 to length do
    if meta_state.(i) then 
      raise Break
  done; false
  with Break -> true

let meta_next (prev : bool array) (carac : int) (automate : afnd) = 
  let next = Array.make automate.nb_etats false in
  let length = Array.length prev in
  for i = 0 to length do
    if prev.(i) then 
      let rec aux = function
      | (c, state) when c = carac -> next.(i) <- true
      | _ -> ()
    in aux automate.transition_nd.(i);
  done;
  next;;

let determinisation (automate :afnd) = 
  let str_len = String.length str in 
  let curr_meta_state = Array.make automate.nb_etats false in
  let rec changement_etat (i:int) = 
    if i = lgt then 
      meta_terminal curr_meta_state automate
    else 
      meta_next curr_meta_state (Char.code 'a') automate


(* Deterministation *)
(**********************)
let parcours_autpart (u :string) (aut : afnd) =
  let nb_etats = aut.nb_etats in
  let n = String.length u in
  let q0 = aut.initial in
  let t1 = ref Array.make nb_etats false in
  let t2 = Array.make nb_etats false in
  t.(q0) <- true;
  for i = 0 to (n-1) do
    for j = 0 to nb_etats do
      if t1.(j) 

let determinisation (automate_nd :afnd) =

    Printf.printf "Soon"


(* GENERAL *)
(**********************)
let str_dans_anfd (str: string) (automate : afnd) (compiled : bool) =
  if not compiled then parcours_direct str automate
  else parcours_determinise str emptyafnd
