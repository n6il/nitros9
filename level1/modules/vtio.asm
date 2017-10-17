********************************************************************
* VTIO - NitrOS-9 Level 1 Video Terminal I/O driver
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  12      ????/??/??  ???
* From Tandy OS-9 Level One VR 02.00.00.
*
*  12r1    2003/09/11  Rodney V. Hamilton
* Modified key table to include $7F, $1D, $1E and $1F codes.
*
*          2004/11/28  P.Harvey-Smith
* Added code to remap Dragon keyboard inputs to CoCo format.
*
*          2004/12/02  P.Harvey-Smith
* Changed the way that the entry points for the co?? drivers are
* called, so that we can have up to 7 different drivers.
* Integrated changes needed for the co51 driver from Dragon Data
* OS-9.
*
*          2005/04/24  P.Harvey-Smith
* Added cursor flash call to AltIRQ routine, this decrements a
* counter and when zero calls the routine contained in V.Flash
* ccio initialises this to point to an rts, the individual COxx 
* routine can over-ride this in it's init, this should point to
* a routine to flash the cursor which should end in an rts.
*
*   1      2005/11/26  Boisy G. Pitre
* Renamed to VTIO.
                         
         nam   VTIO      
         ttl   OS-9 Level One V2 CoCo I/O driver
                         
         ifp1            
         use   defsfile  
;         use   scfdefs   
         use   cocovtio.d
         endc            
                         
tylg     set   Drivr+Objct
atrv     set   ReEnt+rev 
rev      set   $00
edition  set   1
                         
         mod   eom,name,tylg,atrv,start,size
                         
size     equ   V.Last    
                         
         fcb   UPDAT.+EXEC.
                         
name     fcs   /VTIO/    
         fcb   edition   
                         
start    lbra  Init      
         lbra  Read      
         lbra  Write     
         lbra  GetStat   
         lbra  SetStat   
         lbra  Term      
                         
* Init
*
* Entry:
*    Y  = address of device descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Init                     
* MESS Debug lines for Phill
*        pshs	y
*	ldy	#$aa55
*	ldy	#V.5136
*	ldy	#V.51End
*	puls	y
                         
         stu   >D.KbdSta  store devmem ptr
         clra             clear A
         leax  <V.SCF,u   point to memory after V.SCF
;         ldb   #$5D		get counter
         ldb   #V.51End-V.SCF
L002E    sta   ,x+        clear mem
         decb             decrement counter
         bne   L002E      continue if more
              
         IFEQ  PwrLnFreq-Hz60
         lda   #CFlash60hz initialize           
         ELSE
         lda   #CFlash50hz initialize           
         ENDC
         sta   <V.FlashTime,u                
         leax  FlashCursor,pcr * Point to dummy cursor flash
         stx   V.Flash,u  * Setup cursor flash
                         
         coma             A = $FF
         comb             B = $FF
         IFEQ  coco2b+deluxe-1
         clr   <V.Caps,u 
         ELSE
         stb   <V.Caps,u 
         ENDC
         std   <V.LKeyCd,u
         std   <V.2Key2,u
         lda   #60       
         sta   <V.ClkCnt,u
         leax  >AltIRQ,pcr get IRQ routine ptr
         stx   >D.AltIRQ  store in AltIRQ
         leax  >SetDsply,pcr get display vector
         stx   <V.DspVct,u store in vector address
         leax  >XY2Addr,pcr get address of XY2Addr
         stx   <V.CnvVct,u
         ldd   <IT.PAR,y  get parity and baud
         lbra  SetupTerm  process them
                         
* Term
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term     pshs  cc        
         orcc  #IRQMask   mask interrupts
         ldx   >D.Clock   get clock vector
         stx   >D.AltIRQ  and put back in AltIRQ
         puls  pc,cc     
                         
* Read
*
* Entry:
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    A  = character read
*    CC = carry set on error
*    B  = error code
*
Read                     
*	pshs	y
*	ldy	#$aa57
*	puls	y
                         
         leax  V.InBuf,u  point X to input buffer
         ldb   V.IBufT,u  get tail pointer
         orcc  #IRQMask   mask IRQ
         cmpb  V.IBufH,u  same as head pointer
         beq   Put2Bed    if so, buffer is empty, branch to sleep
         abx              X now points to curr char
         lda   ,x         get char
         bsr   L009D      check for tail wrap
         stb   V.IBufT,u  store updated tail
         andcc  #^(IRQMask+Carry) unmask IRQ
         rts             
                         
Put2Bed  lda   V.BUSY,u   get calling process ID
         sta   V.WAKE,u   store in V.WAKE
         andcc  #^IRQMask  clear interrupts
         ldx   #$0000    
         os9   F$Sleep    sleep forever
         clr   V.WAKE,u   clear wake
         ldx   <D.Proc    get pointer to current proc desc
         ldb   <P$Signal,x get signal recvd
         beq   Read       branch if no signal
         cmpb  #S$Window  window signal?
         bcc   Read       branch if so
         coma            
         rts             
* Check if we need to wrap around tail pointer to zero
L009D    incb             increment pointer
         cmpb  #$7F       at end?
         bls   L00A3      branch if not
         clrb             else clear pointer (wrap to head)
L00A3    rts             
                         
