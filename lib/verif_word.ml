(* Nous utiliserons deux méthodes selon la préférence de l'utilisateur : *)
(*   - La déterminisation de l'automate                                  *)
(*   - Le parcours en direct de l'automate non déterministe              *)
(*************************************************************************)

open Type;;


(* Parcours en Direct *)
(**********************)

let str_in_anfd (str: string) (automate : afnd) =
  let lgt = (String.length str) in
  let aux (curr_char:int) (curr_state:int) =
    if curr_char = lgt then
       automate.terminaux.(curr_state)
    else
      List.iter (aux (curr_char+1)) (automate.transition_nd.(automate.initial).(Char.code (str.[curr_char])))
  in aux 0 automate.initial