********************************************************************
* MonType - Change monitor type
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Original Tandy/Microware version
* 2      Modified to require dash before option         BGP 03/01/20
* 3      Fixed a bug where a non dash option would      BGP 03/03/10
*        crash the system.  Also shows the monitor
*        type when no parameters are passed.

         nam   MonType
         ttl   Change monitor type

* Disassembled 98/09/10 23:52:51 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   3

         mod   eom,name,tylg,atrv,start,size

         org   0
         rmb   300
size     equ   .

name     fcs   /MonType/
         fcb   edition

CurOn    fdb   $1B21
         IFNE  DOHELP
HelpMsg  fcb   C$CR
         fcb   C$LF
         fcc   "MonType - Set up the monitor type"
         fcb   C$CR
         fcb   C$LF
         fcc   "Syntax:  MonType [opt]"
         fcb   C$CR
         fcb   C$LF
         fcc   "Options: -r = rgb monitor"
         fcb   C$CR
         fcb   C$LF
         fcc   "         -c = composite monitor (t.v.)"
         fcb   C$CR
         fcb   C$LF
         fcc   "         -m = monochrome monitor"
         fcb   C$CR
         fcb   C$LF
HelpMsgL equ   *-HelpMsg
         ENDC

TypeMsg  fcc   /Current setting: /
TypeMsgL equ   *-TypeMsg
TypeTbl  fcb   CMPType-TypeTbl
         fcb   RGBType-TypeTbl
         fcb   MonoType-TypeTbl

RGBType  fcc   /RGB/
         fcb   C$CR
CMPType  fcc   /Composite/
         fcb   C$CR
MonoType fcc   /Monochrome/
         fcb   C$CR

ShowMTyp lda   #1			standard out
         ldb   #SS.Montr		monitor type
         os9   I$GetStt 		get it!
         bcs   Exit
         pshs  x 
         leax  TypeMsg,pcr
         ldy   #TypeMsgL
         os9   I$Write
         puls  d
         leax  TypeTbl,pcr
         ldb   b,x
         abx 
         lda   #1
         ldy   #80
         os9   I$WritLn
         bra   ExitOk
         
start    bsr   SkipSpcs
         cmpa  #C$CR
         beq   ShowMTyp
         andb  #$5F			make uppercase
         cmpd  #$2D52			-R ?
         bne   L00C7
         ldx   #$0001
         bra   L00D7
L00C7    cmpd  #$2D43			-C ?
         bne   L00D0
         ldx   #$0000
         bra   L00D7
L00D0    cmpd  #$2D4D			-M ?
         bne   ShowHelp
         ldx   #$0002
L00D7    lda   #1			standard output
         ldb   #SS.Montr		monitor setstat
         os9   I$SetStt 		do it!
         bcs   Exit			branch if error
         leax  >CurOn,pcr		point to cursor on
         lda   #1			to stdout
         ldy   #2			two bytes
         os9   I$Write  		write it!
         bcs   Exit			branch if error
ExitOk   clrb  
Exit     os9   F$Exit   

SkipSpcs ldd   ,x+
         cmpa  #C$SPAC
         beq   SkipSpcs
         rts   

ShowHelp equ   *
         IFNE  DOHELP
         lda   #1
         leax  >HelpMsg,pcr
         ldy   #HelpMsgL
         os9   I$Write  
         ENDC
         bra   ExitOk

         emod
eom      equ   *
         end
