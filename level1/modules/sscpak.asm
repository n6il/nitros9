********************************************************************
* SSCPAK - Tandy Speech/Sound Pak driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   1    From Tandy OS-9 Level One VR 02.00.00

         nam   SSCPAK
         ttl   Tandy Speech/Sound Pak driver

* Disassembled 98/08/23 17:33:46 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   scfdefs
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   1

BusyBit  equ   %10000000  SSPak busy status bit (active low)
CRA      equ   $01        PIA CRA offset
CRB      equ   $03        PIA CRB offset
MUXBit   equ   %00001000  COCO sound MUX control/select bit position
SpeakBit equ   %01000000  SSPak speech status bit (active low)
SSPData  equ   $FF7E      SSPak data register offset
SSPReset equ   $FF7D      SSPak reset register offset
SSPStat  equ   $FF7E      SSPak status register offset

         mod   eom,name,tylg,atrv,start,size

         rmb   29
size     equ   .

         fcb   READ.+WRITE.	mode byte

name     fcs   /SSCPAK/
         fcb   edition

start    lbra  Init
         lbra  Read
         lbra  Write
         lbra  GetStat
         lbra  SetStat
         lbra  Term

Init     pshs  a
         lda   #$01
         sta   >SSPReset	reset SSPak
         clra  
         sta   >SSPReset	end SSPak reset
         puls  pc,a

Read     ldb   #E$BMode
         bra   ErrEx

GetStat
SetStat  ldb   #E$UnkSvc
ErrEx    orcc  #Carry
Term     rts   

Write    ldy   #SSPData
         ldx   #PIA0Base
         ldu   #PIA1Base
         cmpa  #C$LF		linefeed?
         beq   WritEx		..yep, ignore it
         cmpa  #C$CR		carriage return?
         bne   NormChar		..no
         lda   CRA,x		get PIA0 CRA
         ldb   CRB,x		get PIA0 CRB
         pshs  b,a		save them
         anda  #^MUXBit		clear PIA0 CA2 control LSBit
         orb   #MUXBit		set PIA0 B@ control LSBit
         sta   CRA,x		* set CoCo sound MUX to cartridge input
         stb   CRB,x		*
         lda   CRB,u		get PIA1 CRB
         pshs  a		save it
         ora   #MUXBit		set PIA1 CB2 control LSBit
         sta   CRB,u		enable COCO sound MUX
         lda   #C$CR		get carriage return
         bsr   ChkHW		wait for SSPak to get ready
         sta   ,y		store it in SSPak
         bsr   SpchWait		wait until speech is active
         bsr   SSWait		wait until speech is inactive
         puls  a		get original PIA1 CRB
         sta   CRB,u		disable COCO sound MUX
         puls  b,a		get original PIA0 CRA/CRB
         sta   CRA,x		restore original PIA0 CRA
         stb   CRB,x		restore original PIA0 CRB
         bra   WritEx		exit
NormChar bsr   ChkHW		wait for HW
         sta   ,y		write char to HW
WritEx   clrb  
         rts   

* Check SSC hardware, loop until it's ready
ChkHW    pshs  a
ChkHWLp  lda   ,y		get SSPak status
         anda  #BusyBit		SSPak busy?
         beq   ChkHWLp		yep, go check again
         puls  pc,a

* routine to loop until SSPak speech is inactive
SSWait   pshs  x,a
SSWait2  lda   ,y		get SSPak status
         anda  #SpeakBit	SSPak speech active yet?
         bne   SSWaitEx		yep, exit
         ldx   #$0001		sleep remainder of tick
         os9   F$Sleep  
         bra   SSWait2
SSWaitEx puls  pc,x,a

* routine to loop until SSPak speech is active
SpchWait pshs  a
SpchLoop lda   ,y		get SSPak status
         anda  #SpeakBit	SSPak speech active yet?
         bne   SpchLoop		no, go check again
         puls  pc,a		return

         emod
eom      equ   *
         end

