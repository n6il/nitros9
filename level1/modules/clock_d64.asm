********************************************************************
* Clock - Dragon clock module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Dragon Data distribution version

         nam   Clock
         ttl   Dragon clock module

* Disassembled 02/04/21 22:37:44 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $00

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   0
size     equ   .
name     equ   *
         fcs   /Clock/
         fcb   $02 
L0013    fcb   $15 
         fcb   $00 
         fcb   $82 
         fcb   $80 
         fcb   $00 
         fcb   $1F 
         fcb   $1C 
         fcb   $1F 
         fcb   $1E 
         fcb   $1F 
         fcb   $1E 
         fcb   $1F 
         fcb   $1F 
         fcb   $1E 
         fcb   $1F 
         fcb   $1E 
         fcb   $1F 
L0024    fcb   $4F O
         fcb   $1F 
         fcb   $8B 
         fcb   $0A 
         fcb   $59 Y
         fcb   $26 &
         fcb   $46 F
         fcb   $DC \
         fcb   $57 W
         fcb   $5C \
         fcb   $C1 A
         fcb   $3C <
         fcb   $25 %
         fcb   $39 9
         fcb   $4C L
         fcb   $81 
         fcb   $3C <
         fcb   $25 %
         fcb   $33 3
         fcb   $DC \
         fcb   $55 U
         fcb   $5C \
         fcb   $C1 A
         fcb   $18 
         fcb   $25 %
         fcb   $29 )
         fcb   $4C L
         fcb   $30 0
u0040    fcb   $8D 
         fcb   $FF 
         fcb   $D4 T
         fcb   $D6 V
         fcb   $54 T
         fcb   $C1 A
         fcb   $02 
         fcb   $26 &
u0048    fcb   $09 
         fcb   $D6 V
         fcb   $53 S
         fcb   $27 '
         fcb   $05 
         fcb   $C4 D
         fcb   $03 
         fcb   $26 &
u0050    fcb   $01 
         fcb   $4A J
         fcb   $D6 V
u0053    fcb   $54 T
         fcb   $A1 !
u0055    fcb   $85 
         fcb   $23 #
u0057    fcb   $0E 
         fcb   $DC \
u0059    fcb   $53 S
u005A    fcb   $5C \
u005B    fcb   $C1 A
         fcb   $0D 
         fcb   $25 %
         fcb   $03 
         fcb   $4C L
         fcb   $C6 F
         fcb   $01 
         fcb   $DD ]
         fcb   $53 S
         fcb   $86 
         fcb   $01 
         fcb   $5F _
         fcb   $DD ]
         fcb   $55 U
         fcb   $4F O
         fcb   $5F _
         fcb   $DD ]
         fcb   $57 W
         fcb   $96 
         fcb   $5A Z
         fcb   $97 
         fcb   $59 Y
         fcb   $6E n
         fcb   $9F 
         fcb   $00 
         fcb   $81 
start    equ   *
         pshs  dp,cc
         clra  
         tfr   a,dp
         lda   #$32
         sta   <u005A
         sta   <u0059
         lda   #$05
         sta   <u005B
         sta   <u0048
         orcc  #$50
         leax  >L0024,pcr
         stx   >$006B
         leay  >L0013,pcr
         os9   F$SSvc   
         puls  pc,dp,cc
         ldx   $04,u
         ldd   <u0053
         std   ,x
         ldd   <u0055
         std   $02,x
         ldd   <u0057
         std   $04,x
         clrb  
         rts   
         emod
eom      equ   *
