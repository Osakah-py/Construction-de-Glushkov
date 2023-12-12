type afnd = {
  nb_etats : int;
  initial : int; (* automate standard *)
  terminaux : bool array;
<<<<<<< HEAD
  transition : int list array array; (* (a, y) *)
=======
  transition_nd : (int * int) list array; (* (a, y) *)
>>>>>>> e403ba4 (automate implemented)
  }

(* pour Anna (determinisme d'un automate) *)
type afd = {
  nb_etats : int;
  initial : int;
  terminaux : bool array;
  transition_d : int array array (* x: etat || y: alphabet *)
}

type regex =
  | Eps
  | Var of int (* etiquette pour int *)
  | Ou of regex * regex
  | Et of regex * regex
  | Etoile of regex

type facteur = int * int 