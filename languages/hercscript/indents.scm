; Indent after opening braces
"{" @indent
; Dedent closing braces
"}" @outdent

; Indent control flow structures
(if_stmt) @indent
(for_stmt) @indent
(while_stmt) @indent
(do_while_stmt) @indent
(switch_stmt) @indent
(case_stmt) @indent
(block) @indent

; Indent script and function definitions
(script_def) @indent
(function_stmt) @indent

; Dedent closing braces
"}" @outdent
