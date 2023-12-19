open Type;; 
open Regex;;

let creer_terminaux 
  (n: int) (a_eps: bool) (suff: int list) =
  let res = Array.make n false in
  List.iter 
    (fun x -> res.(x) <- true)
    suff;
  res.(n - 1) <- a_eps; 
  res;;

(* creer la matrice de transition pour l'automate local *)
let creer_transitions
  (n: int) (pref: int list) (fact: facteur list) (dict: (int, int) Hashtbl.t) =
  (* n <- epsilon *)
  let res = Array.make (n + 1) [] in
  List.iter
    (fun x -> res.(n) <- (Hashtbl.find dict x, x)::res.(n))
    pref;
  List.iter 
    (fun (x, y) -> res.(x) <- (Hashtbl.find dict x, y)::res.(x))
    fact;
  res;;

let creer_automate_local 
  (* dict a pour clé l'étiquette *)
  (n: int) (a_eps: bool) (pref: int list) (suff: int list) (fact: facteur list) (dict: (int, int) Hashtbl.t) = 
  {
    nb_etats = n + 1; (* epsilon en plus *)
    initial = n; (* epsilon *)
    terminaux = creer_terminaux (n + 1) a_eps suff;
    transition_nd = creer_transitions n pref fact dict
  };;


let regex_en_automate regex = 
  let regex_lin, phi = lineariser regex in
  let a_eps, pref, suff, fact = deter_langage_local regex_lin in
  creer_automate_local (Hashtbl.length phi) a_eps pref suff fact phi;;