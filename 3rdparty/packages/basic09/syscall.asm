********************************************************************
* SysCall - system call subroutine module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   2    From OS-9 Level Two Vr. 2.00.01 Basic09 disk

         nam   SysCall
         ttl   system call subroutine module

* Disassembled 02/07/06 13:11:18 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Sbrtn+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   2

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   0
size     equ   .

name     fcs   /SysCall/
         fcb   edition

start    ldd   $02,s		get number of parameters
         cmpd  #$0002		two?
         bne   L005C		if not, error
         ldd   $0A,s		get size of second parameter
*         cmpd  #R$PC		appropriate registers?
         cmpd  #$0A		appropriate registers?
         bne   L005C		branch if not
         ldd   [<$04,s]		get address of first parameter
         ldx   $06,s		get size of first parameter
         leax  -$01,x
         beq   L0034
         leax  -$01,x
         bne   L005C
         tfr   b,a
L0034    ldb   #$39		get rts
         pshs  b,a		put it and os9 func code on stack
         ldd   #$103F		get SWI2 instruction
         pshs  b,a		put on stack
         ldu   $0C,s		get pointer to caller's registers on stack
         ldd   R$D,u		
         ldx   R$X,u
         ldy   R$Y,u
         ldu   R$U,u
         jsr   ,s               branch to subroutine
         pshs  u,cc
         ldu   $0F,s
         leau  R$U,u
         pshu  y,x,dp,b,a
         puls  x,a
         sta   ,-u
         stx   $08,u
         leas  $04,s
         clrb  
         rts   

L005C    comb  
         ldb   #E$ParmEr
         rts   

         emod
eom      equ   *
         end
