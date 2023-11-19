 (macro_invocation
  (scoped_identifier
   path: (identifier) @path (#eq? @path sqlx)
   name: (identifier) @name (#eq? @name query))
  (token_tree
   (raw_string_literal) @injection.content
   (#offset! @injection.content 1 0 -1 0)
   (#set! injection.language sql)))
