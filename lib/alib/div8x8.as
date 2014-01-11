*********************************
* 8 x 8 Divide

* OTHER MODULES NEEDED: none

* ENTRY: A = divisor
*        B = dividend

*  EXIT: A = remainder
*        B = quotient

 nam 8x8 bit Divide
 ttl Assembler Library Module


 section .bss
negcount rmb 1
 endsect

 section .text

* Signed Divide
SDIV88:
 clr negcount,u
 PSHS D
 tst ,s
 bpl testquo
 lda ,s
 coma
 inca
 sta ,s
 inc negcount,u
testquo
 tst 1,s
 bpl ok
 ldd 1,s
 coma
 adda #$01
 std 1,s
 inc negcount,u
ok
 puls d
 bsr DIV88
 dec negcount,u
 bne goforit
 pshs d
 lda ,s
 coma
 inca
 sta ,s
 lda 1,s
 coma
 inca
 sta 1,s 
 puls d
goforit
 rts


DIV88:
 PSHS A save divisor
 LDA #8 bit counter
 PSHS A
 CLRA initialize remainder

div1
 ASLB shift dividend & quotient
 ROLA
 CMPA 1,S trial subtraction needed
 BLO div2
 SUBA 1,S
 INCB

div2
 DEC 0,S count down # of bits
 BNE div1
 LEAS 2,S clean up stack
 RTS

 endsect
 