*
* IRQ routine for keyboard
*
AltIRQ                   
*        pshs	y
*	ldy	#$aa58
*	puls	y
                         
                         
         ldu   >D.KbdSta  get keyboard static
         ldb   <V.CFlg1,u graphics screen currently being displayed?
         beq   L00B7      branch if not
         ldb   <V.Alpha,u alpha mode?
         beq   L00B7      branch if so
         lda   <V.PIA1,u 
         lbsr  SetDsply   set up display
L00B7    ldx   #PIA0Base  point to PIA base
         clra            
         clrb            
         std   <V.KySns,u clear keysense byte
         bsr   L00E8      get bits
         bne   L00CC     
         clr   $02,x      clear PIA0Base+2
         lda   ,x         get byte from PIA
         coma             complement
         anda  #$7F       strip off hi bit
         bne   L00F1      branch if any bit set
L00CC    clra            
         clrb            
         std   <V.KTblLC,u clear
         coma             A = $FF
         tst   <V.Spcl,u  special key?
         bne   l@         branch if so
         sta   <V.LKeyCd,u
l@       stb   <V.Spcl,u  clear for next time
         comb            
         sta   <V.2Key1,u
         std   <V.2Key2,u
                         
CheckFlash                 
         dec   V.FlashCount,u Get flash counter
         beq   FlashTime  count zero, flash cursor
         bra   AltIRQEnd  Otherwise just call clock module
                         
FlashTime                 
         jsr   [V.Flash,u] Call flash routine
         lda   <V.FlashTime,u Re-init count
         sta   V.FlashCount,u
                         
AltIRQEnd                 
         jmp   [>D.Clock] jump into clock module
                         
L00E8    comb            
         stb   $02,x      strobe one column
         ldb   ,x         read PIA #0 row states
         comb             invert bits so 1=key pressed
         andb  #$03       mask out all but lower 2 bits
         rts             
                         
L00F1                    
         bsr   L015C     
         bmi   L00CC     
         clrb            
         bsr   L00E8     
         bne   L00CC     
         cmpa  <V.6F,u   
         bne   L010E     
         ldb   <V.ClkCnt,u
         beq   L010A     
         decb            
L0105    stb   <V.ClkCnt,u
*         bra   AltIRQEnd
         bra   CheckFlash
L010A    ldb   #$05      
         bra   L011A     
L010E    sta   <V.6F,u   
         ldb   #$05      
         tst   <V.KySame,u
         bne   L0105     
         ldb   #60       
L011A    stb   <V.ClkCnt,u
         ldb   V.IBufH,u  get head pointer in B
         leax  V.InBuf,u  point X to input buffer
         abx              X now holds address of head
         lbsr  L009D      check for tail wrap
         cmpb  V.IBufT,u  B at tail?
         beq   L012F      branch if so
         stb   V.IBufH,u 
L012F    sta   ,x         store our char at ,X
         beq   WakeIt     if nul, do wake-up
         cmpa  V.PCHR,u   pause character?
         bne   L013F      branch if not
         ldx   V.DEV2,u   else get dev2 statics
         beq   WakeIt     branch if none
         sta   V.PAUS,x   else set pause request
         bra   WakeIt    
L013F    ldb   #S$Intrpt  get interrupt signal
         cmpa  V.INTR,u   our char same as intr?
         beq   L014B      branch if same
         ldb   #S$Abort   get abort signal
         cmpa  V.QUIT,u   our char same as QUIT?
         bne   WakeIt     branch if not
L014B    lda   V.LPRC,u   get ID of last process to get this device
         bra   L0153      go for it
WakeIt   ldb   #S$Wake    get wake signal
         lda   V.WAKE,u   get process to wake
L0153    beq   L0158      branch if none
         os9   F$Send     else send wakeup signal
L0158    clr   V.WAKE,u   clear process to wake flag
         bra   AltIRQEnd  and move along
                         
L015C    clra            
         clrb            
         std   <V.ShftDn,u SHIFT/CTRL flag; 0=NO $FF=YES
         std   <V.KeyFlg,u
* %00000111-Column # (Output, 0-7)
* %00111000-Row # (Input, 0-6)
         coma            
         comb            
         std   <V.Key1,u  key 1&2 flags $FF=none
         sta   <V.Key3,u  key 3     "
         deca             lda #%11111110
         sta   $02,x      write column strobe
L016F    lda   ,x         read row from PIA0Base
                         
         ifne  (tano+d64+dalpha)
         lbsr  DragonToCoCo ; Translate Dragon keyboard layout to CoCo
         endc            
                         
         coma             invert so 1=key pressed
         anda  #$7F       keep only keys, bit 0=off 1=on
         beq   L0183      no keys pressed, try next column
         ldb   #$FF       preset counter to -1
L0178    incb            
         lsra             bit test regA
         bcc   L017F      no key, brach
         lbsr  L0221      convert column/row to matrix value and store
L017F    cmpb  #$06       max counter
         bcs   L0178      loop if more bits to test
L0183    inc   <V.KeyFlg,u counter; used here for column
         orcc  #Carry     bit marker; disable strobe
         rol   $02,x      shift to next column
         bcs   L016F      not finished with columns so loop
         lbsr  L0289      simultaneous check; recover key matrix value
         bmi   L020A      invalid so go
         cmpa  <V.LKeyCd,u last keyboard code
         bne   L0199     
         inc   <V.KySame,u same key flag ?counter?
