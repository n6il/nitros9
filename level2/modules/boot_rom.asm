********************************************************************
* Boot - OS-9 Level Two ROM Boot module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Created                                        BGP 98/??/??

         nam   Boot
         ttl   OS-9 Level Two ROM Boot module

         ifp1
         use   defsfile
         endc

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   1

         mod   eom,name,tylg,atrv,start,size

size     equ   .

name     fcs   /Boot/
         fcb   edition

start    equ   *
* obtain bootfile size at known offset
         pshs  u,y,x,a,b,cc
         orcc  #IntMasks       mask interrupts

* allocate memory from system
* memory will start at $8000, blocks 1, 2, 3 and 3F
* we allocate $100 bytes more so that the memory will start
* exactly at $8000
         ldd   #$8000-$1300
         os9   F$BtMem
         bcs   Uhoh

         stu   3,s                     save pointer in X on stack
         std   1,s                     save size in D on stack

* TRICK!  Map block 4 into $4000, copy our special ROM copy code
*         there, then jmp to it!
         lda   $FFA2
         pshs  a
         lda   #$04
         sta   $FFA2
         ldd   #RelCodeL               code less than 256 bytes
         leax  RelCode,pcr
         ldy   #$4800
Copy     lda   ,x+
         sta   ,y+
         decb
         bne   Copy

Jump     jsr   $4800                   * jump to rel code
         puls  a                       restore original block at $4000
         sta   $FFA2

* Upon exit, we return to the kernel with:
*    X  = address of bootfile
*    D  = size of bootfile
*    CC = carry cleared
ExitOK   andcc #^Carry                 clear carry
Uhoh     puls  u,y,x,a,b,cc,pc


* this code executes at $4800
RelCode  equ   *
         lda   #$4E                    CC3 mode, MMU, 32K ROM
         sta   $FF90
         sta   $FFDE                   ROM/RAM mode

* Map ROM Blocks in
         ldd   #$3C3D
         std   $FFA4
         lda   #$3E
         sta   $FFA6

* Map block 1 at $6000
         lda   $FFA3
         pshs  a
         lda   #$01
         sta   $FFA3
* Copy first 8K of ROM
         ldx   #$8000
         ldy   #$6000
Loop1    ldd   ,x++
         std   ,y++
         cmpx  #$A000
         blt   Loop1

* Map block 2 at $6000
         lda   #$02
         sta   $FFA3
* Copy second 8K of ROM
         ldx   #$A000
         ldy   #$6000
Loop2    ldd   ,x++
         std   ,y++
         cmpx  #$C000
         blt   Loop2

* Map block 3 at $6000
         lda   #$03
         sta   $FFA3
* Copy third 8K of ROM
         ldx   #$C000
         ldy   #$6000
Loop3    ldd   ,x++
         std   ,y++
         cmpx  #$E000
         blt   Loop3

* Copy remaining ROM area ($8000-$1400)
         lda   #$3F
         sta   $FFA3
         ldx   #$E000
         ldy   #$6000
Loop4    clr   $FFDE                   put in ROM/RAM mode to get byte
         ldd   ,x++
         clr   $FFDF                   put back in RAM mode to store byte
         std   ,y++
         cmpx  #$EC00
         blt   Loop4
*         ldx   #$6000
*         ldy   #$E000
*Loop5    ldd   ,x++
*         std   ,y++
*         cmpx  #$6C00
*         blt   Loop5

         lda   D.HINIT                 restore GIME HINIT value
         sta   $FF90
         puls  a                       restore org block at $6000
         sta   $FFA3
         lda   #$03
         sta   $FFA6
         ldd   #$0102
         std   $FFA4
         rts

RelCodeL equ   *-RelCode

* Fillers to get to $1D0
         fcc   /99999999999999999999999999999999999999999999999999/
*         fcc   /99999999999999999999999999999999999999999999999999/
*         fcc   /99999999999999999999999999999999999999999999999999/
         fcc   /99999999999999999999999999999999999999999999999999/
         fcc   /99999999999999999999999999999999999999999999999999/
         fcc   /99999999999999999999999999999999999999999999999999/
         fcc   /999999999999999999999999999999999999999999999999999/

         emod
eom      equ   *
         end
