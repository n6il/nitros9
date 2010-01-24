********************************************************************
* SCF - OS-9 Level One V2 SCF file manager
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  10      ????/??/??
* From Tandy OS-9 Level One VR 02.00.00
*
*  11      2010/01/20  Boisy G. Pitre
* Added support for SHARE. bit

         nam   SCF
         ttl   OS-9 Level One V2 SCF file manager

         ifp1
         use   defsfile
         use   scfdefs
         endc

tylg     set   FlMgr+Objct
atrv     set   ReEnt+rev
rev      set   $00
edition  set   11

         mod   eom,name,tylg,atrv,start,size

size     equ   .

name     fcs   /SCF/
         fcb   edition

start    lbra  Create
         lbra  Open
         lbra  MakDir
         lbra  ChgDir
         lbra  Delete
         lbra  Seek
         lbra  Read
         lbra  Write
         lbra  ReadLn
         lbra  WriteLn
         lbra  GetStat
         lbra  PutStat
         lbra  Term

L0038    puls  y


* ChgDir/MakDir entry
ChgDir
MakDir   comb
         ldb   #E$BPNam
L003D    rts


* Open/Create entry
Open
Create   ldx   PD.DEV,y                get device table entry
         stx   <PD.TBL,y               save copy
         ldu   PD.RGS,y                get caller's registers in U
         pshs  y                       save path descriptor pointer on stack
         ldx   R$X,u                   get device name pointer
         os9   F$PrsNam                parse it
         bcs   L0038                   branch if error
         lda   -1,y                    get last char
         bmi   L0059                   branch if hi bit set
         leax  ,y                      else point X at last char + 1
         os9   F$PrsNam                parse... better not have another slash!
         bcc   L0038                   another slash follows, not good!
L0059    sty   R$X,u                   save pointer past our device name back
         puls  y
         lda   #READ.
         bita  PD.MOD,y
         beq   L00A2
         ldd   #$0001
         os9   F$SRqMem                allocate buffer
         bcs   L003D                   branch if error
         stu   PD.BUF,y                else save off
         clrb
         bsr   L0091

* cute message
cute     fcb   $62,$1B,$59,$6B,$65,$65,$2A,$11,$1C,$0D,$0F
         fcb   $42,$0C,$6C,$62,$6D,$31,$13,$0F,$0B,$49,$0C
         fcb   $72,$7C,$6A,$2B,$08,$00,$02,$11,$00,$79

* put cute message into our newly allocated PD buffer
L0091    puls  x                       get PC into X
         clra
L0094    eora  ,x+
         sta   ,u+
         decb
         cmpa  #C$CR
         bne   L0094
L009D    sta   ,u+
         decb
         bne   L009D
L00A2    ldu   PD.DEV,y
         beq   MakDir
         ldx   V$STAT,u                X = static storage ptr
         lda   <PD.PAG,y               get page len
         sta   V.LINE,x                store in static
         ldx   V$DESC,u
         ldd   <PD.D2P,y
         beq   L00C6
         leax  d,x
         lda   PD.MOD,y
         lsra
         rorb
         lsra
         rolb
         rola
         rorb
         rola
         os9   I$Attach                attach to DEV2
         bcs   L00FD
         stu   PD.DV2,y                save dev entry
L00C6    ldu   V$STAT,u
         clra
         clrb
         pshs  b,a
         ldx   <V.PDLHd,u              get path descriptor list head pointer
         beq   YesPath                 branch if not empty (an open path already exists for this device)
* IOMan has already vetted the mode byte of the driver and the descriptor
* and compared it to REGA of I$Open (now in PD.MOD of this current path).
* here we know there is at least one path open for this device.
* in order to properly support SHARE. (device exclusivity), we get the
* mode byte for the path we are opening and see if the SHARE. bit is set.
* if so, then we return error since we cannot have exclusivity to the device.
         IFNE  H6309
         tim   #SHARE.,PD.MOD,y
         ELSE
         lda   PD.MOD,y 
         bita  #SHARE.
         ENDC
         bne   NoShare      
