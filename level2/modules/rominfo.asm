********************************************************************
* ROMInfo - OS-9 Level Two ROM Relocation Code
*
* $Id$
*
* Executed at $8015 from ROM
*
* Additional annotation Robert Gault 6/9/98
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Created                                        BGP 98/05/03

         nam   ROMInfo
         ttl   OS-9 Level Two ROM boot module

         ifp1  
         use   defsfile
         endc  

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   1

         ifne  ROMPak
         jmp   $C000+start
         endc

         mod   eom,name,tylg,atrv,start,size

size     equ   .

name     fcs   /ROMInfo/
         fcb   edition

start    equ   *

* Bring the CoCo 3 to sanity
         orcc  #IntMasks  disable FIRQ, IRQ
         clr   $FFD9      go into fast mode
         lda   #$0A       CC3 Mode, No MMU, 32K Int. ROM
         sta   $FF90
         clr   $FFDE      RAM/ROM mode (upper 16K ROM at $C000)

* Setup MMU
         ldx   #DAT.Regs
         leay  MMUTbl,pcr
         ldb   #16

MMULoop  lda   ,y+
         sta   ,x+
         decb  
         bne   MMULoop

* Set up CoCo 3 Video Registers at $FF98-$FF9F
         ldd   #$0000
         std   $FF98
         std   $FF9A
         std   $FF9E
         ldd   #$0FE0
         std   $FF9C

* Initialize PIAs
         ldx   #PIA1Base  RG - Initialize the PIA 1
         ldd   #$FF34
         clr   1,x
         clr   3,x
         deca  
         sta   ,x
         lda   #$F8
         sta   2,x
         stb   1,x
         stb   3,x
         clr   2,x
         lda   #$02
         sta   ,x

         lda   #$FF       RG - Initialize the PIA 0
         ldx   #PIA0Base
         clr   1,x
         clr   3,x
         clr   ,x
         sta   2,x
         stb   1,x
         stb   3,x

         tfr   b,dp
         clr   2,x


         lda   #$CA       RG - CC2 mode, MMU, constant DRAM, 32K internal ROM
         sta   $FF90

         bra   RelROM

* MMU
MMUTbl         
         fcb   $38,$39,$3A,$3B,$3C,$3D,$3E,$3F
         fcb   $38,$39,$3A,$3B,$3C,$3D,$3E,$3F


* ROM relocation code -- copies the boot track into $2600 and JMPs to it
RelROM   ldx   #$EC00     src address (boot track in ROM)
         ldy   #$2600     dst address (RAM)
copyloop ldd   ,x++       get 2 bytes from src
         std   ,y++       put 2 bytes to dst
         cmpx  #$EC00+$1200 at end?
         blo   copyloop   nope, copy more...
         jmp   $2602      jump to OS rel code

         emod  
eom      equ   *
         end   
