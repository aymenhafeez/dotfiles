; extends
(
  (comment) @cell_marker
  .
  (expression_statement
    (string
      (string_content) @injection.content))
  (#lua-match? @cell_marker "^%s*# %%%% %[markdown%]")
  (#set! injection.language "markdown")
)
