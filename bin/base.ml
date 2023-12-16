open Lib.Verif_regex
open Lib.Verif_word
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)
(* Nicolas PÃ©cheux <info.cpge@cpge.info>                            *)
(* http://cpge.info                                                 *)
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)

(* ANSI ESCAPE *)
let red_text s = "\027[31m" ^ s ^ "\027[0m";;
let green_text s = "\027[32m" ^ s ^ "\027[0m";;

(* Ã modifier : ce que l'on fait pour chaque ligne. En l'état, on
   affiche toujours la ligne. *)
let process_line line nb =
  if str_in_anfd line afnd_test_wikipedia then begin
    Printf.printf "%s %s :" (red_text "Line ") (red_text (string_of_int nb)); 
    Printf.printf "%s\n%!" line
  end

(* Lecture de l'entrÃ©e, ligne par ligne *)
let process input =
  let i = ref 0 in
  try
    while true do
      let line = Stdlib.input_line input in
      process_line line !i;
      i := !i + 1;
    done
  with End_of_file -> ()

let process_file path = 
  let current_process = Stdlib.open_in path in
  Printf.printf "\n Reading %s \n" (green_text path);
  process current_process;
  Stdlib.close_in current_process

let main () =
  (* Vérifie que l'expression régulière est bien présente en premier
     argument. Sinon, on affiche un message indiquant comment utiliser
     ce programme et on quitte avec un code d'erreur de `1`. *)
  let argc = Array.length Sys.argv in
  if argc < 2 || argc > 4 then begin
    Printf.printf "usage : %s regex [file]\n%!" Sys.argv.(0);
    exit 1
  end;
  let reg_arg, file_arg, compiled, recursive = Lib.Os.process_args argc Sys.argv in
  if compiled && recursive then Printf.printf "Compiled and recurs";
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
    (green_text file_arg);
  
  if file_arg = "___stdin___" then process Stdlib.stdin
  else
    begin
      for i = 0 to (Array.length input) - 1 do
        let path = Lib.Os.path_join folder  input.(i) in
        process_file path
      done
    end
  

let () = Printf.printf "ca compile ! \n" ; ignore (str_en_regex "ab|"); main ()