L0199    sta   <V.LKeyCd,u setup for last key pressed
         beq   L01B9      if @ key, use lookup table
         suba  #$1A       the key value (matrix) of Z
         bhi   L01B9      not a letter, so go
         adda  #$1A       restore regA
         ldb   <V.CtrlDn,u CTRL flag
         bne   L01E9      CTRL is down so go
         adda  #$40       convert to ASCII value; all caps
         ldb   <V.ShftDn,u shift key flag
         eorb  <V.Caps,u  get current device static memory pointer
         andb  #$01       tet caps flag
         bne   L01E9      not shifted so go
         adda  #$20       convert to ASCII lowercase
         bra   L01E9     
* Not a letter key, use the special keycode lookup table
* Entry: A = table idnex (matrix scancode-26)
L01B9    ldb   #$03       three entries per key (normal, SHIFT, CTRL)
         mul              convert index to table offset
         lda   <V.ShftDn,u shift key flag
         beq   L01C4      not shifted so go
         incb             else adjust offset for SHIFTed entry
         bra   L01CB      and do it
L01C4    lda   <V.CtrlDn,u CTRL flag?
         beq   L01CB      adjust offset for CTRL key
         addb  #$02      
L01CB    lda   <V.KySnsF,u key sense flag?
         beq   L01D4      not set, so go
         cmpb  #$11       spacebar?
         ble   L0208      must be an arrow so go
L01D4    cmpb  #$4C       ALT key? (SHOULD BE $4C???)
         blt   L01DD      not ALT, CTRL, F1, F2 or SHIFT so go
         inc   <V.AltDwn,u flag special keys (ALT, CTRL)
         subb  #$06       adjust offset to skip them
L01DD    pshs  x          save X
                         
         leax  >KeyTbl,pcr point to keyboard table
         lda   b,x       
         puls  x         
         bmi   L01FD      if A = $81 - $84, special key
* several entries to this routine from any key press; A is already ASCII
L01E9    ldb   <V.AltDwn,u was ALT flagged?
         beq   L01FA      no, so go
         cmpa  #$3F       ?
         bls   L01F8      # or code
         cmpa  #$5B       [
         bcc   L01F8      capital letter so go
         ora   #$20       convert to lower case
L01F8    ora   #$80       set for ALT characters
L01FA    andcc  #^Negative not negative
         rts             
* Flag that special key was hit
L01FD    inc   <V.Spcl,u 
         ldb   <V.KySame,u
         bne   L0208     
         com   <V.Caps,u 
L0208    orcc  #Negative  set negative
L020A    rts             
                         
* Calculate arrow keys for key sense byte
L020B    pshs  b,a        convert column into power of 2
         clrb            
         orcc  #Carry    
         inca            
L0211    rolb            
         deca            
         bne   L0211     
         bra   L0219     
L0217    pshs  b,a       
L0219    orb   <V.KySns,u previous value of column
         stb   <V.KySns,u
         puls  pc,b,a    
* Check special keys (SHIFT, CTRL, ALT)
L0221    pshs  b,a       
         cmpb  #$03       is it row 3?
         bne   L0230     
         lda   <V.KeyFlg,u get column #
         cmpa  #$03       is it column 3?; ie up arrow
         blt   L0230      if lt it must be a letter
         bsr   L020B      its a non letter so bsr
L0230    lslb             B*8 8 keys per row
         lslb            
         lslb            
         addb  <V.KeyFlg,u add in the column #
         beq   L025D     
         cmpb  #$33       ALT
         bne   L0243     
         inc   <V.AltDwn,u ALT down flag
         ldb   #$04      
         bra   L0219     
L0243    cmpb  #$31       CLEAR?
         beq   L024B     
         cmpb  #$34       CTRL?
         bne   L0252     
L024B    inc   <V.CtrlDn,u CTRL down flag
         ldb   #$02      
         bra   L0219     
L0252    cmpb  #$37       SHIFT key
         bne   L0262     
         com   <V.ShftDn,u SHIFT down flag
         ldb   #$01      
         bra   L0219     
L025D    ldb   #$04      
         bsr   L0217     
         clrb            
* Check how many key (1-3) are currently being pressed
L0262    pshs  x         
         leax  <V.Key1,u  1st key table
         bsr   L026D     
         puls  x         
         puls  pc,b,a    
L026D    pshs  a         
         lda   ,x        
         bpl   L0279     
         stb   ,x        
         ldb   #$01      
         puls  pc,a      
L0279    lda   $01,x     
         bpl   L0283     
         stb   $01,x     
         ldb   #$02      
         puls  pc,a      
L0283    stb   $02,x     
         ldb   #$03      
         puls  pc,a      
* simultaneous key test
L0289    pshs  y,x,b     
         bsr   L02EE     
         ldb   <V.KTblLC,u key table entry #
         beq   L02C5     
         leax  <V.2Key1,u point to 2nd key table
         pshs  b         
L0297    leay  <V.Key1,u  1st key table
         ldb   #$03      
         lda   ,x         get key #1
         bmi   L02B6      go if invalid? (no key)
L02A0    cmpa  ,y         is it a match?
         bne   L02AA      go if not a matched key
         clr   ,y        
         com   ,y         set value to $FF
         bra   L02B6     
L02AA    leay  $01,y     
         decb            
         bne   L02A0     
         lda   #$FF      
         sta   ,x        
         dec   <V.KTblLC,u key table entry #
L02B6    leax  $01,x     
         dec   ,s         column counter
         bne   L0297     
         leas  $01,s     
         ldb   <V.KTblLC,u key table entry (can test for 3 simul keys)
         beq   L02C5     
         bsr   L0309     
