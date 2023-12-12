open Type;; 

let creer_terminaux 
  (n: int) (suff: int list) =
  let res = Array.make n false in
  List.iter 
    (fun x -> res.(x) <- true)
    suff;
  res;;

(* creer la matrice de transition pour l'automate local *)
let creer_transitions
  (n: int) (pref: int list) (fact: facteur list) =
  (* n <- epsilon *)
  let res = Array.make (n + 1) [] in
  List.iter
    (fun x -> res.(n) <- (x, x))
    pref;
  List.iter 
    (fun (x, y) -> res.(x).(y) <- true)
    fact;
  res;;

let creer_automate_local 
  (n: int) (pref: int list) (suff: int list) (fact: facteur list) = 
  {
    nb_etats = n + 1; (* epsilon en plus *)
    initial = n; (* epsilon *)
    terminaux = creer_terminaux n suff;
    transitions = creer_transitions n pref fact
  };;