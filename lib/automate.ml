open Type;;

let creer_transition x a y aut =
  aut.transitions.(x).(a) <- y;;
(*
let creer_automate_local 
  n (pref: int list) (suff: int list) (fact: facteur list) = 
  let res =
    {
      nb_etats = n + 1; (* epsilon : -1 *)
      initial = -1;
      terminaux = Array.length n; 
    }

*)