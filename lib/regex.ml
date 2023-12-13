(*
Entrée : une expression
But : linéariser le regex en se souvenant de l'étiquet
let lineariser : regex -> regex

let facteur : regex -> facteur list  
let prefixe : regex -> int list
let suffixe : regex -> int list
*)

(* VARIABLES GLOBALES ---------------------------------- *)
let phi = ref (Array.make 0 0);;
let pref_hashtbl = Hashtbl.create ();;
let suff_hashtbl = Hashtbl.create ();;
let fact_hashtbl = Hashtbl.create ();;


(* FONCTIONS ------------------------------------------ *)
(*let concat_listes tab l1 l2 =
  
let update_hashtbl tab l = 
  List.iter
  (fun x -> Hashtbl.add tab x x)
  l;;

let deter_prefixe a_eps1 pref1 pref2 =  
  if a_eps1 then begin
    update_hashtbl 
  end;
  !res

let deter_langage_local reg =
  Hashtbl.reset pref_hashtbl;
  Hashtbl.reset suff_hashtbl;
  Hashtbl.reset fact_hashtbl;
  (* regex ->  bool * int list * int list * facteur list *)
  (* expression régulière -> a_eps * pref * suff * fact *)
  let rec parcours_reg reg =
  match reg with
  | Eps -> (true, [], [], [])
  | Var a ->   
    (false, deter_prefixe false [a] [], [a], [])
  | Et (reg1, reg2) -> 
    let a_eps1, pref1, suff1, fact1 = deter_langage_local reg1 in
    let a_eps2, pref2, suff2, fact2 = deter_langage_local reg2 in


*)