L02C5    leax  <V.Key1,u  1st key table
         lda   #$03      
L02CA    ldb   ,x+       
         bpl   L02DE     
         deca            
         bne   L02CA     
         ldb   <V.KTblLC,u key table entry (can test for 3 simul keys)
         beq   L02EA     
         decb            
         leax  <V.2Key1,u 2nd key table
         lda   b,x       
         bra   L02E8     
L02DE    tfr   b,a       
         leax  <V.2Key1,u 2nd key table
         bsr   L026D     
         stb   <V.KTblLC,u
L02E8    puls  pc,y,x,b  
L02EA    orcc  #Negative  flag negative
         puls  pc,y,x,b  
                         
L02EE    ldd   <V.ShftDn,u
         bne   L0301     
         lda   #$03      
         leax  <V.Key1,u 
L02F8    ldb   ,x        
         beq   L0302     
         leax  $01,x     
         deca            
         bne   L02F8     
L0301    rts             
L0302    comb            
         stb   ,x        
         inc   <V.AltDwn,u
         rts             
                         
* Sort 3 byte packet @ G.2Key1 according to sign of each byte
* so that positive #'s are at beginning & negative #'s at end
L0309    leax  <V.2Key1,u 2nd key table
         bsr   L0314      sort bytes 1 & 2
         leax  $01,x     
         bsr   L0314      sort bytes 2 & 3
         leax  -$01,x     sort 1 & 2 again (fall thru for third pass)
L0314    lda   ,x         get current byte
         bpl   L0320      positive - no swap
         ldb   $01,x      get next byte
         bmi   L0320      negative - no swap
         sta   $01,x      swap the bytes
         stb   ,x        
L0320    rts             
                         
;
; Convert Dragon Keyboard mapping to CoCo.
;
; Entry	a=Dragon formatted keyboard input from PIA
; Exit	a=CoCo formatted keyboard input from PIA
;
                         
         ifne  (tano+d64+dalpha)
DragonToCoCo                 
         pshs  b         
         sta   ,-s        ; Save on stack
         tfr   a,b        ; Take a copy of keycode
         anda  #%01000000 ; Top row same on both machines
         andb  #%00000011 ; shift bottom 2 rows up 4 places 
         lslb            
         lslb            
         lslb            
         lslb            
         pshs  b         
         ora   ,s+        ; recombine rows
         puls  b         
         andb  #%00111100 ; Shift middle 4 rows down 2 places
         lsrb            
         lsrb            
         pshs  b         
         ora   ,s+        ; recombine rows	
         puls  b         
         rts             
                         
         endc            
                         
