;; Original copy of this file: https://github.com/tree-sitter/tree-sitter-python/blob/master/queries/highlights.scm

(comment) @comment
(string) @string
(escape_sequence) @escape
(ellipsis) @operator
(attribute attribute: (identifier) @identifier)


;; module

(module . (expression_statement  (string) @comment))

;; ########

(identifier) @identifier


(expression_statement (assignment left: (identifier) @variable))

(typed_parameter (identifier) @variable.parameter)
(parameters (identifier) @variable.parameter)

;; the rule should be based on the first position of a classmethod or instance method, since 
;; they wont always be 'self' or 'cls'
;; first position paramater for methods e.g. (self, cls)
;; TODO: condense these two queries into one
((identifier) @selfReferenceParam (#match? @selfReferenceParam "^(self|cls)$"))
;;((identifier) @selfReferenceParam (#match? @selfReferenceParam "^(\\bself\\b|cls)$"))

;;((identifier) @constructor
 ;;(#match? @constructor "^[A-Z]"))

;;((identifier) @constant
 ;;(#match? @constant "^[A-Z][A-Z_]*$"))

; class definitions

(class_definition name: (identifier) @type)
(class_definition superclasses: (argument_list (identifier) @identifier))
(class_definition body: (block . (expression_statement  (string) @comment)))

; Function calls
(decorator) @function
(decorator (identifier) @function)
(keyword_argument name: (identifier) @variable.parameter)

(call function: (attribute attribute: (identifier) @function))
(call function: (identifier) @function)

; Builtin functions

((identifier) @function
 (#match?
   @function
   "^(abs|all|any|ascii|bin|bool|breakpoint|bytearray|bytes|callable|chr|classmethod|compile|complex|delattr|dict|dir|divmod|enumerate|eval|exec|filter|float|format|frozenset|getattr|globals|hasattr|hash|help|hex|id|input|int|isinstance|issubclass|iter|len|list|locals|map|max|memoryview|min|next|object|oct|open|ord|pow|print|property|range|repr|reversed|round|set|setattr|slice|sorted|staticmethod|str|sum|super|tuple|type|vars|zip|__import__)$")) 

; Function definitions

(function_definition body: (block . (expression_statement  (string) @comment)))

(function_definition
  name: (identifier) @function)

(
 (class_definition
   body: (block
           (function_definition 
              parameters: (parameters . (identifier) @selfReferenceParam)
              )
            
           )
   )
 )
;; non-static decorated methods have their first parameter targeted
(
 (class_definition
   body: (block
           (decorated_definition 
             (decorator (identifier) @decorator.identifier (#not-eq? @decorator.identifier "staticmethod"))
             definition: (function_definition 
                           parameters: (parameters . (identifier) @selfReferenceParam)
                           )

             )
           )
   )
 )
;; variable identifiers that are part of the parameters of their parent function should match highlighting
;; throughout that function, compare to an index set of param names, if its in there, true, else false
;;(identifier @name)(#eq? @name jkj)
;;(
;;(function_definition: parameters: (parameters) @parameters)
;;(function_definition: body: (block (identifier) @identifier))
;;(#any-of? @identifier @parameters)
;; )

;;(
;;  (function_definition
;;    parameters: (parameters (identifier) @param_name)
;;    body: (block (identifier) @identifier (#eq? @identifier @param_name))
;;  )
;;)
;; TODO: for this kind of functionality, we would need to create a lua script that interacts with the Treesitter API to generate a query dynamically.
;; This falls outside of treesitter's standard query syntax.

(generic_type (identifier) @type)
(type (identifier) @type)
(
  (type) ; This is the ancestor pattern. It matches any node of type 'type'.
  .      ; This is the descendant combinator.
  (identifier) @type ; This is the descendant pattern.
                                     ; It matches any 'identifier' node that is a descendant
                                     ; of the 'type' node found by the first part.
                                     ; The identifier itself is captured as @captured_identifier.
)
; Literals

[
  (none)
  (true)
  (false)
] @keyword

[
  (integer)
  (float)
] @number

;; (interpolation
;;   "{" @punctuation.special
;;   "}" @punctuation.special) @operator

[
  "["
  "]"
  "{"
  "}"
  ":"
  ")"
  "("
  "."
  "-"
  "-="
  "!="
  "*"
  "**"
  "**="
  "*="
  "/"
  "//"
  "//="
  "/="
  "&"
  "&="
  "%"
  "%="
  "^"
  "^="
  "+"
  ;;"->"
  "+="
  "<"
  "<<"
  "<<="
  "<="
  "<>"
  "="
  ":="
  "=="
  ">"
  ">="
  ">>"
  ">>="
  "|"
  "|="
  "~"
  "@="
] @operator

[
  "as"
  "assert"
  "async"
  "await"
  "break"
  "class"
  "continue"
  "def"
  "del"
  "elif"
  "else"
  "except"
  "exec"
  "finally"
  "for"
  "from"
  "global"
  "if"
  "import"
  "lambda"
  "nonlocal"
  "pass"
  "print"
  "raise"
  "return"
  "try"
  "while"
  "with"
  "yield"
  "match"
  "case"
  "and"
  "in"
  "is"
  "not"
  "or"
  "is not"
  "not in"
] @keyword

