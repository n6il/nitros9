         nam   BBS.convert
         ttl   program module       

* Disassembled 2010/01/24 10:53:58 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   462
size     equ   .
name     equ   *
         fcs   /BBS.convert/
L0018    fcb   $FF 
         fcb   $FF 
L001A    fcb   $42 B
         fcb   $42 B
         fcb   $53 S
         fcb   $2E .
         fcb   $6D m
         fcb   $73 s
         fcb   $67 g
         fcb   $2E .
         fcb   $69 i
         fcb   $6E n
         fcb   $78 x
         fcb   $0D 
start    equ   *
         leax  >L001A,pcr
         lda   #$03
         os9   I$Open   
         lbcs  L0054
         sta   ,u
L0035    lda   ,u
         leax  u0001,u
         ldy   #$003E
         os9   I$Read   
         lbcs  L0053
         leax  >L0018,pcr
         ldy   #$0002
         lda   ,u
         os9   I$Write  
         bra   L0035
L0053    clrb  
L0054    os9   F$Exit   
         emod
eom      equ   *
         end
