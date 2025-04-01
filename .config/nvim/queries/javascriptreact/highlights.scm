; Types
(this) @selfReferenceParam
(super) @selfReferenceParam

(identifier) @identifier
(property_identifier) @identifier


(call_expression function: (member_expression (property_identifier) @function))
(method_definition name: (property_identifier) @function)
((method_definition name: (property_identifier) @keyword) (#eq? @keyword "constructor"))

((identifier) @type
 (#match? @type "^[A-Z]") 
 (#set! priority 120)
 )


; Variables


; Literals
[
  (null)
  (true)
  (false)
] @keyword

[
  (number)
] @number

; Comments
(comment) @comment

; Operators

; Keywords
[ "async"
  "await"
  "class"
  "delete"
  "export"
  "from"
  "import"
  "as"
  ;"bigint"
  "break"
  "case"
  "catch"
  "const"
  "continue"
  "debugger"
  "default"
  "do"
  "else"
  "extends"
  "finally"
  "for"
  "function"
  "get"
  "if"
  "in"
  "instanceof"
  "let"
  "new"
  "of"
  "return"
  "set"
  "static"
  "switch"
  ;"this"
  "throw"
  "try"
  "typeof"
  ;"undefined"
  ;"unique"
  "var"
  "void"
  "while"
  "with"
  "yield"
] @keyword