* we now know that the path's mode doesn't have the SHARE. bit set, so 
* we need to look at the mode of the path in the list header pointer to
* see if ITS SHARE. bit is set (meaning it wants exclusive access to the
* port).  If so we bail out
         IFNE  H6309
         tim   #SHARE.,PD.MOD,x
         ELSE
         lda   PD.MOD,x 
         bita  #SHARE.
         ENDC
         beq   CkCar        Check carrier status
NoShare  leas  2,s          Eat extra stack (including good path count)
         comb
         ldb   #E$DevBsy    Non-sharable device busy error
         bra   OpenErr      Go detach device & exit with error

YesPath
         sty   <V.PDLHd,u              else save this path descriptor as the head
         bra   L00E9

L00D7    tfr   d,x                     change to PD.PLP path descriptor
CkCar    ldb   <PD.PST,x               get carrier status in B
         bne   L00E0                   carrier was lost, do not update count
         inc   1,s                     carrier not lost, bump up count of good paths
L00E0    ldd   <PD.PLP,x               get path descriptor list pointer
         bne   L00D7                   there is one, go make it the current one
         sty   <PD.PLP,x               else add this path descriptor to the tail of the list
L00E9    lda   #SS.Open                internal open call
         pshs  a                       save it on the stack
         inc   2,s                     bump counter of good paths up by 1
         lbsr  L01BD                   do the SS.Open call to the driver
         lda   2,s                     get counter of good paths
         leas  3,s                     clean up stack
* NEW: return with error if SS.Open return error
         bcs   L00FD                   +++BGP+++
         deca                          bump down good path count
         bne   L00FC                   if more still open, exit without error
         lbra  L01B2                   set parity/baud & return
L00FC    clrb
L00FD    rts

* we come here if there was an error in Open (after I$Attach and F$SRqMem!)
OpenErr  pshs   b,cc
         bsr    DetDev
         puls   b,cc,pc
    
* Detach device and return memory    
DetDev   ldu   PD.DV2,y                get output device table pointer
         beq   L010B                   branch if empty
         os9   I$Detach                else detach it
L010B    ldu   PD.BUF,y                get path descriptor buffer pointer
         beq   L0EX                    branch if empty
         ldd   #$0001
         os9   F$SRtMem                else return to free system ram
L0EX     rts

* term routine
Term     tst   PD.CNT,y
         beq   L0115                   branch if count is zero


* seek/delete routine
Seek
Delete   clra
         rts

L0115    bsr   DetDev
         ldx   #$0001
         lda   #SS.Close
         pshs  x,a
         ldu   PD.DEV,y
         ldu   V$STAT,u
         ldx   <V.PDLHd,u
         ldd   <PD.PLP,y
         cmpy  <V.PDLHd,u
         bne   L013A
         std   <V.PDLHd,u
         bne   L0143
         clr   2,s
         bra   L0143
L0135    ldx   <PD.PLP,x
         beq   L0147
L013A    cmpy  <PD.PLP,x
         bne   L0135
         std   <PD.PLP,x
L0143    sty   <PD.PLP,y
L0147    lbsr  L01BD
         leas  3,s                     fix stack
         rts


* getstat routine
GetStat  lda   <PD.PST,y
         lbne  L0404
         ldx   PD.RGS,y
         lda   R$B,x                   get status code
         cmpa  #SS.Opt
         bne   L0179                   branch if not
         pshs  y,x,a
         lda   #SS.ComSt               call driver's SS.ComSt
         sta   R$B,x
         ldu   R$Y,x
         pshs  u
         bsr   L0179
         puls  u
         puls  y,x,a
         sta   R$B,x
         ldd   R$Y,x
         stu   R$Y,x
         bcs   L0177
         std   <PD.PAR,y
L0177    clrb
         rts
