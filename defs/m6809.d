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

         .area   M6809 (ABS)

         .org    0
R$CC::   .rmb    1          ; Condition Codes register
R$A::    .rmb    2          ; A Accumulator
R$B::    .rmb    2          ; B Accumulator
R$D      ==      R$A        ; Combined A:B Accumulator
         .ifdef  H6309
R$E::    .rmb   1           ; E Accumulator
R$F::    .rmb   1           ; F Accumulator
R$W      ==     R$E         ; Combined E:F Accumulator
R$Q      ==     R$A         ; Combined A:B:E:F Accumulator
         .endif
R$DP::   .rmb   1           ; Direct Page register
R$X::    .rmb   2           ; X Index register
R$Y::    .rmb   2           ; Y Index register
R$U::    .rmb   2           ; User Stack register
R$PC::   .rmb   2           ; Program Counter register
R$Size   ==     .           ; Total register package size

; MD register masks
; 6309 definitions
DIV0     ==     0b10000000  ; division by 0 trap flag       : 1 = trap occured
badinstr ==     0b01000000  ; illegal instruction trap flag : 1 = trap occured

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
