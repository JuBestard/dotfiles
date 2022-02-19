let search_both list a b =
  let rec aux x = function
    |[] -> false
    |e::l when e = x -> true
    |e::l -> aux x l
  in (aux a list && aux b list);;
