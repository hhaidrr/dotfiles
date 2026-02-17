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

[ "?."
  "."
  ":" 
  "?"
  "!"
  "+"
  "-"
] @operator

;primitive types
[ "boolean"
  "string"
  "number"
  "symbol"
  "any"
  "never"
  "object"
  "unknown"
  "void"
] @type

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
  "as"
  "asserts"
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
  "global"
  "if"
  "in"
  "infer"
  "instanceof"
  "is"
  "let"
  "module"
  "new"
  "of"
  "require"
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
  "while"
  "with"
  "yield"
] @keyword
