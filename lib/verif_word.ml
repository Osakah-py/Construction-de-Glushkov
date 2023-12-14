(* Nous utiliserons deux méthodes selon la préférence de l'utilisateur : *)
(*   - La déterminisation de l'automate                                  *)
(*   - Le parcours en direct de l'automate non déterministe              *)
(*************************************************************************)

open Type;;


(* Denote l'expression reguliere ( a(ab)* )* || (ba)*     *)
let afnd_test_wikipedia = {
  nb_etats = 6;
  initial = 0;
  terminaux = [|true; true; false; true; false; true|];
  transition_nd = [| [(Char.code 'a', 1); (Char.code 'b', 4)]; [(Char.code 'a', 1); (Char.code 'a', 2)]; [(Char.code 'b', 3)]; [(Char.code 'a', 1); (Char.code 'a', 2)]; [(Char.code 'a', 5)];[(Char.code 'b', 4)]|]
}

(* Parcours en Direct *)
(**********************)

let str_in_anfd (str: string) (automate : afnd) =
  let lgt = (String.length str) in
  let rec changement_etat (i:int) (curr_state:int) =
    if i = lgt then
       automate.terminaux.(curr_state)
    else
      parcours_vosins i automate.transition_nd.(curr_state)
  and parcours_vosins (i:int) (voisins : (int * int) list) = match voisins with
  | [] -> false
  | (a, state)::q -> if a = Char.code (str.[i]) then 
                        changement_etat (i+1) (state) || (parcours_vosins i q)
                      else 
                        (parcours_vosins i q)
  in changement_etat 0 automate.initial

  (*List.iter (aux (curr_char+1)) (automate.transition_nd.(automate.initial).(Char.code (str.[curr_char])))*)