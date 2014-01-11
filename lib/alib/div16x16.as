*********************************************
* 16 x 16 bit integer divide

* OTHER MODULES NEEDED: none

* ENTRY: D = divisor
*        X = dividend

*  EXIT: X = quotient
*        D = remainder

 nam 16x16 bit Divide
 ttl Assembler Library Module


 section .bss
negcount rmb 1
 endsect

 section .text

* Signed Divide
SDIV16:
 clr negcount,u
 PSHS D,X
 tst ,s
 bpl testquo
 ldd ,s
 comb
 coma
 addd #$0001
 std ,s
 inc negcount,u
testquo
 tst 2,s
 bpl ok
 ldd 2,s
 comb
 coma
 addd #$0001
 std 2,s
 inc negcount,u
ok
 puls d,x
 bsr DIV16
 dec negcount,u
 bne goforit
 pshs d,x
 ldd ,s
 coma
 comb
 addd #$0001
 std ,s
 ldd 2,s
 coma
 comb
 addd #$0001
 std 2,s 
 puls d,x
goforit 
 rts
 

* Unsigned Divide
DIV16:
 PSHS D,X save divisor & dividend
 LDA #16 bit counter
 PSHS A
 CLRA initialize remainder
 CLRB

div1
 ASL 4,S shift dividend & quotient
 ROL 3,S
 ROLB shift dividend into B
 ROLA
 CMPD 1,S trial subtraction reqd?
 BLO div2
 SUBD 1,S yes, do subtraction
 INC 4,S increment quotient

div2
 DEC ,S count down another bit
 BNE div1
 LDX 3,S get quotient
 LEAS 5,S clean stack
 RTS

 endsect

