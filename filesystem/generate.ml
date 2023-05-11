let main () = begin
  let new_name () =
    Printf.sprintf "%0x.%x" (Random.bits ()) (Random.int 255) 
  in 
  let new_dirname () =
    Printf.sprintf "%0x" (Random.bits ()) 
  in 
  let fill_it fout = 
    for i = 1 to Random.int 20 do
      for j = 1 to 8 do
        Printf.fprintf fout "%d," (Random.int 100) 
      done ;
      Printf.fprintf fout "%d\n" (Random.int 200)
    done ;
    close_out fout 
  in 
  let rec do_it depth = 
    for i = 1 to 20 do
      match Random.int 5 with
      | 4 -> ()
      | 3 -> ()
      | 2 
      | 1 ->
        let nom = new_name () in 
        let fout = open_out nom in 
        fill_it fout 
      | _ -> 
        if depth < 4 then begin
          let nom = new_dirname () in 
          Unix.mkdir nom 0o777 ;
          Unix.chdir nom ; 
          do_it (depth + 1) ;
          Unix.chdir ".." 
        end 
    done 
  in
  do_it 0
end ;;
main () ;;
