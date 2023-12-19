open Type;;

(*
Entrée : une expression
But : linéariser le regex en se souvenant de l'étiquet
let lineariser : regex -> regex * ((int, int) Hashtbl.t)
*)


(* FONCTIONS ------------------------------------------ *)

let lineariser reg =
  let phi = Hashtbl.create 20 in
  let i = ref 0 in
  let rec aux reg = match reg with
    |Eps -> Eps
    |Var x -> Hashtbl.add phi !i x;
              i:= !i + 1;
              Var (!i - 1)
    |Ou(x,y) -> Ou(aux x , aux y )
    |Et(x,y) -> Et(aux x , aux y )
    |Etoile x-> Etoile( aux x )
  in ((aux reg), phi);;



let hashtbl_to_list tab =
  let res = ref [] in
  Hashtbl.iter
  (fun x _ -> res := x::!res)
  tab;
  !res;;

(* la première est gardée, la deuxième fusionne dans la première table *)
let fusion_hashtbl tab1 tab2 = 
  Hashtbl.iter
  (fun x _ -> if not (Hashtbl.mem tab1 x) then Hashtbl.add tab1 x x;)
  tab2;
  tab1;;

let deter_prefixe a_eps1 pref1 pref2 =  
  if a_eps1 then fusion_hashtbl pref1 pref2 
  else pref1;;

let deter_suffixe a_eps2 suff1 suff2 =  
  if a_eps2 then fusion_hashtbl suff2 suff1 
  else suff2;;

let deter_facteur fact suff pref =  
  Hashtbl.iter 
  (fun x _ ->
    Hashtbl.iter
    (fun y _ ->
      if not (Hashtbl.mem fact (x, y)) then begin 
        Hashtbl.add fact (x, y) (x, y)
      end 
    )
    pref
  )
  suff;
  fact;;

let deter_langage_local reg =
  (* regex ->  bool * int list * int list * facteur list *)
  (* expression régulière -> a_eps * pref * suff * fact *)
  let rec parcours_reg reg =
  match reg with
  | Eps -> (true, Hashtbl.create 0, Hashtbl.create 0, Hashtbl.create 0)
  | Var a ->   
    let a_tab_pref, a_tab_suff = Hashtbl.create 1, Hashtbl.create 1 in 
    Hashtbl.add a_tab_pref a a;
    Hashtbl.add a_tab_suff a a;
    (false, a_tab_pref, a_tab_suff, Hashtbl.create 0)
  | Et (reg1, reg2) -> 
    let a_eps1, pref1, suff1, fact1 = parcours_reg reg1 in
    let a_eps2, pref2, suff2, fact2 = parcours_reg reg2 in
    (
      a_eps1 && a_eps2, 
      deter_prefixe a_eps1 pref1 pref2,
      deter_suffixe a_eps2 suff1 suff2,
      deter_facteur (fusion_hashtbl fact1 fact2) suff1 pref2  
    )
  | Ou (reg1, reg2) ->
    let a_eps1, pref1, suff1, fact1 = parcours_reg reg1 in
    let a_eps2, pref2, suff2, fact2 = parcours_reg reg2 in
    (
      a_eps1 || a_eps2, 
      fusion_hashtbl pref1 pref2,
      fusion_hashtbl suff1 suff2,
      fusion_hashtbl fact1 fact2  
    )
  | Etoile reg1 ->
    let _, pref1, suff1, fact1 = parcours_reg reg1 in
    (
      true, 
      pref1,
      suff1,
      deter_facteur fact1 pref1 suff1  
    )
  in 

  let a_eps, fact, pref, suff = parcours_reg reg in
  (a_eps, hashtbl_to_list fact, hashtbl_to_list pref, hashtbl_to_list suff);;
