********************************************************************
* Iniz - Initialize a device
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   3    From Tandy OS-9 Level Two VR 02.00.01

         nam   Iniz
         ttl   Initialize a device

* Disassembled 98/09/10 22:56:37 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   3

         mod   eom,name,tylg,atrv,start,size

         org   0
u0000    rmb   2
readbuf  rmb   330
size     equ   .

name     fcs   /Iniz/
         fcb   edition

start    lda   ,x		get command line char
         cmpa  #C$CR		CR?
         beq   ReadnInz		branch if so
         bsr   FindDevc		skip over spaces
         bra   ExitOk		exit ok
L001C    bsr   FindDevc		skip over spaces
ReadnInz bsr   ReadLine
         bcs   CheckEOF
         lda   ,x
         cmpa  #C$CR
         bne   L001C
         ldb   #E$EOF
CheckEOF cmpb  #E$EOF		end of file?
         bne   ExitOk		branch if not
ExitOk   clrb  
         os9   F$Exit   

ReadLine clra  
         leax  readbuf,u
         ldy   #80
         os9   I$ReadLn 
         bcc   L003E
L003E    rts   

FindDevc lda   #C$SPAC		load A with space
SkipLoop cmpa  ,x+		space at X?
         beq   SkipLoop		keep going if so
         leax  -$01,x		else back up X
         stx   <u0000		and save
         lda   #PDELIM		get path delim
         cmpa  ,x		is this char at X?
         bne   L0051		branch if not
         leax  1,x		else skip over
L0051    clra  
         os9   I$Attach 	attach to the device at X
         bcs   L0064		branch if error
         lda   ,x+		get char at X
         cmpa  #C$COMA		comma?
         beq   FindDevc		branch if so
         lda   ,-x		get byte at X-1
         cmpa  #C$CR		CR?
         bne   FindDevc		branch if not
         rts   

L0064    pshs  b		save error code
         lda   #$02		stderr
         ldx   <u0000
         ldy   #80
         os9   I$WritLn 
         puls  b		pull error code from stack
         os9   F$PErr   	print error
         rts   

         emod
eom      equ   *
         end
