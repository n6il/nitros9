********************************************************************
* Boot - Dragon floppy boot module
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1r2    ????/??/??
* Original Dragon Data distribution version
*
* $Log$
* Revision 1.3  2003/08/30 20:16:51  boisy
* Made all modules rev 0
*
* Revision 1.2  2002/10/10 14:50:21  boisy
* Added appropriate header
*
* Revision 1.1  2002/07/18 19:46:07  roug
* We can now build a Dragon 64 kernel
*
* Revision 1.1  2002/04/21 21:27:50  roug
* These are the kernel modules from Dragon 64's OS9Boot.
* OS9 and OS9p2 are older than what's in ../MODULES so I checked them
* in as well.

         nam   Boot
         ttl   Dragon floppy boot module

* Disassembled 02/04/21 22:37:43 by Disasm v1.6 (C) 1988 by RML

         IFP1
         use   defsfile
         ENDC

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $02
edition  set   1

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
size     equ   .

name     fcs   /Boot/
         fcb   edition

* First, we make a stack...
start    clra  
         ldb   #size
MakeStak pshs  a
         decb  
         bne   MakeStak

         tfr   s,u
         ldx   #$FF40
u001F    lda   #$D0
u0021    sta   ,x
u0023    lbsr  L0178
         lda   ,x
         lda   >$FF22
         lda   #$FF
         sta   u0004,u
         leax  >L0105,pcr
         stx   >$010A
         lda   #$7E
         sta   >$0109
         lda   #$04
         sta   >$FF48

* delay loop
u0040    ldd   #$C350
L0043    nop   
         nop   
         subd  #$0001
u0048    bne   L0043

         pshs  u,x,b,a
         clra  
         clrb  
         ldy   #$0001
         ldx   <u001F+1
         ldu   <u0021+1
         os9   F$SchBit 
         bcs   L009C
         exg   a,b
         ldu   $04,s
         std   u0002,u
         clrb  
* go get LSN0
         ldx   #$0000
         bsr   L00B9
         bcs   L009C

* get bootfile size from LSN0 and allocate memory for it
         ldd   <$18,y
         std   ,s
         os9   F$SRqMem 
         bcs   L009C
         stu   $02,s
         ldu   $04,s
         ldx   $02,s
         stx   u0002,u
         ldx   <$16,y
         ldd   <$18,y
         beq   L0095

* this loop reads a sector at a time from the bootfile
L0083    pshs  x,b,a
         clrb  
         bsr   L00B9
         bcs   L009A
         puls  x,b,a
         inc   u0002,u
         leax  $01,x
         subd  #$0100
         bhi   L0083
L0095    clrb  
         puls  b,a
         bra   L009E
L009A    leas  $04,s
L009C    leas  $02,s
L009E    puls  u,x
         leas  $05,s
         rts   
L00A3    clr   ,u
         clr   u0004,u
         lda   #$05
L00A9    ldb   #$43
         pshs  a
         bsr   L00B6
         puls  a
         deca  
         bne   L00A9
         ldb   #$03
L00B6    lbra  L0164
L00B9    lda   #$91
         cmpx  #$0000
         bne   L00D1
         bsr   L00D1
         bcs   L00C8
         ldy   u0002,u
         clrb  
L00C8    rts   

L00C9    bcc   L00D1
         pshs  x,b,a
         bsr   L00A3
         puls  x,b,a
L00D1    pshs  x,b,a
         bsr   L00DC
         puls  x,b,a
         bcc   L00C8
         lsra  
         bne   L00C9
L00DC    bsr   L011B
         bcs   L00C8
         ldx   u0002,u
         orcc  #$50
         pshs  y,dp,cc
         lda   #$FF
         tfr   a,dp
         lda   #$34
         sta   <u0003
         lda   #$37
         sta   <u0023
         lda   <u0021+1
         ldb   #$88
         stb   <u0040
         ldb   #$24
         stb   <u0048
L00FC    sync  
         lda   <L0043
         ldb   <u0021+1
         sta   ,x+
         bra   L00FC
L0105    leas  $0C,s
         lda   #$04
         sta   <u0048
         lda   #$34
         sta   <u0023
         ldb   <u0040
         puls  y,dp,cc
         bitb  #$04
         beq   L015E
L0117    comb  
         ldb   #$F4
         rts   
L011B    clr   ,u
         tfr   x,d
         cmpd  #$0000
         beq   L0134
         clr   ,-s
         bra   L012B
L0129    inc   ,s
L012B    subd  #$0012
         bcc   L0129
         addb  #$12
         puls  a
L0134    incb  
L0135    stb   >$FF42
         bsr   L0178
         cmpb  >$FF42
         bne   L0135
         ldb   u0004,u
         stb   >$FF41
         cmpa  u0004,u
         beq   L015C
         sta   u0004,u
         sta   >$FF43
         ldb   #$13
         bsr   L0164
         pshs  x
         ldx   #$222E
L0156    leax  -$01,x
         bne   L0156
         puls  x
L015C    clrb  
         rts   
L015E    bitb  #$98
         bne   L0117
         clrb  
         rts   
L0164    bsr   L0176
L0166    ldb   >$FF40
         lsrb  
         bcs   L0166
         rts   
L016D    lda   #$04
         sta   >$FF48
         stb   >$FF40
         rts   
L0176    bsr   L016D
L0178    lbsr  L017B
L017B    lbsr  L017E
L017E    rts   

         emod
eom      equ   *
         end
