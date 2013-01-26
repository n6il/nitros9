************************************

* 16 x 16 Multiply

* ENTRY: D = multiplier
*        X = multiplicand

*  EXIT: Y = product 2 msbs
*        U =    "    2 lsbs
*        D & X preserved

 nam 16x16 bit Multiply
 ttl Assembler Library Module


 section .text

MULT16:
 PSHS D,X,Y,U save #s and make stack room
 CLR 4,S reset overflow flag
 LDA 3,S get byte
 MUL
 STD 6,S save B x Xl
 LDD 1,S
 MUL B x Xh
 ADDB 6,S
 ADCA #0
 STD 5,S add 1st 2 mult.
 LDB 0,S
 LDA 3,S
 MUL A x Xl
 ADDD 5,S
 STD 5,S add result to previous
 BCC no.ov branch if no overflow
 INC 4,S set overflow flag

no.ov
 LDA 0,S
 LDB 2,S
 MUL A x Xh
 ADDD 4,S
 STD 4,S
 PULS D,X,Y,U,PC return

 endsect

 
