;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; m6809
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/05/17  Boisy G. Pitre
; Started.

           .title  Motorola 6809 Definitions

; Motorola 6809 Register Definitions
R$CC     ==      0          ; Condition Codes register
R$A      ==      1          ; A Accumulator
R$B      ==      2          ; B Accumulator
R$D      ==      R$A        ; Combined A:B Accumulator
R$DP     ==      3          ; Direct Page register
R$X      ==      4          ; X Index register
R$Y      ==      6          ; Y Index register
R$U      ==      8          ; User Stack register
R$PC     ==      10         ; Program Counter register
R$Size   ==      12         ; Total register package size


; Condition Code Definitions
Entire   ==     0b10000000  ; Full Register Stack flag
FIRQMask ==     0b01000000  ; Fast-Interrupt Mask bit
HalfCrry ==     0b00100000  ; Half Carry flag
IRQMask  ==     0b00010000  ; Interrupt Mask bit
Negative ==     0b00001000  ; Negative flag
Zero     ==     0b00000100  ; Zero flag
TwosOvfl ==     0b00000010  ; Two's Comp Overflow flag
Carry    ==     0b00000001  ; Carry bit
IntMasks ==     IRQMask+FIRQMask
Sign     ==     0b10000000  ; sign bit
