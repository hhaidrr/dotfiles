; Types
(this) @selfReferenceParam
(super) @selfReferenceParam
(type_annotation) @type
(type_identifier) @type

(identifier) @identifier
(property_identifier) @identifier

(call_expression function: (member_expression (property_identifier) @function))
(method_definition name: (property_identifier) @function)
((method_definition name: (property_identifier) @keyword) (#eq? @keyword "constructor"))

((identifier) @type
 (#match? @type "^[A-Z]"))

(type_arguments
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

; Variables

(variable_declarator name: (identifier) @variable.name)
(required_parameter (identifier) @variable.parameter)
(optional_parameter (identifier) @variable.parameter)

; Tags
; Opening tag brackets
(jsx_opening_element 
  ["<" ">"] @tag.bracket)

; Closing tag brackets (Matches <, /, and > individually)
(jsx_closing_element 
  ["</" ">"] @tag.bracket)

; Self-closing tag brackets
(jsx_self_closing_element
  ["<" "/>"] @tag.bracket)

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
["?."] @operator

; Keywords
[ "abstract"
  "async"
  "await"
  "class"
  "declare"
  "delete"
  "enum"
  "export"
  "from"
  "implements"
  "interface"
  "import"
  "keyof"
  "namespace"
  "private"
  "protected"
  "public"
  "type"
  "readonly"
  "override"
  "satisfies"
  "any"
  "as"
  "asserts"
  ;"bigint"
  "boolean"
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
  "global"
  "if"
  "in"
  "infer"
  "instanceof"
  "is"
  "let"
  "module"
  "never"
  "new"
  "number"
  "object"
  "of"
  "require"
  "return"
  "set"
  "static"
  "string"
  "switch"
  "symbol"
  ;"this"
  "throw"
  "try"
  "typeof"
  ;"undefined"
  ;"unique"
  "unknown"
  "var"
  "void"
  "while"
  "with"
  "yield"
] @keyword
