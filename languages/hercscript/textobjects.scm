; Text objects for Hercules Script
; Ultra-minimal version to avoid pattern errors

; Functions
(function_stmt) @function.around

; Scripts
(script_def) @function.around

; Control flow
(if_stmt) @function.around
(switch_stmt) @function.around
(for_stmt) @function.around
(while_stmt) @function.around
