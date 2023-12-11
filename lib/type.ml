type afd_local = {
  nb_etats : int;
  initial : int;
  terminaux : bool array;
  transitions : bool array array (* x: etat || y: etat *)
}


type afnd = {
  nb_etats : int;
  inital : int list;
  terminaux : bool array;
  transition : (int * char * int) list array;
}

type regex =
  | Eps
  | Var of int (* etiquette pour int *)
  | Ou of regex * regex
  | Et of regex * regex
  | Etoile of regex

type facteur = int * int 