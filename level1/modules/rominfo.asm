********************************************************************
* ROMInfo - OS-9 Level One ROM boot module
*
* $Id$
*
* ROM Relocation code for OS-9 Level One Vr. 2.00
* Executed at $8015 from ROM
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Created                                        BGP 98/05/03

         nam   ROMInfo
         ttl   OS-9 Level One ROM boot module

         ifp1
         use   defsfile
         endc

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   $01

         mod   eom,name,tylg,atrv,start,size

size     equ   .

name     fcs   /ROMInfo/
         fcb   edition

start    equ   *
CCInit   ldx   #PIA.U8                 PIA1
         clr   -3,x                    clear PIA0 Control Register A
         clr   -1,x                    clear PIA0 Control Register B
         clr   -4,x                    set PIA0 side A to input
         ldd   #$FF34
         sta   -2,x                    set PIA0 side B to output
         stb   -3,x                    enable PIA0 peripheral reg, disable PIA0
         stb   -1,x                    MPU interrupts, set CA2, CA1 to outputs
         clr   1,x                     $FF20 = DDR, motoroff
         clr   3,x                     $FF22 = DDR, sound disabled
         deca                          A = $FE after deca
         sta   ,x                      bits 1-7 are outputs, bit 0 is input on PIA1 side A
         lda   #$F8
         sta   2,x                     bits 0-2 are inputs, bits 3-7 are outputs on B side
         stb   1,x                     enable peripheral registers, disable PIA1 MPU
         stb   3,x                     interrupts and set CA2, CB2 as outputs
         clr   2,x                     set 6847 mode to alphanumeric
         ldb   #$02
         stb   ,x                      make RS-232 output marking
         clrb
         tfr   b,dp                    B = 0
         ldb   #$04
         clr   -2,x
         bitb  2,x

         lda   #$37
         sta   PIA.U8+3

         lda   PIA.U4+3
         ora   #$01
         sta   PIA.U4+3

         lda   PIA.U8+2
         anda  #$07
         sta   PIA.U8+2

* VDG Mode
         sta   $FFC0
         sta   $FFC2
         sta   $FFC4

* 64K DRAM (M0=0, M1=1)
         sta   $FFDA                   RESET M0
         sta   $FFDD                   SET   M1

* ROM relocation code -- copies the boot track into $2600
RelROM   ldx   #$AE00                  src address (ROM)
         ldy   #$2600                  dst address (RAM)
copyloop ldd   ,x++                    get 2 bytes from src
         std   ,y++                    put 2 bytes to dst
         cmpx  #$AE00+$1200            at end?
         blo   copyloop                nope, copy more...
* BOOT relocation code -- copies the bootfile into $2600+$1200
RelBOOT  ldx   #$8000
         ldy   #$2600+$1200
cpy2loop ldd   ,x++
         std   ,y++
         cmpx  #$8000+$2E00
         blo   cpy2loop
         jmp   $2602                   jump to OS rel code

         emod
eom      equ   *
         end
