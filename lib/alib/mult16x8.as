***********************************

* 16 x 8 Multiply (24 bit result)

* OTHER MODULES NEEDED: none

* ENTRY: A = multiplier
*        X = multiplicand

*  EXIT: A = product byte 1
*        X = product bytes 2 & 3

 nam 16x8 bit Multiply
 ttl Assembler Library Module


 section .text
 
MULT168:
 PSHS A,X save numbers
 LEAS -3,S room for product
 LDB 5,S get lsb of multiplicand
 MUL
 STD 1,S save partial product
 LDD 3,S get mupltiplier & msb of multp.
 MUL
 ADDB 1,S add lsb to msb
 ADCA #0 add carry
 STD 0,S save sum of partial products
 LDX 1,S get 2 lsb's
 LEAS 6,S clean stack
 RTS

 endsect

