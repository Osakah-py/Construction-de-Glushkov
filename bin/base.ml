open Lib.Verif_regex

(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)
(* Nicolas PÃ©cheux <info.cpge@cpge.info>                            *)
(* http://cpge.info                                                 *)
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)

(* ANSI ESCAPE *)
let red_text s = "\027[31m" ^ s ^ "\027[0m";;
let green_text s = "\027[32m" ^ s ^ "\027[0m";;

(* Ã modifier : ce que l'on fait pour chaque ligne. En l'état, on
   affiche toujours la ligne. *)
let process_line line =
  Printf.printf "%s\n%!" line

(* Lecture de l'entrÃ©e, ligne par ligne *)
let process input =
  let i = ref 0 in
  try
    while true do
      let line = Stdlib.input_line input in
      Printf.printf "%s %s :" (red_text "Line ") (red_text (string_of_int !i)); 
      process_line line;
      i := !i + 1;
    done
  with End_of_file -> ()

let main () =
  (* Vérifie que l'expression régulière est bien présente en premier
     argument. Sinon, on affiche un message indiquant comment utiliser
     ce programme et on quitte avec un code d'erreur de `1`. *)
  let argc = Array.length Sys.argv in
  if argc < 2 || argc > 3 then begin
    Printf.printf "usage : %s regex [file]\n%!" Sys.argv.(0);
    exit 1
  end;
  (* S'il y a un deuxième argument c'est qu'il faut lire dans ce
     fichier, sinon, on utilise l'entrée standard. *)
  let input =
    if (argc = 3) then begin
      Stdlib.open_in Sys.argv.(2)
    end else
      Stdlib.stdin
  in
  Printf.printf
    "* Regexp you entered is '%s'\n* Reading from %s\n\n%!"
    Sys.argv.(1)
    (green_text (if argc = 3 then Sys.argv.(2) else "stdin"));
  process input;
  if argc = 3 then Stdlib.close_in input

let () = Printf.printf "ca compile ! \n" ; ignore (str_en_regex "ab|"); main ()
