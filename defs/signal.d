;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; signal - Signal Definitions
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/07/02  Boisy G. Pitre
; Created.

           .title   Signal Definitions

           .area    sys (ABS)

S$Kill     ==      0          ; Non-Interceptable Abort
S$Wake     ==      1          ; Wake-up Sleeping Process
S$Abort    ==      2          ; Keyboard Abort
S$Intrpt   ==      3          ; Keyboard Interrupt
S$Window   ==      4          ; Window Change
S$Alarm    ==      5          ; CoCo individual process' alarm signal

