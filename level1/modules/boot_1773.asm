********************************************************************
* Boot - WD1773 Boot module
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   4      1985/??/??   
* Original Tandy distribution version.
*
*   6      1998/10/12  Boisy G. Pitre
* Obtained from L2 Upgrade archive, has 6ms step rate and disk timeout
* changes.
*
*   6r2    2003/05/18  Boisy G. Pitre
* Added '.' output for each sector for OS-9 L2 and NitrOS9 for
* Mark Marlette (a special request :).
*
*   6r3    2003/08/31  Robert Gault
* Put BLOB-stop code in place, changed orb #$30 to orb #$28

         nam   Boot
         ttl   WD1773 Boot module

         IFP1
         use   defsfile
         use   rbfdefs
         ENDC

* Step Rate:
*      $00  = 6ms
*      $01  =
*      $02  =
*      $03  = 30ms
STEP     set   $00

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $03
edition  set   6

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   2
u0004    rmb   1
u0005    rmb   1
u0006    rmb   1
u0007    rmb   1
u0008    rmb   1
u0009    rmb   1
size     equ   .

name     fcs   /Boot/
         fcb   edition

start    clra			clear A
         ldb   #size		get our 'stack' size
MakeStak pshs  a		save 0 on stack
         decb			and continue...
         bne   MakeStak		until we've created our stack

         tfr   s,u		put 'stack statics' in U
         ldx   #DPort+8
         lda   #$D0
         sta   ,x
         lbsr  L01AA
         lda   ,x
         lda   #$FF
         sta   u0004,u
         leax  >NMIRtn,pcr
         IFGT  Level-1
         stx   <D.NMI
         lda   #$09
         ELSE
         stx   >D.XNMI+1
         lda   #$7E
         sta   >D.XNMI
         lda   #$08
         ENDC
         sta   >DPort

* delay loop
         IFGT  Level-1
         ldd   #$C350
         ELSE
         ldd   #$61A8
         ENDC
         IFNE  NitrOS9
         nop
         ENDC
L003A    nop
         nop
         IFNE  NitrOS9
         nop
         nop
         nop
         ENDC
         subd  #$0001
         bne   L003A

* search for a free page (to use as a 256 byte disk buffer)
         pshs  u,y,x,b,a
         ldd   #$0001
         os9   F$SRqMem
         bcs   L00AA
         tfr   u,d
         ldu   $06,s
         std   u0002,u
         clrb

* go get LSN0
         ldx   #$0000
         bsr   ReadSect
         bcs   L00AA

* get bootfile size from LSN0 and allocate memory for it
         ldd   DD.TOT+1,y
         std   u0007,u
         lda   <DD.FMT,y
         sta   u0005,u
         anda  #$01
         sta   u0008,u
         lda   DD.TKS,y
         sta   u0006,u
         ldd   <DD.BSZ,y
         std   ,s
         ldx   <DD.BT+1,y
         pshs  x
         ldd   #256
         ldu   u0002,u
         os9   F$SRtMem
         ldd   $02,s
         IFGT  Level-1
         os9   F$BtMem
         ELSE
         os9   F$SRqMem
         ENDC
         puls  x
         bcs   L00AA
         stu   $02,s
         ldu   $06,s
         ldd   $02,s
         std   u0002,u
         ldd   ,s
         beq   L00A3

* this loop reads a sector at a time from the bootfile
L0091    pshs  x,b,a
         clrb
         bsr   ReadSect
         bcs   L00A8
         IFGT  Level-1
         lda   #'.		dump out a period for boot debugging
         jsr   <D.BtBug		do the debug stuff     
         ENDC
         puls  x,b,a
         inc   u0002,u
         leax  1,x
         subd  #256
         bhi   L0091
L00A3    clrb
         puls  b,a
         bra   L00AC
L00A8    leas  $04,s
L00AA    leas  $02,s
L00AC    puls  u,y,x
         leas  size,s		clean up stack
         clr   >DPort		shut off floppy disk
         rts

L00B7    lda   #$29
         sta   ,u
         clr   u0004,u
         lda   #$05
         lbsr  L0170
         ldb   #STEP
         lbra  L0195