* Key Table
* 1st column = key (no modifier)
* 2nd column = SHIFT+key
* 3rd column = CTRL+key 
KeyTbl   fcb   $00,$40,$60 ALT @ `
         fcb   $0c,$1c,$13 UP
         fcb   $0a,$1a,$12 DOWN
         fcb   $08,$18,$10 LEFT
         fcb   $09,$19,$11 RIGHT
         fcb   $20,$20,$20 SPACEBAR
         fcb   $30,$30,$81 0 0 capslock
         fcb   $31,$21,$7c 1 ! |
         fcb   $32,$22,$00 2 " null
         fcb   $33,$23,$7e 3 # ~
         fcb   $34,$24,$1d 4 $ RS  (was null)
         fcb   $35,$25,$1e 5 % GS  (was null)
         fcb   $36,$26,$1f 6 & US  (was null)
         fcb   $37,$27,$5e 7 ' ^
         fcb   $38,$28,$5b 8 ( [
         fcb   $39,$29,$5d 9 ) ]
         fcb   $3a,$2a,$00 : * null
         fcb   $3b,$2b,$7f ; + del (was null)
         fcb   $2c,$3c,$7b , < {
         fcb   $2d,$3d,$5f - = _
         fcb   $2e,$3e,$7d . > }
         fcb   $2f,$3f,$5c / ? \
         fcb   $0d,$0d,$0d ENTER key
         fcb   $00,$00,$00 CLEAR key
         fcb   $05,$03,$1b BREAK key
         fcb   $31,$33,$35 F1 key
         fcb   $32,$34,$36 F2 key
                         
                         
* Write
*
* Entry:
*    A  = character to write
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Write    ldb   <V.NGChr,u are we in the process of getting parameters?
         bne   PrmHandl   yes, go process
         sta   <V.WrChr,u save character to write
         ldb   V.51EscSeq,u     * in Escape sequence?
         bne   GoCo             * yes, send to COHR
         cmpa  #C$SPAC    space or higher?
         bcc   GoCo       yes, normal write
         cmpa  #$1B             * COHR Escape Code?
         beq   GoCo
         cmpa  #$1E       escape sequence $1E or $1F?
         bcc   Escape     yes, go process
         cmpa  #$0F       GFX codes?
         lbcc  GfxDispatch branch if so
         cmpa  #C$BELL    bell?
         lbeq  Ding       if so, ring bell
* Here we call the CO-module to write the character
GoCo     lda   <V.CurCo,u get CoVDG/CoWP flag
CoWrite  ldb   #$03       we want to write
                         
CallCO   leax  <V.GrfDrvE,u get base pointer to CO-entries
         pshs  a         
         lbsr  GetModOffset ; Get offset
         ldx   a,x        get pointer to CoVDG/CoWP
         puls  a         
         beq   NoIOMod    branch if no module
         lda   <V.WrChr,u get character to write
L039D    jmp   b,x        call i/o subroutine
NoIOMod  comb            
         ldb   #E$MNF    
         rts             
                         
* Parameter handler
PrmHandl cmpb  #$02       two parameters left?
         beq   L03B0      branch if so
         sta   <V.NChr2,u else store in V.NChr2
         clr   <V.NGChr,u clear parameter counter
         jmp   [<V.RTAdd,u] jump to return address
L03B0    sta   <V.NChar,u store in V.NChar
         dec   <V.NGChr,u decrement parameter counter
         clrb            
         rts             
                         
Escape   beq   L03C5      if $1E, we conveniently ignore it
         leax  <COEscape,pcr else it's $1F... set up to get next char
L03BD    ldb   #$01      
L03BF    stx   <V.RTAdd,u
         stb   <V.NGChr,u
L03C5    clrb            
         rts             
                         
COEscape ldb   #$03       write offset into CO-module
         lbra  JmpCO     
                         
* Show VDG or Graphics screen
* Entry: B = 0 for VDG, 1 for Graphics
SetDsply pshs  x,a       
         stb   <V.Alpha,u save passed flag in B
         lda   >PIA1Base+2
         anda  #$07       mask out all but lower 3 bits
         ora   ,s+        OR in passed A
         tstb             display graphics?
         bne   L03DE      branch if so
         ora   <V.CFlag,u
L03DE    sta   >PIA1Base+2
         sta   <V.PIA1,u 
         tstb             display graphics?
         bne   DoGfx      branch if so
* Set up VDG screen for text
DoVDG                    
         stb   >$FFC0    
         stb   >$FFC2    
         stb   >$FFC4    
         lda   <V.ScrnA,u get pointer to alpha screen
         bra   L0401     
                         
* Set up VDG screen for graphics
DoGfx    stb   >$FFC0    
         stb   >$FFC3    
         stb   >$FFC5    
         lda   <V.SBAdd,u get pointer to graphics screen
                         
L0401    ldb   #$07      
         ldx   #$FFC6    
         lsra            
L0407    lsra            
         bcs   L0410     
         sta   ,x+       
         leax  $01,x     
         bra   L0414     
L0410    leax  $01,x     
         sta   ,x+       
L0414    decb            
         bne   L0407     
         clrb            
         puls  pc,x      
                         
GrfDrv   fcs   /GrfDrv/    
CoVDG    fcs   /CoVDG/    
CoWP     fcs   /CoWP/    
CoHR     fcs   /CoHR/    
CoVGA    fcs   /CoVGA/    
                         
* GetStat
*
* Entry:
*    A  = function code
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
GetStat  sta   <V.WrChr,u save off stat code
         cmpa  #SS.Ready  ready call?
         bne   L0439      branch if not
         lda   V.IBufT,u  get buff tail ptr
         suba  V.IBufH,u  num of chars ready in A
         lbeq  NotReady   branch if empty
SSEOF    clrb            
         rts             
L0439    cmpa  #SS.EOF    EOF?
         beq   SSEOF      branch if so
         ldx   PD.RGS,y   get caller's regs
         cmpa  #SS.Joy    joystick?
         beq   SSJOY      branch if so
         cmpa  #SS.ScSiz  screen size?
         beq   SSSCSIZ    branch if so
         cmpa  #SS.KySns  keyboard sense?
         beq   SSKYSNS    branch if so
         cmpa  #SS.DStat  display status?
         lbeq  SSDSTAT    branch if so
         ldb   #$06       getstat entry into CO-module
         lbra  JmpCO     
                         
* Return key sense information
SSKYSNS  ldb   <V.KySns,u get key sense info
         stb   R$A,x      put in caller's A
         clrb            
         rts             
                         
* Return screen size
SSSCSIZ  clra             clear upper 8 bits of D
         ldb   <V.Col,u   get column count
         std   R$X,x      save in X
         ldb   <V.Row,u   get row count
         std   R$Y,x      save in Y
         clrb             no error
         rts             
                         
* Get joytsick values
SSJOY    pshs  y,cc      
         orcc  #IRQMask   mask interrupts
         lda   #$FF      
         sta   >PIA0Base+2
         ldb   >PIA0Base 
         ldy   R$X,x      get joystick number to poll
         bne   L0481     
         andb  #$01      
         bne   L0485     
         bra   L0486     
L0481    andb  #$02      
         beq   L0486     
L0485    clra            
L0486    sta   R$A,x     
         lda   >PIA0Base+3
         ora   #$08      
         ldy   R$X,x     
         bne   L0494     
         anda  #$F7      
L0494    sta   >PIA0Base+3
         lda   >PIA0Base+1
         anda  #$F7      
         bsr   L04B3     
         std   R$X,x     
         lda   >PIA0Base+1
         ora   #$08      
         bsr   L04B3     
         pshs  b,a       
         ldd   #63       
         subd  ,s++      
         std   R$Y,x     
         clrb            
         puls  pc,y,cc   
                         
L04B3    sta   >PIA0Base+1
         lda   #$7F      
         ldb   #$40      
         bra   L04C7     
L04BC    lsrb            
         cmpb  #$01      
         bhi   L04C7     
         lsra            
         lsra            
         tfr   a,b       
         clra            
         rts             
L04C7    pshs  b         
         sta   >PIA1Base 
         tst   >PIA0Base 
         bpl   L04D5     
         adda  ,s+       
         bra   L04BC     
L04D5    suba  ,s+       
         bra   L04BC     
                         
* Return display status
* Entry: A = path
* Exit: A = color code of pixel at cursor address
*       X = address of graphics display memory
*       Y = graphics cursor address; X = MSB, Y = LSB
SSDSTAT  lbsr  GfxActv    gfx screen allocated?
         bcs   L050E      branch if not
         ldd   <V.GCrsX,u else get X/Y gfx cursor position
         bsr   XY2Addr   
         tfr   a,b       
         andb  ,x        
L04E7    bita  #$01      
         bne   L04F6     
         lsra             divide D by 2
         lsrb            
         tst   <V.Mode,u  which mode?
         bmi   L04E7      branch if 256x192
         lsra             else divide D by 2 again
         lsrb            
         bra   L04E7     
L04F6    pshs  b         
         ldb   <V.PMask,u get pixel color mask in B
         andb  #$FC      
         orb   ,s+       
         ldx   PD.RGS,y   get caller's regs
         stb   R$A,x      place pixel color in A
         ldd   <V.GCrsX,u
         std   R$Y,x      cursor X/Y pos in Y,
         ldd   <V.SBAdd,u
         std   R$X,x      and screen addr in X
         clrb            
L050E    rts             
                         
* Entry: A = X coor, B = Y coor
XY2Addr  pshs  y,b,a      save off regs
         ldb   <V.Mode,u  get video mode
         bpl   L0517      branch if 128x192 (divide A by 4)
         lsra             else divide by 8
L0517    lsra            
         lsra            
         pshs  a          save on stack
         ldb   #191       get max Y
         subb  $02,s      sutract from Y on stack
         lda   #32        byte sper line
         mul             
         addb  ,s+        add offset on stack
         adca  #$00      
         ldy   <V.SBAdd,u get base address
         leay  d,y        move D bytes into address
         lda   ,s         pick up original X coor
         sty   ,s         put offset addr on stack
         anda  <V.PixBt,u
         ldx   <V.MTabl,u
         lda   a,x       
         puls  pc,y,x     X = offset address, Y = base
                         
* SetStat
*
* Entry:
*    A  = function code
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
SetStat  sta   <V.WrChr,u save function code
         ldx   PD.RGS,y   get caller's regs
         cmpa  #SS.ComSt 
         lbeq  SSCOMST   
         cmpa  #SS.AAGBf 
         beq   SSAAGBF   
         cmpa  #SS.SLGBf 
         beq   SSSLGBF   
         cmpa  #SS.KySns 
         bne   CoGetStt  
         ldd   R$X,x      get caller's key sense set data
         beq   L0558      branch if zero
         ldb   #$FF       else set all bits
L0558    stb   <V.KySnsF,u store value in KySnsFlag
L055B    clrb            
L055C    rts             
                         
CoGetStt ldb   #$09       CO-module setstat
JmpCO    pshs  b         
         lda   <V.CurCo,u get CO-module in use
         lbsr  CallCO    
         puls  a         
         bcc   L055B     
         tst   <V.GrfDrvE,u GrfDrv linked?
         beq   L055C     
         tfr   a,b       
         clra             GrfDrv address offset in statics
         lbra  CallCO     call it
                         
* Reserve an additional graphics buffer (up to 2)
SSAAGBF  ldb   <V.Rdy,u   was initial buffer allocated with $0F?
         lbeq  NotReady   branch if not
         pshs  b          save buffer number
         leay  <V.AGBuf,u point to additional graphics buffers
         ldd   ,y         first entry empty?
         beq   L058E      branch if so
         leay  $02,y      else move to next entry
         inc   ,s         increment B on stack
         ldd   ,y         second entry empty?
         bne   L059E      if not, no room for more... error out
L058E    lbsr  GetMem     allocate graphics buffer memory
         bcs   L05A1      branch if error
         std   ,y         save new buffer pointer at ,Y
         std   R$X,x      and in caller's X
         puls  b          get buffer number off stack
         clra             clear hi byte of D
         std   R$Y,x      and put in caller's Y (buffer number)
         clrb             call is ok
         rts              and return
L059E    ldb   #E$BMode  
         coma            
L05A1    puls  pc,a      
                         
* Select a graphics buffer
SSSLGBF  ldb   <V.Rdy,u   was initial buffer allocated with $0F?
         lbeq  NotReady   branch if not
         ldd   R$Y,x      else get buffer number from caller
         cmpd  #$0002     compare against high
         bhi   BadMode    branch if error
         leay  <V.GBuff,u point to base graphics buffer address
         lslb             multiply by 2
         ldd   b,y        get pointer
         beq   BadMode    branch if error
         std   <V.SBAdd,u else save in current
         ldd   R$X,x      get select flag
         beq   L05C3      if zero, do nothing
         ldb   #$01       else set display flag
L05C3    stb   <V.CFlg1,u save display flag
         clrb            
         rts             
BadMode  comb            
         ldb   #E$BMode  
         rts             
                         
SSCOMST  ldd   R$Y,x      Get caller's Y
SetupTerm                 
         bita  #ModCoVDG   VDG?
         beq   GoCoWP     branch if not
         ldb   #$10       assume true lower case TRUE
         bita  #$01       true lowercase bit set?
         bne   GoCoVDG     branch if so
         clrb             true lower case FALSE
                         
GoCoVDG  stb   <V.CFlag,u save flag for later
         lda   #ModCoVDG   CoVDG is loaded bit
         ldx   #$2010     32x16
         pshs  u,y,x,a   
         leax  >CoVDG,pcr 
         bra   SetupCoModule
                         
GoCoWP   bita  #ModCoWP   CoWP?
         beq   GoCoVGA	  branch if not
         lda   #ModCoWP   'CoWP is loaded' bit
         ldx   #$5018     80x24
         pshs  u,y,x,a   
         leax  >CoWP,pcr 
                         
SetupCoModule                 
         bsr   LoadCoModule load CO-module if not already loaded
         puls  u,y,x,a   
         bcs   L0600     
         stx   <V.Col,u   save screen size
         sta   <V.CurCo,u store current module in use
L0600    rts             
                         
GoCoVGA  bita  #ModCoVGA
         beq   GoCoHR
         ldx   #$4020     64x32
         pshs  u,y,x,a   
         leax  >CoVGA,pcr 
         bra   SetupCoModule
                         
GoCoHR   ldx   #$3318     51x24
         pshs  u,y,x,a   
         leax  >CoHR,pcr 
         bra   SetupCoModule
                         
LoadCoModule                 
         bita  <V.COLoad,u module loaded?
         beq   L0608      branch if not
L0606    clrb             else clear carry
         rts              and return
                         
L0608    pshs  y,x,a     
         lbsr  LinkSub   
         bcc   L061F      branch if link was successful
         ldx   $01,s      get pointer to name on stack
         pshs  u         
         os9   F$Load     try to load subroutine I/O module
         puls  u         
         bcc   L061F     
         puls  y,x,a     
         lbra  NoIOMod   
L061F    leax  <V.GrfDrvE,u get base pointer to CO-entries
         lda   ,s        
         bsr   GetModOffset ; Get offset in table
         sty   a,x        ; Save address
                         
         puls  y,x,a     
         ldb   #$00       CO-module init offset
         lbra  CallCO     call it
                         
;
; Get module offset from V.GrfDrvE into A reg.
; I had to do this because the previous system would only work
; properly for 2 entries !
;
                         
GetModOffset                 
         pshs  b         
         clrb             ; Calculate address offset 
AddrFind                 
         bita  #$01       ; Done all shifts ?
         bne   AddrDone  
         addb  #$2        ; increment addr offset ptr
         lsra            
         bra   AddrFind   ; Test again
AddrDone                 
         tfr   b,a        ; output in a
         puls  b,pc      
                         
* Link to subroutine
LinkSub  pshs  u         
         lda   #Systm+Objct
         os9   F$Link    
         puls  pc,u      
                         
* 128x192 4 color pixel table
Mode1Clr fdb   $0055,$aaff
                         
GfxDispatch                 
         cmpa  #$15       GrfDrv-handled code?
         bcc   GoGrfo     branch if so
         cmpa  #$0F       display graphics code?
         beq   Do0F       branch if so
         suba  #$10      
         bsr   GfxActv    check if first gfx screen was alloc'ed
         bcs   L0663      if not, return with error
         leax  <gfxtbl,pcr else point to jump table
         lsla             multiply by two
         ldd   a,x        get address of routine
         jmp   d,x        jump to it
                         
* Jump table for graphics codes $10-$14
gfxtbl   fdb   Do10-gfxtbl $10 - Preset Screen
         fdb   Do11-gfxtbl $11 - Set Color
         fdb   Do12-gfxtbl $12 - End Graphics
         fdb   Do13-gfxtbl $13 - Erase Graphics
         fdb   Do14-gfxtbl $14 - Home Graphics Cursor
                         
GfxActv  ldb   <V.Rdy,u   gfx screen allocated?
         bne   L0606      branch if so
NotReady comb            
         ldb   #E$NotRdy 
L0663    rts             
                         
GoGrfo   bsr   GfxActv   
         bcs   L0663     
         ldx   <V.GrfDrvE,u get GrfDrv entry point
         bne   L0681      branch if not zero
         pshs  y,a        else preserve regs
         bne   L067F     
         leax  >GrfDrv,pcr  get pointer to name string
         bsr   LinkSub    link to GrfDrv
         bcc   L067B      branch if ok
         puls  pc,y,a     else exit with error
L067B    sty   <V.GrfDrvE,u save module entry pointer
L067F    puls  y,a        restore regs
L0681    clra             A = GrfDrv address offset in statics
         lbra  CoWrite   
                         
* Allocate GFX mem -- we must allocate on a 512 byte page boundary
GetMem   pshs  u          save static pointer
         ldd   #6144+256  allocate graphics memory + 1 page
         os9   F$SRqMem   do it
         bcc   L0691      branch if ok
         puls  pc,u       else return with error
L0691    tfr   u,d        move mem ptr to D
         puls  u          restore statics
         tfr   a,b        move high 8 bits to lower
         bita  #$01       odd page?
         beq   L069F      branch if not
         adda  #$01      
         bra   L06A1     
L069F    addb  #$18      
L06A1    pshs  u,a       
         tfr   b,a       
         clrb            
         tfr   d,u       
         ldd   #256      
         os9   F$SRtMem   return page
         puls  u,a       
         bcs   L06B3      branch if error
         clrb            
L06B3    rts             
                         
* $0F - display graphics
Do0F     leax  <DispGfx,pcr
         ldb   #$02      
         lbra  L03BF     
                         
DispGfx  ldb   <V.Rdy,u   already allocated initial buffer?
         bne   L06D1      branch if so
         bsr   GetMem     else get graphics memory
         bcs   L06EF      branch if error
         std   <V.SBAdd,u save memory
         std   <V.GBuff,u and GBuff
         inc   <V.Rdy,u   ok, we're ready
         lbsr  EraseGfx   clear gfx mem
L06D1    lda   <V.NChr2,u get character after next
         sta   <V.PMask,u save color set (0-3)
         anda  #$03       mask out all but lower 2 bits
         leax  >Mode1Clr,pcr point to mask byte table
         lda   a,x        get byte
         sta   <V.Msk1,u  save mask byte here
         sta   <V.Msk2,u  and here
         lda   <V.NChar,u get next char, mode byte (0-1)
         cmpa  #$01       compare against max
         bls   L06F0      branch if valid
         comb            
         ldb   #E$BMode   else invalid mode specified, send error
L06EF    rts             
                         
L06F0    tsta             test user supplied mode byte
         beq   L0710      branch if 256x192
         ldd   #$C003    
         std   <V.MCol,u 
         lda   #$01      
         sta   <V.Mode,u  128x192 mode
         lda   #$E0      
         ldb   <V.NChr2,u
         andb  #$08      
         beq   L0709     
         lda   #$F0      
L0709    ldb   #$03      
         leax  <L0742,pcr
         bra   L072D     
L0710    ldd   #$8001    
         std   <V.MCol,u 
         lda   #$FF      
         tst   <V.Msk1,u 
         beq   L0723     
         sta   <V.Msk1,u 
         sta   <V.Msk2,u 
L0723    sta   <V.Mode,u  256x192 mode
         lda   #$F0      
         ldb   #$07      
         leax  <L0746,pcr
L072D    stb   <V.PixBt,u
         stx   <V.MTabl,u
         ldb   <V.NChr2,u
         andb  #$04      
         lslb            
         pshs  b         
         ora   ,s+       
         ldb   #$01      
* Indicate screen is current
         lbra  SetDsply  
                         
L0742    fcb   $c0,$30,$0c,$03
L0746    fcb   $80,$40,$20,$10,$08,$04,$02,$01
                         
* $11 - set color
Do11     leax  <SetColor,pcr set up return address
         lbra  L03BD     
                         
SetColor clr   <V.NChar,u get next char
         lda   <V.Mode,u  which mode?
         bmi   L075F      branch if 256x192
         inc   <V.NChar,u
L075F    lbra  L06D1     
                         
* $12 - end graphics
Do12     leax  <V.GBuff,u point to first buffer
         ldy   #$0000     Y = 0
         ldb   #$03       free 3 gfx screens max
         pshs  u,b       
L076D    ldd   #6144      size of graphics screen
         ldu   ,x++       get address of graphics screen
         beq   L077A      branch if zero
         sty   -$02,x     else clear entry
         os9   F$SRtMem   and return memory
L077A    dec   ,s         decrement counter
         bgt   L076D      keep going if not end
         ldu   ,x         flood fill buffer?
         beq   L0788      branch if not allocated
         ldd   #512       else get size
         os9   F$SRtMem   and free memory
L0788    puls  u,b        restore regs
         clra            
         sta   <V.Rdy,u   gfx mem no longer alloced
         lbra  SetDsply  
                         
Do10     leax  <Preset,pcr set up return address
         lbra  L03BD     
                         
* NOTE! Shouldn't this be lda <V.NChar,u ??
Preset   lda   <V.NChr2,u get next char
         tst   <V.Mode,u  which mode?
         bpl   L07A7      branch if 128x192 4 color
         ldb   #$FF       assume we will clear with $FF
         anda  #$01       mask out all but 1 bit (2 colors)
         beq   EraseGfx   erase graphic screen with color $00
         bra   L07B2      else erase screen with color $FF
L07A7    anda  #$03       mask out all but 2 bits (4 colors)
         leax  >Mode1Clr,pcr point to color table
         ldb   a,x        get appropriate byte
         bra   L07B2      and start the clearing
                         
* Erase graphics screen
Do13                     
EraseGfx clrb             value to clear screen with
L07B2    ldx   <V.SBAdd,u
         leax  >6144+1,x  point to end of gfx mem + 1
L07B9    stb   ,-x        clear
         cmpx  <V.SBAdd,u X = to start?
         bhi   L07B9      if not, continue
* Home Graphics cursor
Do14     clra            
         clrb            
         std   <V.GCrsX,u
         rts             
                         
*
* Ding - tickle CoCo's PIA to emit a sound
*
Ding     pshs  b,a       
         lda   >PIA0Base+1
         ldb   >PIA0Base+3
         pshs  b,a       
         anda  #$F7      
         andb  #$F7      
         sta   >PIA0Base+1
         stb   >PIA0Base+3
         lda   >PIA1Base+3
         pshs  a         
         ora   #$08      
         sta   >PIA1Base+3
         ldb   #$0A      
L07E6    lda   #$FE      
         bsr   DingDuration
         lda   #$02      
         bsr   DingDuration
         decb            
         bne   L07E6     
         puls  a         
         sta   >PIA1Base+3
         puls  b,a       
         sta   >PIA0Base+1
         stb   >PIA0Base+3
         puls  pc,b,a    
                         
DingDuration                 
         sta   >PIA1Base 
         lda   #128      
L0805    inca            
         bne   L0805     
         rts             
                         
* Dummy flash cursor routine, can be replaced by COxx module.
                         
FlashCursor                 
         rts             
                         
         emod            
eom      equ   *         
         end             
