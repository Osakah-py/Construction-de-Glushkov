type afd = {
  nb_etats : int;
  initial : int;
  terminaux : bool array;
  transitions : int array array (* x: etat || y: lettre *)
}

type afnd = {
  nb_etats : int;
  inital : int list;
  terminaux : bool array;
  transition : (int * char * int) list array;
}

type regex =
  | Vide 
  | Eps
  | Var of char
  | Ou of regex * regex
  | Et of regex * regex
  | Etoile of regex