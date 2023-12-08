(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)
(* Nicolas PÃ©cheux <info.cpge@cpge.info>                            *)
(* http://cpge.info                                                 *)
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)

(* Ã€ modifier : ce que l'on fait pour chaque ligne. En l'Ã©tat, on
   affiche toujours la ligne. *)
let process_line line =
  Printf.printf "%s\n%!" line

(* Lecture de l'entrÃ©e, ligne par ligne *)
let process input =
  try
    while true do
      let line = Stdlib.input_line input in
      process_line line
    done
  with End_of_file -> ()

let main () =
  (* VÃ©rifie que l'expression rÃ©guliÃ¨re est bien prÃ©sente en premier
     argument. Sinon, on affiche un message indiquant comment utiliser
     ce programme et on quitte avec un code d'erreur de `1`. *)
  let argc = Array.length Sys.argv in
  if argc < 2 || argc > 3 then begin
    Printf.printf "usage : %s regex [file]\n%!" Sys.argv.(0);
    exit 1
  end;
  (* S'il y a un deuxiÃ¨me argument c'est qu'il faut lire dans ce
     fichier, sinon, on utilise l'entrÃ©e standard. *)
  let input =
    if (argc = 3) then begin
      Stdlib.open_in Sys.argv.(2)
    end else
      Stdlib.stdin
  in
  Printf.printf
    "* Regexp you entered is '%s'\n* Reading from %s\n\n%!"
    Sys.argv.(1)
    (if argc = 3 then Sys.argv.(2) else "stdin");
  process input;
  if argc = 3 then Stdlib.close_in input

let () = main ()
