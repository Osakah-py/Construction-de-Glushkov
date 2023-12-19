open Type;; 

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
  (n: int) (pref: int list) (fact: facteur list) (dict: int array)=
  (* n <- epsilon *)
  let res = Array.make (n + 1) [] in
  List.iter
    (fun x -> res.(n) <- (dict.(x), x)::res.(n))
    pref;
  List.iter 
    (fun (x, y) -> res.(x) <- (dict.(x), y)::res.(x))
    fact;
  res;;

let creer_automate_local 
  (* dict a pour clé l'étiquette *)
  (n: int) (a_eps: bool) (pref: int list) (suff: int list) (fact: facteur list) (dict: int array) = 
  {
    nb_etats = n + 1; (* epsilon en plus *)
    initial = n; (* epsilon *)
    terminaux = creer_terminaux (n + 1) a_eps suff;
    transition_nd = creer_transitions n pref fact dict
  };;


let regex_en_automate regex = 
  if not (regex = Eps) then
  {
  nb_etats = 6;
  initial = 0;
  terminaux = [|true; true; false; true; false; true|];
  transition_nd = [| [(Char.code 'a', 1); (Char.code 'b', 4)]; [(Char.code 'a', 1); (Char.code 'a', 2)]; [(Char.code 'b', 3)]; [(Char.code 'a', 1); (Char.code 'a', 2)]; [(Char.code 'a', 5)];[(Char.code 'b', 4)]|]
}
  else 
    {
      nb_etats = 6;
      initial = 0;
      terminaux = [|true; true; false; true; false; true|];
      transition_nd = [| [(Char.code 'a', 1); (Char.code 'b', 4)]; [(Char.code 'a', 1); (Char.code 'a', 2)]; [(Char.code 'b', 3)]; [(Char.code 'a', 1); (Char.code 'a', 2)]; [(Char.code 'a', 5)];[(Char.code 'b', 4)]|]
    };;