* Read a sector from the 1773
* Entry: X = LSN to read
ReadSect lda   #$91
         cmpx  #$0000		LSN0?
         bne   L00DF
         bsr   L00DF
         bcs   L00D6
         ldy   u0002,u
         clrb
L00D6    rts

L00D7    bcc   L00DF
         pshs  x,b,a
         bsr   L00B7
         puls  x,b,a
L00DF    pshs  x,b,a
         bsr   L00EA
         puls  x,b,a
         bcc   L00D6
         lsra
         bne   L00D7
L00EA    bsr   L013C
         bcs   L00D6
         ldx   u0002,u
         orcc  #IntMasks
         pshs  y
         ldy   #$FFFF
         ldb   #$80
         stb   >DPort+8
         ldb   ,u
* Notes on the next line:
* The byte in question comes after telling the controller that it should
* read a sector. RegB is then loaded (ldb ,u) which means it is set to $29
* (%00101001) or the default boot drive if sub L00B7 has been run. At this
* point an orb #$30 or orb #%00110000 means that write precomp and double
* density flags are or'd in. This does not make any sense at all for a
* read command. I suppose the command may not even be needed but $28 just
* ensures that motor on and double density are set.
*         orb   #$28		was $30 which RG thinks is an error
* 09/02/03: Futher investigation shows that the OS-9 Level One Booter will
* FAIL if orb #$28 is used.  It does not fail if orb #$30 is used. ????
         orb   #$30		was $30 which RG thinks is an error
         tst   u0009,u
         beq   L0107
         orb   #$40
L0107    stb   >DPort
         lbsr  L01AA
         orb   #$80
*         lda   #$02
*L0111    bita  >DPort+8
*         bne   L0123
*         leay  -$01,y
*         bne   L0111
*         lda   ,u
*         sta   >DPort
*         puls  y
*         bra   L0138
         stb   >DPort
         nop
         nop
         bra   L0123
L0123    lda   >DPort+$0B
         sta   ,x+
*         stb   >DPort
         nop
         bra   L0123

NMIRtn   leas  R$Size,s
         puls  y
         ldb   >DPort+8
         bitb  #$04
         beq   L018F
L0138    comb
         ldb   #E$Read
         rts

L013C    lda   #$09
         sta   ,u
         clr   u0009,u
         tfr   x,d
         cmpd  #$0000
         beq   L016C
         clr   ,-s
         tst   u0008,u
         beq   L0162
         bra   L0158
L0152    com   u0009,u
         bne   L0158
         inc   ,s
L0158    subb  u0006,u
         sbca  #$00
         bcc   L0152
         bra   L0168
L0160    inc   ,s
L0162    subb  u0006,u
         sbca  #$00
         bcc   L0160
L0168    addb  #$12
         puls  a
L016C    incb
         stb   >DPort+$0A
L0170    ldb   u0004,u
         stb   >DPort+$09
         cmpa  u0004,u
         beq   L018D
         sta   u0004,u
         sta   >DPort+$0B
         ldb   #$10+STEP
         bsr   L0195
         pshs  x
         ldx   #$222E
L0187    leax  -$01,x
         bne   L0187
         puls  x
L018D    clrb
         rts
L018F    bitb  #$98
         bne   L0138
         clrb
         rts
L0195    bsr   L01A8
L0197    ldb   >DPort+8
         bitb  #$01
         bne   L0197
         rts
L019F    lda   ,u
         sta   >DPort
         stb   >DPort+$08
         rts
L01A8 
         IFNE  NitrOS9
         nop
         ENDC
         bsr   L019F
L01AA  
         IFNE  NitrOS9
         nop
         nop
         ENDC
         lbsr  L01AD
L01AD 
         IFNE  NitrOS9
         nop
         nop
         ENDC
         lbsr  L01B0
L01B0 
         IFNE  NitrOS9
         nop
         ENDC
         rts

         IFGT  Level-1
* Filler to get $1D0
Filler   fill  $39,$1D0-3-*
         ENDC

         emod
eom      equ   *
         end

