open Lib.Verif_regex
open Lib.Verif_word
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)
(* Nicolas PÃ©cheux <info.cpge@cpge.info>                            *)
(* http://cpge.info                                                 *)
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)


(* GLOBAL VAR *)
let compiled = ref false;;
let afnd_a_verif = ref Lib.Automate.emptyafnd;;
(*let afd_a_verif = ref Lib.Automate.emptyafd;;*)
let total_match = ref 0;;
let total_files = ref 0;;


(* Initialisation = creation de l'automate *)
let initialisation str_reg = 
  try let regex = str_en_regex str_reg in 
  afnd_a_verif := Lib.Automate.regex_en_automate regex
with InvalidRegex err -> Printf.printf "Erreur dans la regex : %s" (Lib.Os.red_text err); exit 1


(* On affiche la ligne ssi elle match la regex *)
let process_line line nb =
  if str_dans_anfd line !afnd_a_verif !compiled then begin
    incr total_match;
    Printf.printf "%s %s :" (Lib.Os.red_text "Line ") (Lib.Os.red_text (string_of_int nb)); 
    Printf.printf "%s\n%!" line
  end

(* on traite chaque ligne indépendament *)
let process_file input =
  let i = ref 1 in
  try
    while true do
      let line = Stdlib.input_line input in
      process_line line !i;
      i := !i + 1;
    done; 
  with End_of_file -> ()

(* Ici si on tombe sur un fichier on le traite si on tombe sur un dossier on traite le dossier si -r est donné en entrée *)
let rec process_folder input folder recursiv =  
for i = 0 to (Array.length input) - 1 do
  let path = Lib.Os.path_join folder  input.(i) in
  if Sys.is_directory path then
    if recursiv then process_folder (Sys.readdir path) path recursiv
    else Printf.printf "C'est un dossier pour le lire aussi ajouter l'option -r\n"
  else begin 
        Printf.printf "\n* Reading %s \n" (Lib.Os.green_text path);
        let current_process = Stdlib.open_in path in
        process_file current_process;
        Stdlib.close_in current_process;
        incr total_files;
        end
done

let main () =
  (* Vérifie que l'expression régulière est bien présente en premier
     argument. Sinon, on affiche un message indiquant comment utiliser
     ce programme et on quitte avec un code d'erreur de `1`. *)
  let argc = Array.length Sys.argv in
  if argc < 2 || argc > 4 then begin
    Printf.printf "argc = %d \n" argc;
    for i = 0 to argc -1 do Printf.printf "%d:%s \n " i Sys.argv.(i) done;
    Printf.printf "usage : %s regex [file]\n%!" Sys.argv.(0);
    exit 1
  end;
  (* Ici on récupères les arguments entrés avec les options *)
  let reg_arg, file_arg, comp, recursive = Lib.Os.process_args argc Sys.argv in
  if comp then compiled := true;
  initialisation reg_arg;
  (* S'il y a un deuxième argument c'est qu'il faut lire dans ce
   fichier, sinon, on utilise l'entrée standard. *)
   let input, folder =
        if file_arg = "___stdin___" then
          [||], "."
        else if Sys.is_directory file_arg then
            Sys.readdir file_arg, file_arg
        else
          [| file_arg |], "."
  in
  
  Printf.printf "* Regexp you entered is '%s'\n* Reading from %s\n\n%!"
    reg_arg
    (Lib.Os.green_text file_arg);
  
  if file_arg = "___stdin___" then process_file Stdlib.stdin
  else
    process_folder input folder recursive
  

let () = main (); Printf.printf "\n\t %d files analysed. %s \n" !total_files (Lib.Os.green_text @@ (string_of_int !total_match) ^ " lines matching.")
