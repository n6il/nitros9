********************************************************************
* DeIniz - Denitialize a device
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   3    From Tandy OS-9 Level Two VR 02.00.01
*   4    Tightened code, changed behavior slightly      BGP 03/01/13

         nam   DeIniz
         ttl   Deinitialize a device

* Disassembled 98/09/10 22:56:37 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   4

linebsiz equ   80

         mod   eom,name,tylg,atrv,start,size

         org   0
readbuf  rmb   linebsiz+1
stack    rmb   64
size     equ   .

name     fcs   /DeIniz/
         fcb   edition

start    lda   ,x		get command line char
         cmpa  #C$CR		CR?
         beq   ReadnDnz		branch if so
DenizDev lda   ,x+
         cmpa  #C$CR
         beq   ExitOk
         cmpa  #C$SPAC
         beq   DenizDev
         cmpa  #PDELIM		pathlist?
         beq   DetachIt
         leax  -1,x		else back up X
DetachIt clra  
         os9   I$Attach 	attach to the device at X
         bcs   Exit		branch if error
         os9   I$Detach 	now detatch from the device at U
         bcs   Exit		branch if error
         os9   I$Detach 	and detatch again from the device at U
         bcs   Exit		branch if error
         bra   DenizDev

ReadnDnz clra			from stdin
         leax  readbuf,u	point to read buffer
         ldy   #linebsiz	get linebsiz bytes
         os9   I$ReadLn 	read it!
         bcc   DenizDev		branch if error
         cmpb  #E$EOF		end of file?
         bne   Exit		branch if not
ExitOk   clrb
Exit     os9   F$Exit

         emod
eom      equ   *
         end
