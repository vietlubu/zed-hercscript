; Outline structure for Hercules Script

; Script definitions
(script_def
  npc_name: (npc_name) @name) @item

; Function calls (as context)
(function_call
  (identifier) @name) @context

; Control flow structures
(if_stmt) @context
(switch_stmt) @context
(for_stmt) @context
(while_stmt) @context

; Labels
(label) @name
