;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; const
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/05/17  Boisy G. Pitre
; Started.

           .title   Constant Character Definitions

C$NULL     ==     0h00        ; Null char
C$RPET     ==     0h01        ; (CTRL-A - SOH) Repeat last input line
C$INTR     ==     0h03        ; (CTRL-C - ETX) Keyboard interrupt
C$RPRT     ==     0h04        ; (CTRL-D - EOT) Reprint current input line
C$QUIT     ==     0h05        ; (CTRL-E - ENQ) Keyboard Abort
C$BELL     ==     0h07        ; (CTRL-G - BEL) Line overflow warning
C$BSP      ==     0h08        ; (CTRL-H - BS ) Back space
C$RARR     ==     0h09        ; Right Arrow
C$EL       ==     0h05        ; Erase Line
C$LF       ==     0h0A        ; Line feed
C$HOME     ==     0h0B        ; Home position Code
C$Clsgr    ==     0h15        ; Graphic screen clear (use FM-11)
C$Clsall   ==     0h16        ; Graphic & character clear (use FM-11)
C$CR       ==     0h0D        ; Carriage return
C$FORM     ==     0h0C        ; (CTRL-L - FF ) Form Feed ... screen clear
C$SI       ==     0h0F        ; Shift IN Code
C$SO       ==     0h0E        ; Shift OUT Code
C$DELETE   ==     0h10        ; Delete char (for SCF enhanced line editing)
C$XON      ==     0h11        ; (CTRL-Q - DC1) Transmit Enable
C$INSERT   ==     C$XON       ; Insert char (for SCF enhanced line editing)
C$XOFF     ==     0h13        ; (CTRL-S - DC3) Transmit Disable
C$PLINE    ==     C$XOFF      ; Print remaining line (for SCF enhanced line editing)
C$PAUS     ==     0h17        ; (CTRL-W - ETB) Pause character
C$DEL      ==     0h18        ; (CTRL-X - CAN) Delete line
C$SHRARR   ==     0h19        ; Shift Right-Arrow
C$EOF      ==     0h1B        ; (CTRL-[ - ESC) END of file
C$RGT      ==     0h1C        ; Cursor right
C$LFT      ==     0h1D        ; Cursor left
C$UP       ==     0h1E        ; Cursor up
C$DWN      ==     0h1F        ; Cursor down
C$SPAC     ==     0h20        ; Space
C$PERD     ==     '.
C$COMA     ==     ',


