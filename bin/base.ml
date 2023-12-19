open Lib.Verif_regex
open Lib.Verif_word
open Lib.Type
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)
(* Nicolas PÃ©cheux <info.cpge@cpge.info>                            *)
(* http://cpge.info                                                 *)
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)


(* GLOBAL VAR *)
let compiled = ref false;;
let afnd_a_verif = ref {
  nb_etats = 0;
  initial = 0;
  terminaux = [||];
  transition_nd = [||]
};;

let initialisation str_reg = 
  try let regex = str_en_regex str_reg in 
  afnd_a_verif := Lib.Automate.regex_en_automate regex
with InvalidRegex err -> Printf.printf "Erreur dans la regex : %s" (Lib.Os.red_text err); exit 1



(* Ã modifier : ce que l'on fait pour chaque ligne. En l'état, on
   affiche toujours la ligne. *)
let process_line line nb =
  if str_dans_anfd line !afnd_a_verif !compiled then begin
    Printf.printf "%s %s :" (Lib.Os.red_text "Line ") (Lib.Os.red_text (string_of_int nb)); 
    Printf.printf "%s\n%!" line
  end

(* Lecture de l'entrÃ©e, ligne par ligne *)
let process_file input =
  let i = ref 0 in
  try
    while true do
      let line = Stdlib.input_line input in
      process_line line !i;
      i := !i + 1;
    done; 
  with End_of_file -> ()


let rec process_folder input folder recursiv =  
for i = 0 to (Array.length input) - 1 do
  let path = Lib.Os.path_join folder  input.(i) in
  Printf.printf "\n* Reading %s \n" (Lib.Os.green_text path);
  if Sys.is_directory path then
    if recursiv then process_folder (Sys.readdir path) path recursiv
    else Printf.printf "C'est un dossier pour le lire aussi ajouter l'option -r\n"
  else begin 
        let current_process = Stdlib.open_in path in
        process_file current_process;
        Stdlib.close_in current_process
        end
done

let main () =
  (* Vérifie que l'expression régulière est bien présente en premier
     argument. Sinon, on affiche un message indiquant comment utiliser
     ce programme et on quitte avec un code d'erreur de `1`. *)
  let argc = Array.length Sys.argv in
  if argc < 2 || argc > 4 then begin
    Printf.printf "usage : %s regex [file]\n%!" Sys.argv.(0);
    exit 1
  end;
  let reg_arg, file_arg, comp, recursive = Lib.Os.process_args argc Sys.argv in
  if comp then compiled := true;
  initialisation reg_arg;
  Printf.printf "le file : %s" file_arg;
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
  

let () = Printf.printf "ca compile ! \n" ; main ()
