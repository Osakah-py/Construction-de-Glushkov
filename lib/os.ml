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

(* Verifie si il y a des arguments -rc  et renvoie le nom du fichier, compilé?, recursif? *)

let process_args argc =   
  if argc = 3 then 
    Sys.argv.(2), false, false
  else   
  if Sys.argv.(2).[0] = '-' then
    let compiled = ref false and recursive = ref false in
    for i=0 to String.length Sys.argv.(2) do
      match Sys.argv.(2).[i] with
      | 'c' -> compiled := true
      | 'r' -> recursive := true
      | a -> Printf.printf "argument %c non reconnu et donc ignoré \n" a
    done;
    if argc = 3 then
    Sys.argv.(3), !compiled, !recursive
    else  "stdin", !compiled, !recursive
  else 
    exit 1;;