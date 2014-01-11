****************************************

* DECIMAL to BINARY conversion routine

* OTHER MODULES NEEDED: DECTAB$, IS_TERMIN

* ENTRY: X = start of asci decimal string terminated by
*            a space, comma, CR or null.

* EXIT: D = binary value
*       CC carry set if error (too large, not numeric)
*       Y = terminator or error char.

 nam Convert Decimal String to Binary
 ttl Assembler Library Module


 section .bss
nega rmb 1
 endsect

 section .text

DEC_BIN:
 clra set result to 0
 clrb
 pshs a,b,x
 leas -1,s temp variable

 clr nega,u
 ldb ,x+
 cmpb #'-
 bne decbn15
 stb nega,u
decbn1
 LDB ,X+ get a digit
decbn15
 LBSR IS_DIGIT
 bne decbn3 end of string...
 INCA bump string len
 BRA decbn1 loop for whole string

decbn3
 lbsr IS_TERMIN valid terminator?
 bne error

ok
 TSTA length = 0?
 BEQ error yes, error
 CMPA #6 more than 6 chars?
 BHI error yes, error

 ldx 3,s get start of string again

 PSHS A
 lda ,x
 cmpa #'-
 bne decbn35
 leax 1,x
decbn35 
 LDA #5 max length
 SUBA ,S+ adjust for offset
 ASLA 2 bytes per table entry
 LEAY DECTAB$,PCR addr of conversion table
 LEAY A,Y add in offset for actual len

decbn4
 LDA ,X+ get a digit
 SUBA #$30 strip off ASCII
 BEQ decbn6 zero, skip
 sta ,s save digit=# of adds
 LDD 1,S get binary data

decbn5
 ADDD ,Y add in table value
 BCS error past 0, too big
 DEC ,S count down digit size
 BNE decbn5 loop til 0
 STD 1,S save binary data


decbn6
 LEAY 2,Y next entry
 tst 1,y end of table?
 BNE decbn4 loop til done
 clr ,s+ clean up and clear carry
 bra exit


error
 clr 0,s force data = 0
 clr 1,s
 com ,s+ clean up and set carry

exit
 tfr x,y end of string/error char
 puls a,b,x
 bcs leave
 tst nega,u
 beq leave
 subd #$0001
 coma
 comb
 andcc #$FE
leave
 rts


 endsect

