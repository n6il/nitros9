********************************************************************
* progname - program module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Basic09 from Dragon Data distribution version
*
* $Log$
* Revision 1.1  2002/04/06 14:47:31  roug
* Prego; The basic09 interpreter.
*
*

         nam   Inkey
         ttl   subroutine module    

* Disassembled 02/04/06 16:39:17 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   /dd/defs/os9defs
         endc
tylg     set   Sbrtn+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   0
size     equ   .
name     equ   *
         fcs   /Inkey/
start    equ   *
         leax  $04,s
         ldd   $02,s
         cmpd  #$0001
         beq   L0033
         cmpd  #$0002
         bne   L0057
         ldd   [<$04,s]
         ldx   $06,s
         leax  -$01,x
         beq   L0031
         leax  -$01,x
         bne   L0057
         tfr   b,a
L0031    leax  $08,s
L0033    ldu   $02,x
         ldx   ,x
         ldb   #$FF
         stb   ,x
         cmpu  #$0002
         bcs   L0043
         stb   $01,x
L0043    ldb   #$01
         os9   I$GetStt 
         bcs   L0052
         ldy   #$0001
         os9   I$Read   
         rts   
L0052    cmpb  #$F6
         bne   L0059
         rts   
L0057    ldb   #$38
L0059    coma  
         rts   
         emod
eom      equ   *
