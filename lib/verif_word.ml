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
 
(*let emptyafnd = {
  nb_etats = 0;
  initial = 0;
  terminaux = [||];
  transition_d = [||]
}*)
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
  try for i = 0 to (length-1) do
    if meta_state.(i) && auto.terminaux.(i) then
      raise Break
  done; false
  with Break -> true;;

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


(* Deterministation *)
(**********************)
let parcours_autpart (u :string) (aut : afnd) =
  let nb_etats = aut.nb_etats in
  let n = String.length u in (*nb de caractères*)
  let q0 = aut.initial in (*etat initial*)
  let t = Array.make_matrix 2 nb_etats false in (* 2 tableaux de meta etats*)
  t.(0).(q0) <- true;
  for i = 0 to (n-1) do (*caractères*)
   for k=0 to (nb_etats-1) do
        t.(1 - (i mod 2)).(k) <-false
      done;
    for j = 0 to (nb_etats-1) do (*etats*)
      if t.(i mod 2).(j) then(
        let trans = aut.transition_nd in
        let rec aux lst char_int  = match lst with
            |[]-> ()
            |(l,e)::q-> if l = char_int then  t.( 1 - (i mod 2)).(e) <- true;
                         aux q char_int
         in aux (trans.(j)) ( Char.code (u.[i])))
      done;
    done;
  meta_terminal (t.(n mod 2)) aut;;

(*let determinisation (automate_nd :afnd) =

    Printf.printf "Soon";;*)
(* GENERAL *)
(**********************)
let str_dans_anfd (str: string) (automate : afnd) (compiled : bool) =
  if not compiled then parcours_autpart str automate
  else parcours_direct str automate