L0179    ldb   #$09                    getstat offset
JsrDrvr  pshs  a
         clra
         ldx   PD.DEV,y
         ldu   V$STAT,x
         ldx   V$DRIV,x
         addd  M$Exec,x
         leax  d,x
         puls  a
         jmp   ,x                      jump into driver


* putstat routine
PutStat  lbsr  L03E0
PutStat2 bsr   L0198
         pshs  b,cc
         lbsr  L0391
         puls  pc,b,cc
L0198    lda   R$B,u
         ldb   #$0C                    setstat offset
         cmpa  #SS.Opt                 SS.Opt?
         bne   JsrDrvr                 jsr into driver
* copy passed options to path desc
         pshs  y
         ldx   R$X,u
         leay  <PD.OPT,y
         ldb   #OPTCNT
L01A9    lda   ,x+
         sta   ,y+
         decb
         bne   L01A9
         puls  y

L01B2    ldx   <PD.PAR,y
         lda   #SS.ComSt
         pshs  x,a
         bsr   L01BD
         puls  pc,x,a
         
L01BD    pshs  u,y,x
         ldx   PD.RGS,y
         ldu   R$Y,x
         lda   R$B,x
         pshs  u,y,x,a
         ldd   <$10,s
         std   R$Y,x
         lda   $0F,s
         sta   R$B,x
         ldb   #$0C
         lbsr  L03E5
         bsr   PutStat2
         puls  u,y,x,a
         stu   R$Y,x
         sta   R$B,x
         bcc   L01E6
         cmpb  #E$UnkSvc
         orcc  #Carry
         bne   L01E6
         clrb
L01E6    puls  u,y,x
L01E8    rts


* read routine
Read     lbsr  L03E0
         bcs   L01E8
         inc   PD.RAW,y
         ldx   R$Y,u
         beq   L0235
         pshs  x
         ldx   #$0000
         ldu   R$X,u
         lbsr  L0348
         bcs   L020A
         tsta
         beq   L0220
         cmpa  <PD.EOF,y
         bne   L0218
L0208    ldb   #E$EOF
L020A    leas  2,s
         pshs  b
         bsr   L0231
         comb
         puls  pc,b

L0213    lbsr  L0348
         bcs   L020A
L0218    tst   <PD.EKO,y
         beq   L0220
         lbsr  L046C
L0220    leax  1,x
         sta   ,u+
         beq   L022B
         cmpa  <PD.EOR,y
         beq   L022F
L022B    cmpx  ,s
         bcs   L0213
L022F    leas  $02,s
L0231    ldu   PD.RGS,y
         stx   R$Y,u
L0235    lbra  L0391


* readln routine
ReadLn   lbsr  L03E0
         bcs   L01E8
         ldx   R$Y,u
         beq   L0231
         tst   R$Y,u
         beq   L0248
         ldx   #256
L0248    pshs  x
         ldd   #$FFFF
         std   PD.MAX,y
         lbsr  L030D
L0252    lbsr  L0348
         bcs   L02C8
         tsta
         beq   L0265
         ldb   #$29
L025C    cmpa  b,y
         beq   L0285
         incb
         cmpb  #$31
         bls   L025C
L0265    cmpx  PD.MAX,y
         bls   L026B
         stx   PD.MAX,y
L026B    leax  1,x
         cmpx  ,s
         bcs   L027B
         lda   <PD.OVF,y
         lbsr  L046C
         leax  -1,x
         bra   L0252
L027B    lbsr  L0369
         sta   ,u+
         lbsr  L0379
         bra   L0252
L0285    pshs  pc,x
         leax  >L0298,pcr
         subb  #$29
         lslb
         leax  b,x
         stx   2,s
         puls  x
         jsr   [,s++]
         bra   L0252
L0298    bra   L0313
         bra   L02FD
         bra   L02AA
         bra   L02BE
         bra   L02D9
         bra   L02E3
         puls  pc
         bra   L02FD
         bra   L02FD
L02AA    leas  2,s
         sta   ,u
         lbsr  L0379
         ldu   R$Y,y
         leax  1,x
         stx   R$Y,u
         bsr   L0332
         leas  2,s
         lbra  L0391
