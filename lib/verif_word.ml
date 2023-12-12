(* Nous utiliserons deux méthodes selon la préférence de l'utilisateur : *)
(*   - La déterminisation de l'automate                                  *)
(*   - Le parcours en direct de l'automate non déterministe              *)
(*************************************************************************)

open Type;;


(* Parcours en Direct *)
(**********************)

let str_in_anfd (str: string) (automate : afnd) =
  if automate.transition_nd.(automate.initial).(Char.code (str.[1])) = [] then 
    Printf.printf "Vide"