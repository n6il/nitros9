;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; signal
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/07/02  Boisy G. Pitre
; Started

           .title   Signal definitions

           .area   sys (ABS)

           .org    0

S$Kill::   .byte   1          ; Non-Interceptable Abort
S$Wake::   .byte   1          ; Wake-up Sleeping Process
S$Abort::  .byte   1          ; Keyboard Abort
S$Intrpt:: .byte   1          ; Keyboard Interrupt
S$Window:: .byte   1          ; Window Change
S$Alarm::  .byte   1          ; CoCo individual process' alarm signal