L02BE    leas  2,s
         leax  ,x
         lbeq  L0208
         bra   L0265

L02C8    pshs  b
         lda   #C$CR
         sta   ,u
         bsr   L02D5
         puls  b
         lbra  L020A
L02D5    lda   #C$CR
         bra   L032F
L02D9    lda   <PD.EOR,y
         sta   ,u
         bsr   L030D
L02E0    lbsr  L037E
L02E3    cmpx  PD.MAX,y
         beq   L02FA
         leax  1,x
         cmpx  2,s
         bcc   L02F8
         lda   ,u+
         beq   L02E0
         cmpa  <PD.EOR,y
         bne   L02E0
         leau  -1,u
L02F8    leax  -1,x
L02FA    rts   
L02FB    bsr   L0317
L02FD    leax  ,x
         beq   L030D
         tst   <PD.DLO,y
         beq   L02FB
         tst   <PD.EKO,y
         beq   L030D
         bsr   L02D5
L030D    ldx   #$0000
         ldu   PD.BUF,y
L0312    rts
L0313    leax  ,x
         beq   L02FA
L0317    leau  -1,u
         leax  -1,x
         tst   <PD.EKO,y
         beq   L0312
         tst   <PD.BSO,y
         beq   L032C
         bsr   L032C
         lda   #C$SPAC
         lbsr  L046C
L032C    lda   <PD.BSE,y
L032F    lbra  L046C
L0332    ldx   R$X,u
         ldu   PD.BUF,y
L0336    lda   ,u+
         sta   ,x+
         cmpa  <PD.EOR,y
         bne   L0336
         rts

L0340    pshs  u,y,x
         ldx   PD.DV2,y
         ldu   PD.DEV,y
         bra   L0350

L0348    pshs  u,y,x
         ldx   PD.DEV,y
         ldu   PD.DV2,y		U now points to dev table entry of device 2
         beq   L0357
L0350    ldu   V$STAT,u		U now points to static storage of device 2
         ldb   <PD.PAG,y
         stb   V.LINE,u
L0357    leax  ,x
         beq   L0367
         tfr   u,d		D now holds pointer to static storage of device 2
         ldu   V$STAT,x		U now holds ???
         std   V.DEV2,u
         ldu   #$0003           call READ routine in driver
         lbsr  L04D3
L0367    puls  pc,u,y,x

L0369    tst   <PD.UPC,y
         beq   L0378
         cmpa  #'a
         bcs   L0378
         cmpa  #'z
         bhi   L0378
         suba  #32
L0378    rts
L0379    tst   <PD.EKO,y
         beq   L0378
L037E    cmpa  #C$SPAC
         bcc   L0386
         cmpa  #C$CR
         bne   L0389
L0386    lbra  L046C
L0389    pshs  a
         lda   #C$PERD
         bsr   L0386
         puls  pc,a

L0391    ldx   <D.Proc
         lda   P$ID,x
         ldx   PD.DEV,y
         bsr   L039B
         ldx   PD.DV2,y
L039B    beq   L03A5
         ldx   V$STAT,x
         cmpa  V.BUSY,x
         bne   L03A5
         clr   V.BUSY,x
L03A5    rts

* A = PID
* X = dev entry
* Y = path desc
L03A6    pshs  x,a
         ldx   V$STAT,x
         lda   V.BUSY,x
         beq   L03C8
         cmpa  ,s                      compare to A on stack
         beq   L03DD                   branch if same
         pshs  a
         bsr   L0391
         puls  a
         os9   F$IOQu
         inc   PD.MIN,y
         ldx   <D.Proc
         ldb   <P$Signal,x
         puls  x,a
         beq   L03A6
         coma
         rts
L03C8    lda   ,s                      get passed PID on stack
         sta   V.BUSY,x
         sta   V.LPRC,x
         lda   <PD.PSC,y
         sta   V.PCHR,x
         ldd   <PD.INT,y               get int/qut
         std   V.INTR,x                save in static
         ldd   <PD.XON,y               get xon/xoff
         std   V.XON,x                 save in static
