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