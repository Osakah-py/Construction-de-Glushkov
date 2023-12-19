(* ANSI ESCAPE *)
let red_text s = "\027[31m" ^ s ^ "\027[0m";;
let green_text s = "\027[32m" ^ s ^ "\027[0m";;

(* Gestion des fichiers *)
let path_separator =
  if Sys.os_type = "Win32" || Sys.os_type = "Cygwin" then
    '\\'
  else
    '/'
;;

let path_join base_path sub_path =
  if String.length base_path > 0 && base_path.[String.length base_path - 1] = path_separator then
    base_path ^ sub_path
  else
    base_path ^ (String.make 1 path_separator) ^ sub_path
;;

let format_dossier_caml str =
  let size = String.length str in
  if str.[size - 1] = '/' || str.[size - 1] = '\\' then String.sub str 0 (size - 1)
  else str 

(* Verifie si il y a des arguments -rc  et renvoie le quadruplet 
                      regex, nom du fichier, compilé?, recursif? *)

let process_args argc argv =
  if argc = 3 then 
    argv.(1), format_dossier_caml argv.(2), false, false
  else 
    begin
      if argv.(1).[0] = '-' then
        let compiled = ref false and recursive = ref false in
        for i = 1 to (String.length argv.(1)) - 1 do
          match argv.(1).[i] with
          | 'c' -> compiled := true
          | 'r' -> recursive := true
          | a -> Printf.printf "argument %c non reconnu et donc ignoré \n" a
        done;
        if argc = 4 then (
          Printf.printf "%s args \n" argv.(2);
        argv.(2), format_dossier_caml argv.(3), !compiled, !recursive)
        else  (Printf.printf "%d euh args \n" argc;
          argv.(2), "___stdin___", !compiled, !recursive)
      else 
        if argc = 2 then
          argv.(1), "___stdin___", false, false
      else exit 1
    end