L03DD    clra
         puls  pc,x,a

L03E0    lda   <PD.PST,y
         bne   L0402
L03E5    ldx   <D.Proc
         lda   P$ID,x
         clr   PD.MIN,y
         ldx   PD.DEV,y
         bsr   L03A6
         bcs   L03FF
         ldx   PD.DV2,y
         beq   L03F9
         bsr   L03A6
         bcs   L03FF
L03F9    tst   PD.MIN,y
         bne   L03E0
         clr   PD.RAW,y
L03FF    ldu   PD.RGS,y
         rts
L0402    leas  2,s
L0404    ldb   #E$HangUp
         cmpa  #$02
         bcs   L0411
         lda   PD.CPR,y
         ldb   #S$Kill
         os9   F$Send
L0411    inc   <PD.PST,y
         orcc  #Carry
         rts


* writeln routine
WriteLn  bsr   L03E0
         bra   L041F


* write routine
Write    bsr   L03E0
         inc   PD.RAW,y
L041F    ldx   R$Y,u
         beq   L0461
         pshs  x
         ldx   #$0000
         ldu   R$X,u
L042A    lda   ,u+
         tst   PD.RAW,y
         bne   L0444
         lbsr  L0369
         cmpa  #C$LF
         bne   L0444
         lda   #C$CR
         tst   <PD.ALF,y
         bne   L0444
         bsr   L047A
         bcs   L0464
         lda   #C$LF
L0444    bsr   L047A
         bcs   L0464
         leax  1,x
         cmpx  ,s
         bcc   L045B
         lda   -1,u
         beq   L042A
         cmpa  <PD.EOR,y
         bne   L042A
         tst   PD.RAW,y
         bne   L042A
L045B    leas  2,s
L045D    ldu   PD.RGS,y
         stx   R$Y,u
L0461    lbra  L0391
L0464    leas  2,s
         pshs  b,cc
         bsr   L045D
         puls  pc,b,cc

L046C    pshs  u,x,a
         ldx   PD.DV2,y
         beq   L0478
         cmpa  #C$CR
         beq   L04A9
L0476    bsr   L04D0
L0478    puls  pc,u,x,a

L047A    pshs  u,x,a
         ldx   PD.DEV,y
         cmpa  #C$CR
         bne   L0476
         ldu   V$STAT,x
         tst   V.PAUS,u
         bne   L0497
         tst   PD.RAW,y
         bne   L04A9
         tst   <PD.PAU,y
         beq   L04A9
         dec   V.LINE,u
         bne   L04A9
         bra   L04A1
L0497    lbsr  L0340
         bcs   L04A1
         cmpa  <PD.PSC,y
         bne   L0497
L04A1    lbsr  L0340
         cmpa  <PD.PSC,y
         beq   L04A1
L04A9    ldu   V$STAT,x
         clr   V$USRS,u
         lda   #C$CR
         bsr   L04D0
         tst   PD.RAW,y
         bne   L04CE
         ldb   <PD.NUL,y
         pshs  b
         tst   <PD.ALF,y
         beq   L04C5
         lda   #C$LF
L04C1    bsr   L04D0
         bcs   L04CC
L04C5    lda   #C$NULL
         dec   ,s
         bpl   L04C1
         clra
L04CC    leas  1,s
L04CE    puls  pc,u,x,a

* Call Driver
L04D0    ldu   #$0006        call write routine in driver
L04D3    pshs  u,y,x,a
         ldu   V$STAT,x      get pointer to device static storage entry
         clr   V.WAKE,u      clear V.WAKE (driver will populate this)
         ldx   V$DRIV,x      get pointer to device driver for this path
         ldd   M$Exec,x      get entry point into device driver
         addd  $05,s         add in offset
         leax  d,x           
         lda   ,s+           
         jsr   ,x
         puls  pc,u,y,x

         emod
eom      equ   *
         end
