         IFNE  1
         nam   dEd OS-9 Disk Editor Version ???
         ttl   Copyright 1987 Doug DeMartinis
*******************************************************
* Copyright 1987 Doug DeMartinis; All Rights Reserved *
*                CIS:    72245,1400                   *
*                Delphi: DOUGLASD                     *
* Personal use and uploading of code, source and docs *
* to BBS's, as well as customization of the terminal  *
* display codes, is permitted only if the copyright   *
* notice and docs remain intact.                      *
*                                                     *
* 10/87 Various mods & fixes by Bruce Isted (BRI)     *
* 11/87 Added Diddle, Find, Push, Remove routines.    *
*       Fixed bug throwing stack off by going in and  *
*        out of various error routines.               *
*                                                     *
*******************************************************
* Further provenance is unknown but there has been at *
* least some modifications by Marie-Louis Marcoux.    *
* The program now reports position in the allocation  *
* map and which sectors the bytes represent when      *
* editing the map. It appears to also contain the     *
* patches indicated below.                            *
* The Rev Ed is 2.05 which would be consistant with   *
* the Marcoux dEd on RTSI as dEd_Plus_1and2_Patch.lzh *
* but the CRC does not match. RG                      *
*******************************************************
*                                                     *
* Mods by Roger A. Krupski (HARDWAREHACK)             *
*                                                     *
* 02/88 -Added "enter" command which cleans up the    *
*        screen by running the REDO subroutine. (RAK) *
*                                                     *
* 01/90 -Added a check for the break key which allows *
*        aborting the <F>ind function. (RAK)          *
*       -Added a check for null filename in OUTFILE:  *
*        and bypass I$Create if so.                   *
*       -Other minor bugs fixed / errors trapped.     *
*******************************************************
* 06/01/11  Robert Gault                              *
*        Corrected BAM to sector calculation.         *
*        No attempt has been made to comment code.    *

* Disassembled 2006/01/10 00:57:52 by Disasm v1.5 (C) 1988 by RML and RG

         ifp1
         use   defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $02
top      mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   1
u0007    rmb   1
u0008    rmb   2
u000A    rmb   4
u000E    rmb   1
u000F    rmb   1
u0010    rmb   1
u0011    rmb   1
u0012    rmb   2
u0014    rmb   2
u0016    rmb   1
u0017    rmb   1
u0018    rmb   1
u0019    rmb   1
u001A    rmb   1
u001B    rmb   2
u001D    rmb   2
u001F    rmb   1
u0020    rmb   1
u0021    rmb   2
u0023    rmb   2
u0025    rmb   2
u0027    rmb   2
u0029    rmb   1
u002A    rmb   1
u002B    rmb   1
u002C    rmb   1
u002D    rmb   1
u002E    rmb   1
u002F    rmb   1   
u0030    rmb   1   find hex/ascii flag
u0031    rmb   17  string to find
u0042    rmb   2
u0044    rmb   1
u0045    rmb   1
u0046    rmb   1
u0047    rmb   2
u0049    rmb   1
u004A    rmb   1
u004B    rmb   1
u004C    rmb   1
u004D    rmb   30  linked module name
u006B    rmb   30  output filename
u0089    rmb   1
u008A    rmb   1
u008B    rmb   1
u008C    rmb   1
u008D    rmb   2
u008F    rmb   2
u0091    rmb   1
u0092    rmb   1
u0093    rmb   1
u0094    rmb   1
u0095    rmb   1
u0096    rmb   1
u0097    rmb   1
u0098    rmb   1
u0099    rmb   1
u009A    rmb   1
u009B    rmb   1
u009C    rmb   1
u009D    rmb   8
u00A5    rmb   1
u00A6    rmb   48
u00D6    rmb   256
u01D6    rmb   320
size     equ   .
L000D    fcb   $0C    clear screen
L000E    fcb   $1F,$20,0    reverse video on
L0011    fcb   $1F,$21,0    reverse video off
L0014    fcb   $04    erase from current character to end of line
L0015    fcb   $0B    erase from current character to end of screen
L0016    fcb   $05,$21,0    turns on cursor
L0019    fcb   $05,$20,0    turns off cursor
name     equ   *
         fcs   /dEd/
         fcb   $05 
         fcc   /Copyright 1987 Doug DeMartinis/
L003E    fcs   /LSN=$/
L0043    fcs   /SECTOR = $/
L004D    fcc   /      0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F/
         fcc   /    0 2 4 6 8 A C E /
         fcb   $0D 
L0096    fcs   /CMD: /
L009B    fcc   "<BREAK> toggles HEX/ASCII edit modes     "
         fcs   /<ENTER> exits edit mode/
L00DB    fcs   /Zap / 
L00DF    fcs   /byte: / 
L00E5    fcs   /char: / 
L00EB    fcs   "Are you sure? (Y/N) " 
L00FF    fcs   /Writing sector.../
L0110    fcs   /OUTFILE: / 
L0119    fcs   /Verifying.../
L0125    fcs   /Verify aborted.../
L0136    fcs   /shell/
L013B    fcs   /Link to which module? / 
L0151    fcc   /Off  Len  Name/
         fcb   $0A
         fcc   /---- ---- ----/
         fcb   $0D 
L016F    fcs   /MODULE:  / 
L0178    fcs   /OFFSET: $/
L0181    fcb   $1F,$24      blink on
         fcc   /- Expert Mode -/
         fcb   $1F,$25+$80      blink off
L0194    fcs   /Find byte string $/
L01A6    fcs   /Find char string: / 
L01B8    fcs   /Searching.../
L01C4    fcs   /Current File Length $/
L01D9    fcs   /New Length? $/
L01E6    fcs   /** RESTART, Enter pathname: / 
L0202    fcs   /BAM: From Sector:$       to $       / 
L0226    fcs   /Bits:/
L022B    fcb   $07
         fcs   /Sector Stack Full /  
L023E    fcc   "   Up/Down Arrows  Read & display Next/Previous sector"
         fcb   $0A
         fcc   / <CR> Clean up the screen display/
         fcb   $0A
         fcc   /   *  Restart/
         fcb   $0A
         fcc   /   $  Fork a SHELL (Ctrl-BREAK to return)/
         fcb   $0A
         fcc   /   A  Append displayed sector to output file/
         fcb   $0A
         fcc   /   C  Close output file/ 
         fcb   $0A
         fcc   /   D  Diddle (adjust) file length/
         fcb   $0A
         fcc   /   E  Edit the displayed sector/
         fcb   $0A
         fcc   /   F  Find a byte or text string (BREAK aborts)/)
         fcb   $0A
         fcc   /   H  Help screen (also use '?')/
         fcb   $0A
         fcc   /   L  Link to a module - List all modules/
         fcb   $0A
         fcc   /   N  Next occurrence of byte(s) or string (Find)/
         fcb   $0A
         fcc   /   O  Open a file for output (use with Append)/
         fcb   $0A
         fcc   /   P  Push current sector onto stack/
         fcb   $0A
         fcc   /   Q  Quit dEd - Exit to OS9/
         fcb   $0A
         fcc   /   R  Remove and display a sector from stack/
         fcb   $0A
         fcc   /   S  Skip to given sector (sector # in hex)/
         fcb   $0A
         fcc   /   U  Unlink from module/
         fcb   $0A
         fcc   /   V  Verify all modules in file/
         fcb   $0A
         fcc   /   W  Write the sector back to the disk/
         fcb   $0A
         fcc   "   X  eXpert mode toggle on/off"
         fcb   $0A
         fcc   /   Z  Zap (fill in) the sector displayed/
         fcb   $0A 
         fcb   $0A
         fcc   /      (Press any key to return to command prompt):/
L05AC    fcc   /Use:  dEd <pathlist>/
         fcb   $0D 
L05C1    fcb   $98,$96,$80 decimal 10,000,000 
         fcb   $0F,$42,$40 decimal  1,000,000 
         fcb   $01,$86,$A0 decimal    100,000 
         fcb   $00,$27,$10 decimal     10,000
         fcb   $00,$03,$E8 decimal      1,000
         fcb   $00,$00,$64 decimal        100
         fcb   $00,$00,$0A decimal         10
         fcb   $00,$00,$01 decimal          1
* Command jump table
L05D9    fcb   $0C       up arrow
         fdb   L0A40
         fcb   $0A       down arrow
         fdb   L0A4E
         fcb   '*        ?????       
         fdb   L0627     ?????
         fcb   '$        shell
         fdb   L10BD
         fcb   $0D       CR
         fdb   L10EF 
         fcb   's        LSN change
         fdb   L0A67 
         fcb   'z        Zap
         fdb   L0B23 
         fcb   'w        Write sector
         fdb   L0BD4 
         fcb   'o        Open output file
         fdb   L0C26 
         fcb   'a        Append to file
         fdb   L0CAD 
         fcb   'c        Close output file
         fdb   L0C97
         fcb   'e        Edit sector
         fdb   L0D37 
         fcb   'q        Quit
         fdb   L0D22 
         fcb   'v        Verify
         fdb   L1116
         fcb   'l        Link
         fdb   L1223 
         fcb   'u        Unlink
         fdb   L13CA 
         fcb   'x        eXpert mode
         fdb   L13EB
         fcb   'h        help
         fdb   L1413 
         fcb   '?        help
         fdb   L1413
         fcb   'f        Find
         fdb   L142B
         fcb   'n        Next find
         fdb   L15F9 
         fcb   'd        Diddle length
         fdb   L1612
         fcb   'p        Push
         fdb   L16A9 
         fcb   'r        Restore (Pop)
         fdb   L16E2
         fcb   $00 
L0622    stb   u008B,u
         rti
L0627    lds   <u001D
         ldu   <u001B
         com   <u001A
         lbsr  L10F5
         lbsr  L078F
         leax  L01E6,pcr
         lbsr  L0759
         lbsr  L07B0
         leax  u01D6,u
         stx   <u00D6
         ldy   #$50
         clra
         os9   I$ReadLn
         lbcs  L0CB6
         cmpy  #1
         bne   L065E
         clr   <u001A
         lbsr  L10F5
         lbra  L070B
L065E    lda   <u0000
         os9   I$Close
         bra   L0672

start    equ   *
         stx   <u00D6
         leax  >L0622,pcr
         os9   F$Icpt   
         lbcs  L0CB6
L0672    clra  
         ldb   #$D6
         leax  ,u
L0677    sta   ,x+
         decb  
         bne   L0677
         stu   <u001B
         sts   <u001D
         ldd   #$0002
         std   <u000A
         leas  <-$20,s
         leax  ,s
         clra  
         clrb  
         os9   I$GetStt 
         lbcs  L0CB6
         lda   $04,x
         sta   <u0019
         leas  <$20,s
         ldx   <u00D6
         pshs  x
         clr   <u008C
L06A1    lda   ,x+
         cmpa  #$0D
         beq   L06AD
         cmpa  #$40
         bne   L06A1
         com   <u008C
L06AD    puls  x
         lda   #$03
         os9   I$Open   
         bcc   L06C7
         cmpb  #$D6
         lbne  L0D34
         ldx   <u00D6
         lda   #$83
         os9   I$Open   
         lbcs  L0D34
L06C7    sta   <u0000
         ldb   #$02
         os9   I$GetStt 
         stx   <u0049
         stu   <u004B
         ldu   <u001B
         clr   <u001A
         lbsr  L10F5
         lbsr  L07BA
         tst   <u008C
         beq   L06F5
         lbsr  L07C4
         ldx   <u0012
         ldd   $04,x
         std   <u008D
* Next line converts DD.MAP to base0 numbering.
* (DD.MAP-1)/$100+1=sectors in map. Original was DD.MAP/$100+1  RG
         subd  #1          needed to correctly convert DD.MAP to sectors, RG
         tfr   d,x
         ldd   #$0100
         lbsr  L1728
         leax  $01,x
         stx   <u008F
L06F5    lbsr  L07C4
         sty   <u001F
         ldd   <u0002
         std   <u0005
         lda   <u0004
         sta   <u0007
         ldd   #$0000
         std   <u0042
L0708    lbsr  L081F
L070B    lbsr  L078F
         leax  >L0096,pcr
         bsr   L0759
         leax  >L0015,pcr
         ldy   #$0001
         os9   I$Write  
         lbcs  L0CB6
         leax  >u01D6,u
         lbsr  L07E8
         lda   ,x
         cmpa  #$41
         bcs   L0732
         ora   #$20
L0732    leax  >L05D9,pcr
L0736    cmpa  ,x+
         beq   L0742
         leax  $02,x
         tst   ,x
         bne   L0736
         bra   L070B
L0742    tst   <u002E
         beq   L0751
         tst   <u002D
         beq   L0751
         pshs  x,a
         lbsr  L0BF0
         puls  x,a
L0751    ldd   ,x
         leax  top,pcr
         jmp   d,x
L0759    leay  >u01D6,u
         clrb  
L075E    incb  
         lda   ,x+
         bmi   L0767
         sta   ,y+
         bra   L075E
L0767    anda  #$7F
         sta   ,y
         leax  >u01D6,u
         clra  
         tfr   d,y
         bra   L0778
L0774    ldy   #$0078
L0778    lda   #$01
L077A    os9   I$WritLn 
         lbcs  L0CB6
         rts   
         ldy   #$0003
L0786    clra  
         os9   I$ReadLn 
         lbcs  L0CB6
         rts   
L078F    ldd   #$2036           move command
L0792    leax  u000A,u
         std   $02,x
         ldy   #$0004
         bra   L0778
L079C    leax  >L000E,pcr
         ldy   #$0002
         bra   L0778
L07A6    leax  >L0011,pcr
         ldy   #$0002
         bra   L0778
L07B0    leax  >L0014,pcr
         ldy   #$0001
         bra   L0778
L07BA    leax  >L000D,pcr
         ldy   #$0001
         bra   L0778
L07C4    bsr   L07F1
         leax  >u00D6,u
         stx   <u0012
         tst   <u004D
         beq   L07DA
         ldd   <u0023
         suba  <u0004
         bne   L07DA
         tfr   d,y
         bra   L07DE
L07DA    ldy   #$0100
L07DE    lda   <u0000
         os9   I$Read   
         lbcs  L0CB6
         rts   
L07E8    clra  
         ldy   #$0001
         os9   I$Read   
         rts   
L07F1    tst   <u004D
         bne   L0808
         ldx   <u0002
         lda   <u0004
         clrb  
L07FA    tfr   d,u
         lda   <u0000
         os9   I$Seek   
         lbcs  L0CB6
         ldu   <u001B
L0807    rts   
L0808    ldd   <u0023
         subd  #$0001
         cmpa  <u0004
         bcc   L0816
         ldb   #$D3
         lbra  L0CB6
L0816    ldd   <u0008
         adda  <u0004
         ldx   #$0000
         bra   L07FA
L081F    ldd   #$2020
         lbsr  L0792
         leax  >L003E,pcr
         lbsr  L0759
         bsr   L07B0
         lbsr  L08E6
         leax  >u01D6,u
         lbsr  L0774
         tst   <u004D
         beq   L083F
         lbsr  L139A
L083F    tst   <u0001
         beq   L0846
         lbsr  L0C77
L0846    ldd   #$2022
         lbsr  L0792
         leax  >L000E,pcr
         ldy   #$0002
         lbsr  L077A
         leax  >L004D,pcr
         lbsr  L0774
         leax  >L0011,pcr
         ldy   #$0002
         lbsr  L077A
L0869    lbsr  L098C
         lda   <u000F
         adda  #$10
         sta   <u000F
         bne   L0869
         leax  >u00D6,u
         stx   <u0012
         tst   <u008C
         beq   L08CA
         ldd   <u0003
         cmpd  #$0001
         bcs   L08CA
         cmpd  <u008F
         bhi   L08CA
         ldd   <u0003      might this be map size in bytes?
         subd  #$0001      assumes allocation map starts at LSN1
         ldx   #$0800      8 bits/byte x $100 to convert to position
         lbsr  L16FE
         tfr   y,d
         stb   <u0091      result of conversion.
         stu   <u0092
         leau  >$07FF,u
         cmpu  <u004A
         bls   L08AF
         cmpb  <u0049
         bcs   L08AF
         ldb   <u0049
         ldu   <u004A
         leau  -u0001,u
L08AF    stb   <u0094
         stu   <u0095
         ldu   <u001B
         ldx   <u0091
         ldb   <u0093
         stx   <u0097
         stb   <u0099
         ldx   <u0094
         ldb   <u0096
         stx   <u009A
         stb   <u009C
         lbsr  L1748
         bra   L08D3
L08CA    ldd   #$2034
         lbsr  L0792
         lbsr  L07B0
L08D3    tst   <u002E
         lbeq  L0807
         ldd   #$5933
         lbsr  L0792
         leax  >L0181,pcr
         lbra  L0759
L08E6    ldd   <u0002
         com   <u0018
         leay  >u01D6,u
         bsr   L095D
         tfr   b,a
         bsr   L095D
         clr   <u0018
         lda   <u0004
         bsr   L095D
         ldd   #$2020
         std   ,y++
         ldd   #$0008
         pshs  b,a
         com   <u0018
         leax  >L05C1,pcr
L090A    clr   ,s
L090C    ldd   <u0003
         subd  $01,x
         pshs  cc
         std   <u0003
         lda   <u0002
         clrb  
         suba  ,x
         bcc   L091C
         incb  
L091C    puls  cc
         bcc   L0922
         suba  #$01
L0922    sta   <u0002
         bcc   L0927
         incb  
L0927    tstb  
         bne   L092E
         inc   ,s
         bra   L090C
L092E    ldd   <u0003
         addd  $01,x
         std   <u0003
         lda   <u0002
         bcc   L0939
         inca  
L0939    adda  ,x
         sta   <u0002
         leax  $03,x
         bsr   L0984
         dec   $01,s
         beq   L094F
         lda   $01,s
         cmpa  #$02
         bne   L090A
         clr   <u0018
         bra   L090A
L094F    lda   #$0D
         sta   ,y
         ldd   <u0006
         std   <u0003
         lda   <u0005
         sta   <u0002
         puls  pc,b,a
L095D    pshs  a             convert hex to ascii
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L096C
         puls  a
         anda  #$0F
         bsr   L096C
         rts   
L096C    cmpa  #$09
         ble   L0972
         adda  #$07
L0972    adda  #$30
         sta   ,y+
         tst   <u0018
         beq   L0980
         cmpa  #$30
         beq   L0981
         clr   <u0018
L0980    rts   
L0981    leay  -$01,y
         rts   
L0984    pshs  a
         lda   $03,s
         bsr   L0972
         puls  pc,a
L098C    leay  >u01D6,u
         leax  >L000E,pcr
         lbsr  L0A31
         lda   <u0020
         beq   L09A5
         anda  #$F0
         cmpa  <u000F
         bne   L09A5
         lda   #$FF
         sta   <u0011
L09A5    lda   <u000F
         bsr   L095D
         lda   #$3A
         sta   ,y+
         leax  >L0011,pcr
         bsr   L0A31
         ldd   #$2020
         std   ,y++
         ldx   <u0012
         ldb   #$10
         tst   <u0011
         beq   L09C8
         ldb   <u0020
         andb  #$0F
         beq   L0A3A
         pshs  b
L09C8    lda   ,x+
         bsr   L095D
         lda   #$20
         sta   ,y+
         decb  
         bne   L09C8
         tst   <u0011
         beq   L09E4
         ldd   #$0310
         subb  ,s
         mul   
         lda   #$20
L09DF    sta   ,y+
         decb  
         bne   L09DF
L09E4    ldb   #$20
         std   ,y++
         sta   ,y+
         ldx   <u0012
         asrb  
         tst   <u0011
         beq   L09F3
         ldb   ,s
L09F3    lda   ,x+
         anda  #$7F
         cmpa  #$20
         bcc   L09FD
         lda   #$2E
L09FD    sta   ,y+
         decb  
         bne   L09F3
         stx   <u0012
         tst   <u0011
         beq   L0A26
         ldb   #$10
         subb  ,s+
         lda   #$20
L0A0E    sta   ,y+
         decb  
         bne   L0A0E
         lda   #$F0
         sta   <u000F
         bsr   L0A26
L0A19    clr   <u0011
         leax  >L0015,pcr
         ldy   #$0001
         lbra  L0778
L0A26    lda   #$0D
         sta   ,y
         leax  >u01D6,u
         lbra  L0774
L0A31    lda   ,x+
         beq   L0A39
         sta   ,y+
         bra   L0A31
L0A39    rts   
L0A3A    lda   #$F0
         sta   <u000F
         bra   L0A19
L0A40    ldd   <u0003
         addd  #$0001
         std   <u0003
         bne   L0A4B
         inc   <u0002
L0A4B    lbra  L06F5
L0A4E    ldd   <u0003
         bne   L0A58
         tst   <u0002
         lbeq  L070B
L0A58    subd  #$0001
         std   <u0003
         cmpd  #$FFFF
         bne   L0A4B
         dec   <u0002
         bra   L0A4B
L0A67    lbsr  L078F
         leax  >L0043,pcr
         lbsr  L0759
         ldy   #$0007
         bsr   L0A89
         bcs   L0A84
         ldd   <u0047
         std   <u0003
         lda   <u0046
         sta   <u0002
         lbra  L06F5
L0A84    lbsr  L1535
         bra   L0A67
L0A89    pshs  y
         clr   <u001A
         com   <u001A
         lbsr  L10F5
         puls  y
         leax  >u01D6,u
         lbsr  L0786
         clr   <u001A
         lbsr  L10F5
         leay  -$01,y
         beq   L0AEE
         tfr   y,d
L0AA6    lda   ,x+
         bsr   L0AF3
         bcs   L0AEB
         decb  
         bne   L0AA6
         sty   <u0045
L0AB2    lda   #$30
         ldb   ,-x
         leay  -$01,y
         beq   L0ABE
         lda   ,-x
         leay  -$01,y
L0ABE    bsr   L0B09
         pshs  b
         cmpy  #$0000
         bne   L0AB2
         ldb   <u0046
         incb  
         lsrb  
         clra  
         leax  <u0045,u
         cmpb  #$04
         beq   L0AE2
         sta   ,x+
         cmpb  #$03
         beq   L0AE2
         sta   ,x+
         cmpb  #$02
         beq   L0AE2
         sta   ,x+
L0AE2    puls  a
         sta   ,x+
         decb  
         bne   L0AE2
         clrb  
         rts   
L0AEB    lbsr  L1535
L0AEE    leas  $02,s
         lbra  L06F5
L0AF3    cmpa  #$30
         bcs   L0B07
         cmpa  #$39
         bls   L0B05
         anda  #$5F
         cmpa  #$46
         bhi   L0B07
         cmpa  #$41
         bcs   L0B07
L0B05    clra  
         rts   
L0B07    coma  
         rts   
L0B09    bsr   L0B18
         pshs  b
         tfr   a,b
         bsr   L0B18
         lslb  
         lslb  
         lslb  
         lslb  
         orb   ,s+
         rts   
L0B18    subb  #$30
         cmpb  #$09
         bls   L0B22
         andb  #$5F
         subb  #$07
L0B22    rts   
L0B23    clr   <u001A
         com   <u001A
         lbsr  L10F5
         lbsr  L078F
         lbsr  L07B0
         leax  >L00DB,pcr
         lbsr  L0759
         tst   <u0017
         bne   L0B81
         leax  >L00DF,pcr
         lbsr  L0759
         ldy   #$0003
         bsr   L0B62
         bsr   L0B96
         bcs   L0B79
L0B4C    leax  >u00D6,u
         stx   <u0012
         clrb  
L0B53    sta   ,x+
         decb  
         bne   L0B53
         clr   <u001A
         lbsr  L10F5
         inc   <u002D
         lbra  L0708
L0B62    clra  
         leax  >u01D6,u
         os9   I$ReadLn 
         bcs   L0B6D
         rts   
L0B6D    cmpb  #$02
         lbne  L0CB6
         com   <u0017
         leas  $02,s
         bra   L0B23
L0B79    clr   <u001A
         lbsr  L10F5
         lbra  L070B
L0B81    leax  >L00E5,pcr
         lbsr  L0759
         ldy   #$0002
         bsr   L0B62
         lda   ,x
         cmpa  #$20
         bcs   L0B79
         bra   L0B4C
L0B96    bsr   L0BAA
         bcs   L0BC9
         tfr   a,b
         bsr   L0BAA
         bcs   L0BC9
         lslb  
         lslb  
         lslb  
         lslb  
         pshs  b
         ora   ,s+
         bra   L0BC4
L0BAA    bsr   L0BB0
         bcs   L0BC9
         bra   L0BCA
L0BB0    lda   ,x+
         cmpa  #$30
         bcs   L0BC7
         cmpa  #$39
         bls   L0BC4
         anda  #$5F
         cmpa  #$41
         bcs   L0BC7
         cmpa  #$46
         bhi   L0BC7
L0BC4    andcc #$FE
         rts   
L0BC7    orcc  #$01
L0BC9    rts   
L0BCA    suba  #$30
         cmpa  #$09
         bls   L0BD2
         suba  #$07
L0BD2    bra   L0BC4
L0BD4    tst   <u002E
         lbne  L070B
         bsr   L0BFF
         lbne  L070B
         lbsr  L078F
         lbsr  L07B0
         lbsr  L078F
         leax  >L00FF,pcr
         lbsr  L0759
L0BF0    lbsr  L07F1
         lda   <u0000
         lbsr  L0C8A
         tst   <u002E
         beq   L0C74
         clr   <u002D
         rts   
L0BFF    lbsr  L078F
L0C02    clr   <u001A
         com   <u001A
         lbsr  L10F5
         leax  >L00EB,pcr
         lbsr  L0759
         lbsr  L07B0
         leax  >u01D6,u
         lbsr  L07E8
         clr   <u001A
         lbsr  L10F5
         lda   ,x
         anda  #$5F
         cmpa  #$59
         rts   
L0C26    tst   <u0001
         bne   L0C74
         clr   <u001A
         com   <u001A
         lbsr  L10F5
         lbsr  L078F
         leax  >L0110,pcr
         lbsr  L0759
         lbsr  L07B0
         leax  >u01D6,u
         ldy   #$001E
         lbsr  L0786
         clr   <u001A
         lbsr  L10F5
         cmpy  #$0001
         beq   L0C74
         pshs  x
         leay  <u006B,u
L0C59    lda   ,x+
         sta   ,y+
         cmpa  #$20
         bhi   L0C59
         lda   #$0D
         sta   -$01,y
         puls  x
         lda   #$02
         ldb   #$0B
         os9   I$Create 
         bcs   L0CB6
         sta   <u0001
         bsr   L0C77
L0C74    lbra  L070B
L0C77    ldd   #$3021
         lbsr  L0792
         leax  >L0110,pcr
         lbsr  L0759
         leax  <u006B,u
         lbra  L0774
L0C8A    leax  >u00D6,u
         ldy   <u001F
         os9   I$Write  
         bcs   L0CB6
         rts   
L0C97    lda   <u0001
         beq   L0C74
         os9   I$Close  
         bcs   L0CB6
         ldd   #$3021
         lbsr  L0792
         lbsr  L07B0
         clr   <u0001
L0CAB    bra   L0C74
L0CAD    lda   <u0001
         beq   L0CAB
         bsr   L0C8A
         lbra  L0A40
L0CB6    pshs  b
         clr   <u008B
         ldd   <u0005
         std   <u0002
         lda   <u0007
         sta   <u0004
         puls  b
         lds   <u001D
         cmpb  #$02
         beq   L0CD7
         cmpb  #$03
         bne   L0CD3
         clr   <u002D
         bra   L0CD7
L0CD3    cmpb  #$D3
         bne   L0CDA
L0CD7    lbra  L0B79
L0CDA    cmpb  #$CD
         bne   L0CF2
         tst   <u004D
         bne   L0CF2
         bsr   L0D01
         leax  >L000D,pcr
         ldy   #$0001
         lbsr  L0778
         lbra  L0708
L0CF2    pshs  b
         lbsr  L078F
         lbsr  L07B0
         puls  b
         bsr   L0D01
         lbra  L070B
L0D01    lda   #$02
         os9   F$PErr   
         clr   <u001A
         lbsr  L10F5
         leax  >u01D6,u
         lbra  L07E8
         lda   #$02
         leax  >L05AC,pcr
         ldy   #$0078
         lbsr  L077A
         clrb  
         bra   L0D34
L0D22    lbsr  L0BFF
         lbne  L070B
         lbsr  L07BA
         lda   <u0019
         sta   <u001A
         lbsr  L10F5
         clrb  
L0D34    os9   F$Exit   
L0D37    lbsr  L078F
         leax  >L009B,pcr
         lbsr  L0759
L0D41    leax  >u00D6,u
         stx   <u0014
         lda   #$01
         sta   <u0016
         lda   #$23
         sta   <u000F
         lda   #$25
         sta   <u000E
         lda   #$58
         sta   <u0010
L0D57    lbsr  L079C
         lbsr  L0E47
L0D5D    lda   <u000E
         ldb   <u000F
         tst   <u0017
         beq   L0D67
         lda   <u0010
L0D67    tst   <u008C
         lbeq  L0E37
         ldx   <u0003
         cmpx  #$0001
         lbcs  L0E37
         cmpx  <u008F
         lbhi  L0E37 
         pshs  b,a
         ldx   <u0091
         ldb   <u0093
         stx   <u0097
         stb   <u0099
         ldx   <u0094
         ldb   <u0096
         stx   <u009A
         stb   <u009C
         clra  
         ldb   <u000F
         subb  #$23
         lda   #$10
         mul   
         pshs  b,a
         clra  
         ldb   <u000E
         subb  #$25
         beq   L0DA9
         tfr   d,x
         ldd   #$0003
         lbsr  L1728
         tfr   x,d
L0DA9    addd  ,s++
         ldx   <u0003
         cmpx  <u008F
         bcs   L0DC3
         pshs  b,a
         ldd   <u008D
         clra  
         tfr   d,x
         puls  b,a
         leax  -$01,x
         pshs  x
         cmpd  ,s++
         bhi   L0DDD
L0DC3    ldx   #$0008
         lbsr  L16FE
         tfr   u,d
         addd  <u0098
         std   <u0098
         addd  #$0007
         cmpd  <u0095
         bls   L0DD9
         ldd   <u0095
L0DD9    std   <u009B
         bra   L0DE3
L0DDD    clr   <u009A
         clr   <u009B
         clr   <u009C
L0DE3    ldu   <u001B
         lbsr  L07A6
         tst   <u009C
         bne   L0DFF
         tst   <u009B
         bne   L0DFF
         tst   <u009A
         bne   L0DFF
         ldd   #$2034
         lbsr  L0792
         lbsr  L07B0
         bra   L0E32
L0DFF    lbsr  L1748
         ldd   #$4934
         lbsr  L0792
         leax  >L0226,pcr
         lbsr  L0759
         leax  >u009D,u
         lda   [<u0014,u]
         ldb   #$08
         pshs  x,a
L0E1A    lsl   ,s
         bcs   L0E22
         lda   #$30
         bra   L0E24
L0E22    lda   #$31
L0E24    sta   ,x+
         decb  
         bne   L0E1A
         puls  x,a
         ldy   #$0008
         lbsr  L0778
L0E32    lbsr  L079C
         puls  b,a
L0E37    lbsr  L0792
         leax  >u01D6,u
         tst   <u0017
         lbne  L0F38
         lbra  L0EFE
L0E47    lda   <u000E
         ldb   <u000F
         lbsr  L0792
         leay  >u01D6,u
         lda   [<u0014,u]
         pshs  a
         lbsr  L095D
         leax  -$02,y
         ldy   #$0002
         lda   #$01
         lbsr  L077A
         lda   <u0010
         ldb   <u000F
         lbsr  L0792
         puls  a
         anda  #$7F
         cmpa  #$20
         bcc   L0E76
         lda   #$2E
L0E76    leax  >u01D6,u
         sta   ,x
         ldy   #$0001
         lbra  L0778
L0E83    pshs  x,b
L0E85    clra  
         ldb   #$01
         os9   I$GetStt 
         bcc   L0ED6
         cmpb  #$F6
         bne   L0EBF
         ldx   #$0001
         os9   F$Sleep  
         bcs   L0EBF
         dec   <u0089
         lda   <u0089
         eora  <u008A
         anda  #$40
         beq   L0EB5
         com   <u008A
         beq   L0EAB
         bsr   L0EC7
         bra   L0EB5
L0EAB    leax  >L0019,pcr
         ldy   #$0002
         bsr   L0ECF
L0EB5    ldb   <u008B
         cmpb  #$02
         beq   L0EBF
         cmpb  #$03
         bne   L0E85
L0EBF    stb   ,s
         bsr   L0EC7
         puls  x,b
         bra   L0EE5
L0EC7    leax  >L0016,pcr
         ldy   #$0002
L0ECF    lda   #$01
         os9   I$Write  
         clrb  
         rts   
L0ED6    bsr   L0EC7
         puls  x,b
         ldy   #$0001
         clra  
         os9   I$Read   
         bcs   L0EE5
         rts   
L0EE5    leas  $02,s
         clr   <u008B
         cmpb  #$02
         beq   L0EF9
         pshs  b
         lbsr  L101A
         clr   <u000F
         puls  b
         lbra  L0CB6
L0EF9    com   <u0017
         lbra  L0D5D
L0EFE    bsr   L0E83
         bsr   L0F1E
         bcs   L0F4A
         lbsr  L0778
         ldb   ,x
         lbsr  L0E83
         bsr   L0F1E
         bcs   L0F4A
         exg   a,b
         lbsr  L0B09
         stb   [<u0014,u]
         lda   #$01
         sta   <u002D
         bra   L0F75
L0F1E    lda   ,x
         cmpa  #$30
         bcs   L0F35
         cmpa  #$39
         bls   L0F32
         anda  #$5F
         cmpa  #$46
         bhi   L0F35
         cmpa  #$41
         bcs   L0F35
L0F32    andcc #$FE
         rts   
L0F35    orcc  #$01
         rts   
L0F38    lbsr  L0E83
         lda   ,x
         cmpa  #$20
         bcs   L0F4A
         sta   [<u0014,u]
         lda   #$01
         sta   <u002D
         bra   L0F75
L0F4A    cmpa  #$09
         beq   L0F75
         cmpa  #$08
         beq   L0FB3
         cmpa  #$0C
         lbeq  L1020
         cmpa  #$0A
         lbeq  L1076
         cmpa  #$0D
         lbne  L0D5D
         lbsr  L101A
         ldd   #$4934
         lbsr  L0792
         lbsr  L07B0
         clr   <u000F
         lbra  L070B
L0F75    lbsr  L101A
         tst   <u0020
         beq   L0F84
         lda   <u0016
         cmpa  <u0020
         lbeq  L0D41
L0F84    ldd   <u0014
         addd  #$0001
         std   <u0014
         inc   <u0016
         inc   <u0010
         lda   <u0010
         cmpa  #$68
         bcc   L0F9E
         lda   <u000E
         adda  #$03
         sta   <u000E
         lbra  L0D57
L0F9E    inc   <u000F
         lda   <u000F
         cmpa  #$32
         lbhi  L0D41
         lda   #$25
         sta   <u000E
         lda   #$58
         sta   <u0010
         lbra  L0D57
L0FB3    bsr   L101A
         ldd   <u0014
         subd  #$0001
         std   <u0014
         dec   <u0016
         dec   <u0010
         lda   <u0010
         cmpa  #$58
         bcs   L0FCF
         lda   <u000E
         suba  #$03
         sta   <u000E
         lbra  L0D57
L0FCF    dec   <u000F
         lda   #$52
         sta   <u000E
         lda   #$67
         sta   <u0010
         lda   <u000F
         cmpa  #$23
         bcs   L0FE2
         lbra  L0D57
L0FE2    ldx   <u0014
         ldb   <u0020
         beq   L100D
         stb   <u0016
         clra  
         leax  d,x
         decb  
         pshs  b
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         addb  #$23
         stb   <u000F
         lda   ,s+
         anda  #$0F
         pshs  a
         adda  #$58
         sta   <u0010
         puls  a
         ldb   #$03
         mul   
         addb  #$25
         stb   <u000E
         bra   L1015
L100D    lda   #$32
         sta   <u000F
         leax  >$0100,x
L1015    stx   <u0014
         lbra  L0D57
L101A    lbsr  L07A6
         lbra  L0E47
L1020    bsr   L101A
         ldb   <u0020
         beq   L102C
         lda   <u000F
         cmpa  #$23
         beq   L104F
L102C    ldd   <u0014
         subd  #$0010
         std   <u0014
         ldb   <u0016
         subb  #$10
         stb   <u0016
         dec   <u000F
         lda   <u000F
         cmpa  #$23
         bcc   L104C
         lda   #$32
         sta   <u000F
         ldd   <u0014
         addd  #$0100
         std   <u0014
L104C    lbra  L0D57
L104F    andb  #$F0
         lda   <u0020
         anda  #$0F
         cmpa  <u0016
         bcc   L105B
         subb  #$10
L105B    clra  
         pshs  b,a
         ldd   <u0014
         addd  ,s+
         std   <u0014
         ldb   <u0016
         addb  ,s
         stb   <u0016
         puls  b
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         addb  #$23
         stb   <u000F
         bra   L104C
L1076    bsr   L101A
         ldb   <u0020
         beq   L1082
         subb  <u0016
         cmpb  #$10
         bcs   L10A7
L1082    ldd   <u0014
         addd  #$0010
         std   <u0014
         lda   <u0016
         adda  #$10
         sta   <u0016
         inc   <u000F
         lda   <u000F
         cmpa  #$32
         lbls  L0D57
         ldd   <u0014
         subd  #$0100
         std   <u0014
L10A0    lda   #$23
         sta   <u000F
         lbra  L0D57
L10A7    clra  
         ldb   <u0016
         decb  
         andb  #$F0
         pshs  b,a
         ldd   <u0014
         subd  ,s+
         std   <u0014
         ldb   <u0016
         subb  ,s+
         stb   <u0016
         bra   L10A0
L10BD    lbsr  L07BA
         lda   <u0019
         sta   <u001A
         bsr   L10F5
         leax  >L0136,pcr
         ldy   #$0010
         leau  >u01D6,u
         lda   #$0D
         sta   ,u
         ldd   #$0000
         os9   F$Fork   
         lbcs  L0CB6
         os9   F$Wait   
         ldu   <u001B
         leax  >u00D6,u
         stx   <u0012
         clr   <u001A
         bsr   L10F5
L10EF    lbsr  L07BA
         lbra  L0708
L10F5    pshs  x
         leas  <-$20,s
         leax  ,s
         clra  
         clrb  
         os9   I$GetStt 
         lbcs  L0CB6
         lda   <u001A
         sta   $04,x
         clra  
         os9   I$SetStt 
         lbcs  L0CB6
         leas  <$20,s
         puls  pc,x
L1116    lbsr  L078F
         leax  >L0119,pcr
         lbsr  L0759
         ldu   #$0000
         ldx   #$0000
         stx   <u0025
         lda   <u0000
         os9   I$Seek   
         lbcs  L0CB6
         ldu   <u001B
L1133    ldd   #$FFFF
         std   <u0029
         stb   <u002B
         leax  >u01D6,u
         ldy   #$0008
         lda   <u0000
         os9   I$Read   
         lbcs  L0CB6
         cmpy  #$0008
         lbne  L120E
         ldd   ,x
         cmpa  #$87
         lbne  L120E
         cmpb  #$CD
         lbne  L120E
         ldd   $02,x
         cmpd  #$000F
         lbls  L120E
         subd  #$0003
         std   <u0021
         addd  <u0025
         std   <u0025
         clra  
         ldb   #$08
L1177    eora  ,x+
         decb  
         bne   L1177
         coma  
         sta   ,x
         ldy   #$0001
         lda   <u0000
         os9   I$Write  
         lbcs  L0CB6
         ldd   <u0021
         subd  #$0009
         std   <u0021
         leax  >u01D6,u
         ldy   #$0009
         bsr   L1201
L119D    lda   <u0000
         ldy   #$0078
         cmpy  <u0021
         bls   L11AB
         ldy   <u0021
L11AB    os9   I$Read   
         bcs   L120E
         sty   <u0027
         bsr   L1201
         ldd   <u0021
         subd  <u0027
         std   <u0021
         bne   L119D
         lda   <u0000
         ldb   #$05
         os9   I$GetStt 
         tfr   u,d
         ldu   <u001B
         cmpd  <u0025
         bne   L120E
         com   <u0029
         com   <u002A
         com   <u002B
         leax  <u0029,u
         ldy   #$0003
         lda   <u0000
         os9   I$Write  
         lbcs  L0CB6
         ldd   #$0003
         addd  <u0025
         std   <u0025
         ldb   #$06
         lda   <u0000
         os9   I$GetStt 
         lbcc  L1133
         cmpb  #$D3
         lbne  L0CB6
         lbsr  L07C4
         lbra  L0708
L1201    leau  <u0029,u
         os9   F$CRC    
         lbcs  L0CB6
         ldu   <u001B
         rts   
L120E    ldd   #$2036
         lbsr  L0792
         leax  >L0125,pcr
         lbsr  L0759
         ldb   #$CD
         lbsr  L0D01
         lbra  L070B
L1223    tst   <u004D
         lbne  L070B
         ldd   #$0000
         std   <u0025
         std   <u0023
         clr   <u001A
         com   <u001A
         lbsr  L10F5
         lbsr  L078F
         lbsr  L07B0
         leax  >L013B,pcr
         lbsr  L0759
         leax  <u004D,u
         ldy   #$001E
         lbsr  L0786
         clr   <u001A
         lbsr  L10F5
         cmpy  #$0001
         lbne  L130C
         lbsr  L07BA
         clr   <u004D
         leax  >L0151,pcr
         lbsr  L0774
L1267    ldd   <u0023
         addd  <u0025
         std   <u0025
         tfr   d,u
         ldx   #$0000
         lda   <u0000
         os9   I$Seek   
         bcs   L12F8
         ldu   <u001B
         leax  >u01D6,u
         ldy   #$0006
         os9   I$Read   
         bcs   L12F8
         ldd   ,x++
         cmpa  #$87
         bne   L12F6
         cmpb  #$CD
         bne   L12F6
         leay  >u01D6,u
         ldd   ,x++
         std   <u0023
         ldd   ,x++
         pshs  b,a
         ldd   <u0025
         bsr   L12E6
         lda   #$20
         sta   ,y+
         ldd   <u0023
         bsr   L12E6
         lda   #$20
         sta   ,y+
         ldd   <u0025
         addd  ,s++
         tfr   d,u
         ldx   #$0000
         lda   <u0000
         os9   I$Seek   
         lbcs  L0CB6
         ldu   <u001B
         tfr   y,x
         ldy   #$001D
         lda   <u0000
         os9   I$Read   
         lbcs  L0CB6
L12D1    lda   ,x+
         bpl   L12D1
         anda  #$7F
         sta   -$01,x
         lda   #$0D
         sta   ,x
         leax  >u01D6,u
         lbsr  L0774
         bra   L1267
L12E6    lbsr  L095D
         tfr   b,a
         lbra  L095D
L12EE    cmpb  #$D3
         bne   L12F8
         ldb   #$DD
         bra   L12F8
L12F6    ldb   #$CD
L12F8    clr   <u004D
         cmpb  #$D3
         lbne  L0CB6
         lbsr  L07E8
         leax  >u00D6,u
         stx   <u0012
         lbra  L10EF
L130C    os9   F$PrsNam 
         lbcs  L0CB6
         stb   <u002C
         decb  
         lda   b,x
         ora   #$80
         sta   b,x
         stx   <u0029
         ldu   #$0000
L1321    ldx   #$0000
         lda   <u0000
         os9   I$Seek   
         lbcs  L0CB6
         ldu   <u001B
         leax  >u01D6,u
         ldy   #$0006
         os9   I$Read   
         bcs   L12EE
         ldd   ,x++
         cmpa  #$87
         bne   L12F6
         cmpb  #$CD
         bne   L12F6
         ldd   ,x++
         std   <u0023
         ldd   ,x
         addd  <u0025
         tfr   d,u
         ldx   #$0000
         lda   <u0000
         os9   I$Seek   
         bcs   L12EE
         ldu   <u001B
         leax  >u01D6,u
         ldy   #$001D
         os9   I$Read   
         bcs   L12EE
         tfr   x,y
         ldx   <u0029
         ldb   <u002C
         os9   F$CmpNam 
         bcc   L137E
         ldd   <u0023
         addd  <u0025
         std   <u0025
         tfr   d,u
         bra   L1321
L137E    lda   #$0D
         sta   b,x
         decb  
         lda   b,x
         anda  #$7F
         sta   b,x
         ldd   <u0025
         std   <u0008
         ldd   #$0006
         leax  u0002,u
L1392    sta   ,x+
         decb  
         bne   L1392
         lbra  L06F5
L139A    ldd   #$3020
         lbsr  L0792
         leax  >L016F,pcr
         lbsr  L0759
         leax  <u004D,u
         lbsr  L0774
         ldd   #$5820
         lbsr  L0792
         leax  >L0178,pcr
         lbsr  L0759
         leay  >u01D6,u
         ldd   <u0008
         lbsr  L12E6
         lda   #$0D
         sta   ,y
         lbra  L0778
L13CA    tst   <u004D
         lbeq  L070B
         ldd   #$0008
         leax  u0002,u
L13D5    sta   ,x+
         decb  
         bne   L13D5
         ldd   #$3020
         lbsr  L0792
         lbsr  L07B0
         lbsr  L07B0
         clr   <u004D
         lbra  L06F5
L13EB    tst   <u002E
         beq   L13FD
         clr   <u002E
         ldd   #$5933
         lbsr  L0792
         lbsr  L07B0
L13FA    lbra  L070B
L13FD    lbsr  L0BFF
         bne   L13FA
         com   <u002E
         ldd   #$5933
         lbsr  L0792
         leax  >L0181,pcr
         lbsr  L0759
         bra   L13FA
L1413    lbsr  L07BA
         leax  >L023E,pcr
         ldy   #$036E
         lbsr  L077A
         leax  >u01D6,u
         lbsr  L07E8
         lbra  L10EF
L142B    clr   <u001A
         com   <u001A
         lbsr  L10F5
         lbsr  L078F
         lbsr  L07B0
         tst   <u002F
         bne   L1471
         leax  >L0194,pcr
         lbsr  L0759
         ldy   #$0021
         lbsr  L1514
         cmpy  #$0001
         lbeq  L1559
         leay  -$01,y
         tfr   y,d
         lsrb  
         lbcs  L152E
         stb   <u0030
         leau  <u0031,u
L1460    lbsr  L0B96
         lbcs  L152E
         sta   ,u+
         leay  -$02,y
         bne   L1460
         ldu   <u001B
         bra   L1496
L1471    leax  >L01A6,pcr
         lbsr  L0759
         ldy   #$0011
         lbsr  L1514
         cmpy  #$0001
         lbeq  L1559
         tfr   y,d
         decb  
         stb   <u0030
         leay  <u0031,u
L148F    lda   ,x+
         sta   ,y+
         decb  
         bne   L148F
L1496    clr   <u001A
         lbsr  L10F5
         leax  >u00D6,u
L149F    ldb   <u0020
         leay  <u0031,u
L14A4    lda   ,y
         eora  ,x+
         lbeq  L155C
         tst   <u002F
         beq   L14B6
         bita  #$5F
         lbeq  L155C
L14B6    decb  
L14B7    bne   L14A4
         pshs  y,x,b,a
         clra  
         ldb   #$01
         os9   I$GetStt 
         bcs   L14D0
         leax  >u01D6,u
         lbsr  L07E8
         lda   ,x
         cmpa  #$05
         beq   L1546
L14D0    puls  y,x,b,a
         bsr   L14D6
         bra   L149F
L14D6    tst   <u004D
         beq   L14E3
         ldd   <u0023
         subd  #$0001
         cmpa  <u0004
         beq   L1546
L14E3    ldd   <u0003
         addd  #$0001
         std   <u0003
         bne   L14EE
         inc   <u0002
L14EE    lbsr  L07F1
         leax  >u00D6,u
         stx   <u0012
         tst   <u004D
         beq   L1505
         ldd   <u0023
         suba  <u0004
         bne   L1505
         tfr   d,y
         bra   L1509
L1505    ldy   #$0100
L1509    lda   <u0000
         os9   I$Read   
         bcs   L1540
         sty   <u001F
         rts   
L1514    leax  >u01D6,u
         clra  
         os9   I$ReadLn 
         bcs   L151F
         rts   
L151F    leas  $02,s
         clr   <u008B
         cmpb  #$02
         lbne  L0CB6
         com   <u002F
         lbra  L142B
L152E    ldu   <u001B
         bsr   L1535
         lbra  L142B
L1535    leax  >L022B,pcr
         ldy   #$0001
         lbra  L0778
L1540    cmpb  #$D3
         lbne  L0CB6
L1546    lds   <u001D
         ldd   <u0005
         std   <u0002
         lda   <u0007
         sta   <u0004
         lbsr  L07C4
         sty   <u001F
         bsr   L1535
L1559    lbra  L0B79
L155C    pshs  b
         decb  
         stb   <u0044
         stx   <u0042
         ldb   <u0030
L1565    decb  
         beq   L1597
         dec   ,s
         beq   L1588
L156C    leay  $01,y
         lda   ,y
         eora  ,x+
         beq   L1565
         tst   <u002F
         beq   L157C
         bita  #$5F
         beq   L1565
L157C    leas  $01,s
         ldx   <u0042
L1580    leay  <u0031,u
         ldb   <u0044
         lbra  L14B7
L1588    leas  $01,s
         pshs  y,b
         lbsr  L14D6
         puls  y,b
         lda   <u0020
         pshs  a
         bra   L156C
L1597    leas  $01,s
         lda   <u0004
         cmpa  <u0007
         beq   L15C0
         cmpx  <u0042
         bcc   L15B8
         ldd   <u0003
         subd  #$0001
         std   <u0003
         cmpd  #$FFFF
         bne   L15B2
         dec   <u0002
L15B2    lbsr  L07C4
         sty   <u001F
L15B8    ldd   <u0002
         std   <u0005
         lda   <u0004
         sta   <u0007
L15C0    lbsr  L081F
         ldd   <u0042
         subd  #$0001
         std   <u0014
         subd  <u0012
         pshs  b
         andb  #$0F
         pshs  b
         addb  #$58
         stb   <u0010
         puls  b
         lda   #$03
         mul   
         addb  #$25
         stb   <u000E
         puls  b
         andb  #$F0
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         addb  #$23
         stb   <u000F
         lbsr  L079C
         lbsr  L0E47
         lbsr  L07A6
         clr   <u000F
         lbra  L1559
L15F9    tst   <u0030
         lbeq  L070B
         lbsr  L078F
         leax  >L01B8,pcr
         lbsr  L0759
         ldx   <u0042
         lbeq  L1496
         lbra  L1580
L1612    lbsr  L078F
         leax  >L01C4,pcr
         lbsr  L0759
         com   <u0018
         leay  >u01D6,u
         ldd   <u0049
         lbsr  L095D
         tfr   b,a
         lbsr  L095D
         ldd   <u004B
         lbsr  L095D
         clr   <u0018
         tfr   b,a
         lbsr  L095D
         ldd   #$2020
         std   ,y++
         std   ,y++
         leax  >u01D6,u
         stx   <u0027
         tfr   y,d
         subd  <u0027
         tfr   d,y
         lbsr  L0778
         leax  >L01D9,pcr
         lbsr  L0759
         ldy   #$0009
         lbsr  L0A89
         bcs   L1612
         ldd   #$2037
         lbsr  L0792
         lbsr  L0C02
         lbne  L070B
         ldx   <u0045
         ldu   <u0047
         ldb   #$02
         lda   <u0000
         os9   I$SetStt 
         lbcs  L0CB6
         stx   <u0049
         stu   <u004B
         ldu   <u001B
         lda   <u0049
         cmpa  <u0002
         bcs   L1692
         bne   L168F
         ldd   <u004A
         cmpd  <u0003
         bls   L1696
L168F    lbra  L06F5
L1692    sta   <u0002
         ldd   <u004A
L1696    tst   <u004C
         bne   L169D
         subd  #$0001
L169D    std   <u0003
         cmpd  #$FFFF
         bne   L168F
         dec   <u0002
         bra   L168F
L16A9    lda   <u00A5
         cmpa  #$10
         bcc   L16D3
         ldb   #$03
         mul   
         leax  >u00A6,u
         leax  b,x
         ldd   <u0002
         std   ,x++
         lda   <u0004
         sta   ,x
         tst   <u00A5
         beq   L16CE
         cmpa  -$03,x
         bne   L16CE
         ldd   <u0002
         cmpa  -$05,x
         beq   L16D0
L16CE    inc   <u00A5
L16D0    lbra  L070B
L16D3    lbsr  L078F
         leax  >L022B,pcr
         lbsr  L0759
         lbsr  L07E8
         bra   L16D0
L16E2    lda   <u00A5
         beq   L16D0
         ldb   #$03
         mul   
         subb  #$03
         leax  >u00A6,u
         leax  b,x
         ldd   ,x++
         std   <u0002
         lda   ,x
         sta   <u0004
         dec   <u00A5
         lbra  L06F5
* I think this is a general purpose 16x16 bit multiplication.
* regD is first number, regX is second number.
* Returns answer in regY and regU.
L16FE    pshs  u,y,x,b,a
         clr   $04,s
         lda   $03,s     lower word of regX times regB
         mul   
         std   $06,s
         ldd   $01,s     upper word of regX times regB
         mul   
         addb  $06,s
         adca  #$00
         std   $05,s
         ldb   ,s        original regA
         lda   $03,s     upper word regX
         mul   
         addd  $05,s
         std   $05,s
         bcc   L171D
         inc   $04,s
L171D    lda   ,s
         ldb   $02,s
         mul   
         addd  $04,s
         std   $04,s
         puls  pc,u,y,x,b,a
L1728    pshs  x,b,a
         lda   #$10
         pshs  a
         clra  
         clrb  
L1730    lsl   $04,s
         rol   $03,s
         rolb  
         rola  
         cmpd  $01,s
         bcs   L173F
         subd  $01,s
         inc   $04,s
L173F    dec   ,s
         bne   L1730
         ldx   $03,s
         leas  $05,s
         rts   
L1748    ldd   #$2034
         lbsr  L0792
         leax  >L0202,pcr  BAM message
         lbsr  L0759
         leay  >u01D6,u
         pshs  y
         ldd   <u0097      get 3 byte address and display it
         lbsr  L095D       convert hex to ascii
         tfr   b,a
         lbsr  L095D       convert hex to ascii
         lda   <u0099
         lbsr  L095D       convert hex to ascii
         lda   ,-y
         ora   #$80
         sta   ,y
         ldd   #$3234
         lbsr  L0792
         ldx   ,s
         lbsr  L0759
         ldy   ,s
         ldd   <u009A
         lbsr  L095D
         tfr   b,a
         lbsr  L095D
         lda   <u009C
         lbsr  L095D
         lda   ,-y
         ora   #$80
         sta   ,y
         ldd   #$3D34
         lbsr  L0792
         puls  x
         lbsr  L0759
         rts   
         emod
eom      equ   *

         ELSE

         nam   dEd OS-9 Disk Editor Version 2.01
         ttl   Copyright 1987 Doug DeMartinis

*******************************************************
* Copyright 1987 Doug DeMartinis; All Rights Reserved *
*                CIS:    72245,1400                   *
*                Delphi: DOUGLASD                     *
* Personal use and uploading of code, source and docs *
* to BBS's, as well as customization of the terminal  *
* display codes, is permitted only if the copyright   *
* notice and docs remain intact.                      *
*                                                     *
* 10/87 Various mods & fixes by Bruce Isted (BRI)     *
* 11/87 Added Diddle, Find, Push, Remove routines.    *
*       Fixed bug throwing stack off by going in and  *
*        out of various error routines.               *
*                                                     *
*******************************************************
*                                                     *
* Mods by Roger A. Krupski (HARDWAREHACK)             *
*                                                     *
* 02/88 -Added "enter" command which cleans up the    *
*        screen by running the REDO subroutine. (RAK) *
*                                                     *
* 01/90 -Added a check for the break key which allows *
*        aborting the <F>ind function. (RAK)          *
*       -Added a check for null filename in OUTFILE:  *
*        and bypass I$Create if so.                   *
*       -Other minor bugs fixed / errors trapped.     *
*******************************************************

         ifp1            
         use   defsfile
         endc            

type     set   prgrm+objct
revs     set   reent+1   

top      mod   dEdend,dEdnam,type,revs,start,size

**************************************************************************
* To customize dEd for another driver, change the value of 'xyflipr',    *
*    change co380 to FALSE and OTHER to TRUE, and make the appropriate   *
*    changes to the display codes in the block that begins 'ifne OTHER'. *
*    WordPak users only need to change co380 to FALSE and WPAK to TRUE.  *
**************************************************************************

* Set xyflipr to 1 if XY cursor move code has form: row,col
* Set    "    to 0 "   "   "     "    "    "   "    col,row
xyflipr  set   0          co380 uses $2,Col,Row to position cursor

* Change one of the following lines to TRUE and others to FALSE,
*  depending on which 80 column display you're using.

co380    set   FALSE      Set to TRUE if using Mike Dziedzic's co380 driver
WPAK     set   FALSE      Set to TRUE if using WordPak
OTHER    set   TRUE       Set to TRUE for another driver and change codes below

* Conditional assembly of terminal commands depending on previous choices:

         ifne  OTHER     
* e.g. CoCo 3, OS-9 Level II
* Change the appropriate byte strings below for another driver

xyflipr  set   0          Change to 1 if XY Cursor move code wants form Row,Col
curscode set   $2         XY Cursor move code (max length=2 bytes)
cls      fcb   $c         Clear Screen byte string
clschrs  equ   *-cls      Don't change this.
revvid   fcb   $1F,$20,0  Reverse Video byte string. Must end with a 0.
revchrs  equ   *-revvid-1 Don't change this.
normvid  fcb   $1F,$21,0  Normal Video byte string. MUST end with a 0.
normchrs equ   *-normvid-1 Don't change this.
eraselin fcb   4          Erase to End of Line byte string.
eraschrs equ   *-eraselin Don't change this.
erasescr fcb   $b         Erase to End of Screen byte string.
era2chrs equ   *-erasescr Don't change this.

* modification by BRI
* adds cursor on/off strings & string lengths
CursrOn  fcb   $05,$21,0  Cursor on string.  MUST end with a 0.
CursOn   equ   *-CursrOn-1 Don't change this.
CursrOff fcb   $05,$20,0  Cursor off string.  MUST end with a 0.
CursOff  equ   *-CursrOff-1 Don't change this.
* end modification

         endc            

         ifne  WPAK      
* This is for WordPak driver

xyflipr  set   1          cursor move wants row,col
curscode set   $2         XY cursor move code
cls      fcb   $c         clear screen code
clschrs  equ   *-cls     
revvid   fcb   $1b,$53,$21,0 reverse video toggle
revchrs  equ   *-revvid-1 # chars in code string
normvid  fcb   $1b,$53,$20,0 normal video toggle
normchrs equ   *-normvid-1
eraselin fcb   $1b,$41    erase to end of line
eraschrs equ   *-eraselin
erasescr fcb   $1b,$42    erase to end of screen
era2chrs equ   *-erasescr

* modification by BRI
* adds cursor on/off strings & string lengths
CursrOn  fcb   0          Cursor on string.  MUST end with a 0.
CursOn   equ   *-CursrOn-1 Don't change this.
CursrOff fcb   0          Cursor off string.  MUST end with a 0.
CursOff  equ   *-CursrOff-1 Don't change this.
* end modification

         endc            

         ifne  co380     
* This is for co380 driver for CoCo3
xyflipr  set   0          cursor move wants col,row
curscode set   $2         1st byte of move cursor code
cls      fcb   $c         clear screen code
clschrs  equ   *-cls     
revvid   fcb   0          reverse video not supported by co380
revchrs  equ   *-revvid-1 # chars in code string
normvid  fcb   0          Reverse video off not supported by co380
normchrs equ   *-normvid-1
eraselin fcb   4          erase to end of line
eraschrs equ   *-eraselin
erasescr fcb   $b         erase to end of screen
era2chrs equ   *-erasescr

* modification by BRI
* adds cursor on/off strings & string lengths
CursrOn  fcb   0          Cursor on string.  MUST end with a 0.
CursOn   equ   *-CursrOn-1 Don't change this.
CursrOff fcb   0          Cursor off string.  MUST end with a 0.
CursOff  equ   *-CursrOff-1 Don't change this.
* end modification

         endc            

***********************************************************************
* All the changes for customizing dEd should be done above this line. *
***********************************************************************


* Don't change the following 2 blocks.
* X,Y coordinates of various screen prompts
         ifne  xyflipr   
hedrpos  set   $2220      Header position (row/col)
cmdpos   set   $3620      Command position
cmd1pos  set   $3720      Command position + 1 row
outpos   set   $2130      Output pathlist position
modpos   set   $2030      Module name position
offpos   set   $2058      Offset position
xprtpos  set   $3435      EXPERT position

         else            

hedrpos  set   $2022     
cmdpos   set   $2036      Command position
cmd1pos  set   $2037      Command position + 1 row
outpos   set   $3021      Output pathlist position
modpos   set   $3020      Module name position
offpos   set   $5820      Offset position
xprtpos  set   $3534      EXPERT position
         endc            

****************************
* Variable Storage
****************************

bufsiz   equ   120       
MaxStack equ   16         maximum # sectors that can be 'pushed' onto stack

inpath   rmb   1          input path #
outpath  rmb   1          output path #
lsn      rmb   3          Logical Sector number
oldlsn   rmb   3          LSN backup
offset   rmb   2          'Linked' module offset
cursor   rmb   4          Move cursor code
hexcol   rmb   1          Hex dump column #
rownum   rmb   1          Row number (Hex 0-f)
asciicol rmb   1          ASCII dump col #
lastflag rmb   1          Flag for last line display
buffptr  rmb   2          Pointer for input buffer
edbufptr rmb   2          Edit buffer pointer
edpos    rmb   1          Edit position counter for partial sector reads
hexascii rmb   1          hex/ascii edit mode flag; 0=>Hex, FF=>ASCII
zeroflag rmb   1          leading zero suppression flag, $FF=>Suppress
oldecho  rmb   1          original echo status
echobyte rmb   1          current echo status
Usave    rmb   2          U register storage
Ssave    rmb   2          S register storage
seclen   rmb   2          sector length ($100 unless last LSN in file)
vmodlen  rmb   2          Verify module length
lmodlen  rmb   2          'Linked' module length
fileln   rmb   2          cumulative file length
bytsread rmb   2          bytes read during verify
CRC      rmb   3          CRC accumulator for verify
modnmlen rmb   1          'Link' module name length
wrtflag  rmb   1          Flag to auto-write sector
xprtflag rmb   1          Expert mode flag
FHexAsc  rmb   1          'Find' Hex/Ascii mode flag
targlen  rmb   1          length of string to find
findstr  rmb   17         string to 'Find'
FindPtr  rmb   2          pointer to byte to start next search at
FBytes   rmb   1          # bytes left in target string
HexBuff  rmb   4          scratch area for ASCII to Hex conversions
FileLen  rmb   4          File length
infile   rmb   30         linked module name
outfile  rmb   30         Output filename

* modification by BRI
CrsrCnt  rmb   1          8-bit cursor toggle counter (bit 3 active)
CrsrFlg  rmb   1          cursor toggle (initialized to 0)
SgnlCode rmb   1          intercept routine signal code
* end modification

StackCnt rmb   1          # sectors on stack
Stack    rmb   3*MaxStack room for 16 LSN's

inbuff   rmb   256        input buffer
i.o.buff rmb   bufsiz     input/output buffer
         rmb   200        stack storage 
size     equ   .          end of data area

dEdnam   fcs   /dEd/     
         fcb   3          version
         fcc   /Copyright 1987 Doug DeMartinis/

* Display messages

lsntitle fcs   /LSN=$/   
sect     fcs   /SECTOR = $/
header   fcc   /      0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F    0 2 4 6 8 A C E /
         fcb   $d        
command  fcs   /CMD: /   
edprompt fcs   "<BREAK> toggles HEX/ASCII edit modes     <ENTER> exits edit mode"
zaprompt fcs   /Zap /    
byte     fcs   /byte: /  
char     fcs   /char: /  
sure     fcs   "Are you sure? (Y/N) "
writing  fcs   /Writing sector.../
out$     fcs   /OUTFILE: /
vrfymess fcs   /Verifying.../
verrmess fcs   /Verify aborted.../
shell$   fcs   /shell/   
linkmess fcs   /Link to which module? /
linkhdr  fcc   /Off  Len  Name/
         fcb   $a        
         fcc   /---- ---- ----/
         fcb   $d        
modnmhdr fcs   /MODULE:  /
offmess  fcs   /OFFSET: $/
xprtmess fcb   $1f,$24    cc3 blink on
         fcc   /- Expert Mode -/
         fcb   $1f,$25+$80 blink off
findbyte fcs   /Find byte string $/
findchar fcs   /Find char string: /
srchmess fcs   /Searching.../
lenmess  fcs   /Current File Length $/
newmess  fcs   /New Length? $/
fullmess equ   *         
bell     fcb   7         
         fcs   /Sector Stack Full /

* modification by BRI
* alphabetized help list,
* removed redundant 'Close' message,
* added prompt at end
helper   fcc   "   Up/Down Arrows  Read & display Next/Previous sector"
         fcb   $a,$a     
         fcc   / <CR> Clean up the screen display/
         fcb   $a        
         fcc   /   $  Fork a SHELL (Ctrl-BREAK to return)/
         fcb   $a        
         fcc   /   A  Append displayed sector to output file/
         fcb   $a        
         fcc   /   C  Close output file/
         fcb   $a        
         fcc   /   D  Diddle (adjust) file length/
         fcb   $a        
         fcc   /   E  Edit the displayed sector/
         fcb   $a        
         fcc   /   F  Find a byte or text string (BREAK aborts)/
         fcb   $a        
         fcc   /   H  Help screen (also use '?')/
         fcb   $a        
         fcc   /   L  Link to a module - List all modules/
         fcb   $a        
         fcc   /   N  Next occurrence of byte(s) or string (Find)/
         fcb   $a        
         fcc   /   O  Open a file for output (use with Append)/
         fcb   $a        
         fcc   /   P  Push current sector onto stack/
         fcb   $a        
         fcc   /   Q  Quit dEd - Exit to OS9/
         fcb   $a        
         fcc   /   R  Remove and display a sector from stack/
         fcb   $a        
         fcc   /   S  Skip to given sector (sector # in hex)/
         fcb   $a        
         fcc   /   U  Unlink from module/
         fcb   $a        
         fcc   /   V  Verify all modules in file/
         fcb   $a        
         fcc   /   W  Write the sector back to the disk/
         fcb   $a        
         fcc   "   X  eXpert mode toggle on/off"
         fcb   $a        
         fcc   /   Z  Zap (fill in) the sector displayed/
         fcb   $a,$a     
         fcc   /      (Press any key to return to command prompt):/
*fcb $a
helpchrs equ   *-helper  
* end modifications

hints    fcc   /Use:  dEd <pathlist>/
         fcb   $0d       

* Table for converting Hex to Decimal

decimals fcb   $98,$96,$80 Decimal 10,000,000
         fcb   $0f,$42,$40 Decimal 1,000,000
         fcb   $01,$86,$A0 Decimal 100,000
         fcb   $00,$27,$10 Decinal 10,000
         fcb   $00,$03,$E8 Decimal 1,000
         fcb   $00,$00,$64 Decimal 100
         fcb   $00,$00,$0A Decimal 10
         fcb   $00,$00,$01 etc.

commands fcb   $c         up arrow
         fdb   nxtsec    
         fcb   $a         down arrow
         fdb   prevsec   
         fcb   '$         shell
         fdb   goshell   
         fcb   $d         c/r clean up screen
         fdb   redo      
         fcb   's         LSN change
         fdb   changLSN  
         fcb   'z         zap
         fdb   zap       
         fcb   'w         write sector
         fdb   writesec  
         fcb   'o         open output file
         fdb   openout   
         fcb   'a         append to out file
         fdb   append    
         fcb   'c         close out file
         fdb   closeout  
         fcb   'e         edit sector
         fdb   edit      
         fcb   'q         quit
         fdb   quit      
         fcb   'v         verify
         fdb   verify    
         fcb   'l         'link' to module
         fdb   linker    
         fcb   'u         'unlink' module
         fdb   unlinker  
         fcb   'x         Expert mode
         fdb   expert    
         fcb   'h         Help
         fdb   help      
         fcb   '?        
         fdb   help      
         fcb   'f        
         fdb   find      
         fcb   'n        
         fdb   next      
         fcb   'd        
         fdb   diddle    
         fcb   'p        
         fdb   push      
         fcb   'r        
         fdb   remove    
         fcb   0          end of table

* Intercept signals
* modification by BRI
*icept  rti
icept    stb   SgnlCode,u save signal code
         rti             
* end modification


start    equ   *          entry point

         stx   inbuff     save pointer to param
         leax  icept,pcr  intercept routine addr
         os9   f$icpt     set up intercept
         lbcs  error     

* Initialize data area

         clra            
         ldb   #inbuff    # bytes to clear
         leax  ,u         point X to start of data area
init     sta   ,x+        zero memory
         decb             dec counter
         bne   init       loop if not done
         stu   Usave      save U register
         sts   Ssave      save Stack pointer

setcurs  ldd   #curscode  cursor move code
         std   cursor     save it for output
         leas  -32,s      make room for terminal options
         leax  ,s         point x to 32 byte buffer
         clra             path = 0 (stdin)
         clrb             (SS.OPT - option status)
         os9   i$getstt   read in option table
         lbcs  error     
         lda   4,x        get echo status byte
         sta   oldecho    save it
         leas  32,s       reset stack

* Open file

         ldx   inbuff     pointer to file name
         lda   #updat.    mode=update
         os9   i$open     open file

* modification by BRI
* lbcs bye exit if error
         bcc   OpenOK    
         cmpb  #E$FNA     no permission?
         lbne  bye        no, go exit with error
         ldx   inbuff     pointer to file name
         lda   #DIR.+UPDAT. mode=directory+update
         os9   I$Open     open file
         lbcs  bye        exit if error
OpenOK   equ   *         
* end modification

         sta   inpath     save input path #
         ldb   #ss.size  
         os9   i$getstt   get file size
         stx   FileLen    save
         stu   FileLen+2 
         ldu   Usave      restore U
         clr   echobyte   no echo flag
         lbsr  echo       set echo status
         lbsr  clrscr     go clear screen

* Main Read/Display loop

readloop lbsr  seeksec    find sector & read it
         sty   seclen     bytes read ($100 unless last LSN in file)
         ldd   lsn        get lsn just read
         std   oldlsn     & save it
         lda   lsn+2      for retrieval
         sta   oldlsn+2   after read errors
         ldd   #0         Signal 'Next' command to start
         std   findptr    search at start of LSN
disploop lbsr  display    go display sector
getcmd   lbsr  movecmd    move cursor
         leax  command,pcr point to 'CMD: '
         bsr   pstring    display line
         leax  erasescr,pcr erase to end of screen
         ldy   #era2chrs 
         os9   i$write   
         lbcs  error     
         leax  i.o.buff,u point to buffer to read into
         lbsr  read1      read a char from stdin
         lda   ,x         get char read
         cmpa  #'A        alpha char?
         blo   srchtabl   no, leave it alone
         ora   #$20       else UPPER -> lower case
srchtabl leax  commands,pcr point to command table
findcmd  cmpa  ,x+        got command?
         beq   gotcmd     yes, bra
         leax  2,x        else, skip address
         tst   ,x         end of table?
         bne   findcmd    no, loop back
         bra   getcmd     key invalid, exit
gotcmd   tst   xprtflag   expert mode?
         beq   jmpcmd     no, bra
         tst   wrtflag    need to write buffer out
         beq   jmpcmd     no, bra
         pshs  x,a       
         lbsr  xprtwrt    write sector
         puls  a,x       
jmpcmd   ldd   ,x         get address offset
         leax  top,pcr    start of module
         jmp   d,x        jump to offset addr


* Print string of characters having bit 7 of last char set

pstring  leay  i.o.buff,u output buffer
         clrb             counter
xfer     incb            
         lda   ,x+        get char
         bmi   lstchar    bra if bit 7 set
         sta   ,y+        put in buffer
         bra   xfer       get more
lstchar  anda  #$7f       clr bit 7
         sta   ,y         put in buffer
         leax  i.o.buff,u point to char string
         clra            
         tfr   d,y        y= length of string
         bra   writeout  

wrtlin1  ldy   #bufsiz    write 200 chars max
writeout lda   #1         stdout
wrtlin2  os9   i$writln   write line
         lbcs  error     
         rts             

readlin3 ldy   #3         # chars to read
readlin  clra             stdin
         os9   i$readln   read in Y-1 chars + CR
         lbcs  error     
         rts             

movecmd  ldd   #cmdpos   
movecurs leax  cursor,u   point to cursor move code
         std   2,x        save row/col
         ldy   #4         4 chars
         bra   writeout  

* Set display to reverse video

revdisp  leax  revvid,pcr point to code
         ldy   #revchrs   # chars
         bra   writeout   write to stdout

* Set display to normal video

normdisp leax  normvid,pcr point to code
         ldy   #normchrs  # chars
         bra   writeout   write to stdout


clrline  leax  eraselin,pcr point to erase line code
         ldy   #eraschrs  # chars
         bra   wrtlin2    go erase rest of line & return

clrscr   leax  cls,pcr    point to clear screen code
         ldy   #clschrs   #chars
         bra   writeout   clear screen & return

seeksec  bsr   lsnseek    seek to sector
         leax  inbuff,u   point to buffer
         stx   buffptr    save pointer
         tst   infile     module linked?
         beq   read256    no, bra
         ldd   lmodlen    linked mod length
         suba  lsn+2      >$100 bytes left?
         bne   read256    yes, bra
         tfr   d,y        no, set up for smaller read
         bra   readsome  
read256  ldy   #$100      read 256 bytes
readsome lda   inpath     path #
read     os9   i$read     read them in
         lbcs  error     
         rts             

******************************
* changed to ignore errors 01/09/90 (RAK)
*
read1                    
         clra             stdin
         ldy   #1         get 1 byte
         os9   I$Read     get 1 byte
         rts              ignore any errors
* bra read
****************************** END of modification

lsnseek  tst   infile     module linked?
         bne   offchk     yes, bra
         ldx   lsn        x=lsn MS 16 bits
         lda   lsn+2      get 3rd byte of lsn
         clrb            
lsnseek1 tfr   d,u        u=LS 16 bits
         lda   inpath     get input path #
         os9   i$seek     seek lsn
         lbcs  error     
         ldu   usave      restore U
lsnrts   rts             

offchk   ldd   lmodlen    linked mod length
         subd  #1         now A=LSN of last sector
         cmpa  LSN+2      trying to read past last sector?
         bhs   offseek    no, bra
         ldb   #e$eof     yes, set EOF error
         lbra  error     
* If module is 'linked' must add offset to functional LSN ->true seek count
offseek  ldd   offset    
         adda  lsn+2      offset + 'LSN'
         ldx   #0        
         bra   lsnseek1   seek to 'LSN'

display  ldd   #$2020    
         lbsr  movecurs  
         leax  lsntitle,pcr point to "lsn..."
         lbsr  pstring   
         bsr   clrline    clear rest of line
         bsr   convert3   convert lsn to ascii/dec
         leax  i.o.buff,u
         lbsr  wrtlin1   

         tst   infile     is a module 'linked'?
         beq   nolink     no, bra
         lbsr  prntmod    yes, display name

nolink   tst   outpath    is an output file open?
         beq   noout      no, bra
         lbsr  prntout    yes, print name

noout    ldd   #hedrpos   get header row/col
         lbsr  movecurs   move cursor
         leax  revvid,pcr point to reverse video code
         ldy   #revchrs   # chars
         lbsr  wrtlin2   
         leax  header,pcr point to header
         lbsr  wrtlin1    display it
         leax  normvid,pcr point to normal vid code
         ldy   #normchrs  # chars
         lbsr  wrtlin2    write code out
disp     lbsr  dsplylin  
         lda   rownum     get row #
         adda  #$10       next row
         sta   rownum     save it
         bne   disp       do 16 rows
         leax  inbuff,u  
         stx   buffptr    reset buffer pointer
         tst   xprtflag   Expert mode?
         beq   lsnrts     no, return
         ldd   #xprtpos  
         lbsr  movecurs  
         leax  xprtmess,pcr
         lbra  pstring    display 'EXPERT' & return

* Convert 3 HEX bytes to ASCII

convert3 ldd   lsn        get 2 MSB's of LSN
         com   zeroflag   suppresw leading zeroes
         leay  i.o.buff,u point to output buffer
         bsr   convert1   convert byte in A to ascii
         tfr   b,a       
         bsr   convert1   and convert 2nd byte
         clr   zeroflag   stop suppressing leading 0's
         lda   lsn+2      get LSB of LSN
         bsr   convert1   and convert it
         ldd   #$2020     2 space
         std   ,y++       put in out buffer

*   Output LSN as decimal number

         ldd   #$0008     8 dec digits max, 0=counter
         pshs  d          save them
         com   zeroflag   suppress leading zeroes
         leax  decimals,pcr point to conversion table
initsub1 clr   ,s         set counter = 0
subdec1  ldd   lsn+1      get LSB's of LSN
         subd  1,x        subtract LSB's of table entry
         pshs  cc         save 'carry'
         std   lsn+1      save result
         lda   lsn        get MSB
         clrb             flag for enough subtractions
         suba  ,x         subtract MSB of LSN
         bcc   LSBborow   if no 'borrow', see if LSB sub needed borrow
         incb             else, enough subs done
LSBborow puls  cc         restore LSB 'borrow' flag
         bcc   savemsb    save byte if borrow not needed
         suba  #1         else do borrow, setting flags
savemsb  sta   lsn        save MSB
         bcc   chekenuf   bra if no borrow needed by last dec
         incb             else set flag ->enuf subs done
chekenuf tstb             enuf subs done?
         bne   enufsub1   Yes, bra
         inc   ,s         else, inc decimal counter
         bra   subdec1    and do more subtractions
enufsub1 ldd   lsn+1      get value
         addd  1,x        make it positive again
         std   lsn+1      and save
         lda   lsn        get MSB
         bcc   addmsb     'Carry' bit still valid from 'addd 1,x'
         inca             do carry from LSB's
addmsb   adda  ,x         make rest of remainder positive
         sta   lsn        and save it for next round of sub
         leax  3,x        point X to next table entry
         bsr   decascii   go convert decimal counter to ascii
         dec   1,s        dec counter (8 digits)
         beq   getCR      Yes, exit
         lda   1,s        down to last 2 digits?
         cmpa  #2        
         bne   initsub1   no, loop back
         clr   zeroflag   else stop suppressing leading 0's
         bra   initsub1  

getCR    lda   #$d        <CR>
         sta   ,y         put in out string
         ldd   oldlsn+1   restore LSN
         std   lsn+1     
         lda   oldlsn    
         sta   lsn       
         puls  d,pc      

* Convert HEX byte in A to ASCII and put in buffer (Y)

convert1 pshs  a          save byte
         lsra             shift msn to lsnibble
         lsra            
         lsra            
         lsra            
         bsr   objasc    
         puls  a          get byte back
         anda  #$0f       mask off msb
         bsr   objasc     convert if to ascii
         rts             
objasc   cmpa  #9         digit?
         ble   asciify    yes, make it ascii
         adda  #7        
asciify  adda  #$30       makes it ascii
         sta   ,y+        and put it in buffer
         tst   zeroflag   suppressing leading zeroes?
         beq   convdone   no, exit
         cmpa  #'0        was it a zero?
         beq   suppres0   Yes, go 'erase' it
         clr   zeroflag   No, so stop suppressing 0's
convdone rts             
suppres0 leay  -1,y       reset pointer back over zero
         rts             

* Convert object decimal # on stack to ASCII & put in buffer (Y)

decascii pshs  a          save this
         lda   3,s        get decimal counter
         bsr   asciify    make it ascii
         puls  a,pc       get byte back & return


dsplylin leay  i.o.buff,u point to output buffer
         leax  revvid,pcr
         lbsr  transfer   put in reverse video code
         lda   seclen+1   LSB of # bytes read
         beq   notlast    skip ahead if 0 (seclen=$100)
         anda  #$f0       mask off LSB
         cmpa  rownum     current display row = last?
         bne   notlast    no, go on
         lda   #$ff      
         sta   lastflag   signal last line
notlast  lda   rownum     get row number
         bsr   convert1   convert it to hex byte
         lda   #':       
         sta   ,y+       
         leax  normvid,pcr point to code
         bsr   transfer   move code to buffer
         ldd   #$2020     spaces
         std   ,y++      
         ldx   buffptr    get buffer pointer
         ldb   #$10       16 bytes
         tst   lastflag   last line?
         beq   cnvrtbyt   no, bra
         ldb   seclen+1   bytes read
         andb  #$0f       now B=bytes for lst line
         beq   noline     bra if no bytes left
         pshs  b          save this
cnvrtbyt lda   ,x+        get byte from buffer
         bsr   convert1   convert it to hex
         lda   #$20       space
         sta   ,y+        put in output buffer
         decb             done?
         bne   cnvrtbyt   No, do more
         tst   lastflag   lst line?
         beq   addspc2    no, bra
         ldd   #$0310     B=max bytes on line
         subb  ,s         b=# bytes to null out
         mul              3 spaces per byte
         lda   #$20       space
addspc1  sta   ,y+        put in buffer
         decb             done?
         bne   addspc1   
addspc2  ldb   #$20       space
         std   ,y++      
         sta   ,y+        output spaces
         ldx   buffptr    get buff pointer again
         asrb             b=$10 (16 bytes)
         tst   lastflag   lst line?
         beq   ascichar   no, bra
         ldb   ,s         yes, get # bytes from prior calc
ascichar lda   ,x+        get byte
         anda  #$7f       clear bit 7
         cmpa  #$20       <32?
         bhs   printabl   yes, print as is
notascii lda   #'.        Non-ascii char
printabl sta   ,y+        put in buff
         decb             done?
         bne   ascichar  
         stx   buffptr    save new buffer pointer
         tst   lastflag   last line?
         beq   addCR      no, bra
         ldb   #$10       max bytes per line
         subb  ,s+        b=bytes to null out
         lda   #$20       space
addspc3  sta   ,y+        put in buffer
         decb            
         bne   addspc3   
         lda   #$f0       last row num
         sta   rownum     -> displays no more rows
         bsr   addCR      display line
resetlst clr   lastflag   reset flag
         leax  erasescr,pcr point to erase to end of screen code
         ldy   #era2chrs  length of string
         lbra  writeout   erase end of screen & return
addCR    lda   #$d        <CR>
         sta   ,y        
         leax  i.o.buff,u
         lbra  wrtlin1    go display this line & return

transfer lda   ,x+        get byte
         beq   trandone   exit if done
         sta   ,y+        move it
         bra   transfer   do more
trandone rts              return

noline   lda   #$f0      
         sta   rownum     signal last row
         bra   resetlst   go erase rest of screen


* Point to next LSN in file

nxtsec   ldd   lsn+1      get 2 lower bytes of lsn
         addd  #1         next lsn
         std   lsn+1      save it
         bne   readsec    d<>0 => carry not needed
         inc   lsn        else add carry to MSB of LSN
readsec  lbra  readloop   go read next sector

* Point to previous LSN unless at LSN 0 now

prevsec  ldd   lsn+1      get lsn
         bne   notfirst   <>0 => not LSN 0
         tst   lsn        LSN 0?
         lbeq  getcmd     yes, exit
notfirst subd  #1         else dec LSN
         std   lsn+1      save it
         cmpd  #$ffff     borrow needed if LSN was $xx0000
         bne   readsec    if not, go read
         dec   lsn        do 'borrow'
         bra   readsec    go read previous sector


* Change LSN sub

changLSN lbsr  movecmd   
         leax  sect,pcr   display message
         lbsr  pstring   
         ldy   #7         max # chars to read
         bsr   MakeHex    read & convert them
         bcs   BadLSN    
         ldd   HexBuff+2  get new LSN from buffer
         std   lsn+1     
         lda   HexBuff+1 
         sta   lsn       
         lbra  readloop   go read/display new LSN

BadLSN   lbsr  beep      
         bra   changLSN  

MakeHex  pshs  y          save # bytes to read
         clr   echobyte  
         com   echobyte   echo on
         lbsr  echo       set echo
         puls  y         
         leax  i.o.buff,u point to buffer
         lbsr  readlin    read chars from keyboard
         clr   echobyte  
         lbsr  echo       echo off
         leay  -1,y       strip off CR
         beq   ExitHex    exit if no chars input
         tfr   y,d        # of bytes read -> B
CheckHex lda   ,x+        get char
         bsr   hexdigit   see if it's valid char
         bcs   invalid    if not, beep & redo
         decb             done?
         bne   CheckHex  
         sty   HexBuff    save counter for now
getascii lda   #'0        leading zero, if needed
         ldb   ,-x        get a char
         leay  -1,y       last one?
         beq   cnvrt2     yes, bra
         lda   ,-x        else, get next char in A
         leay  -1,y       dec counter
cnvrt2   bsr   asciihex   convert ascii chars in A/B to hex byte
         pshs  b          save hex byte
         cmpy  #0         all done?
         bne   getascii   no, do more
         ldb   HexBuff+1  else, get # ascii chars 1st read
         incb             get ready for divide
         lsrb             divide by 2 -># of HEX bytes
         clra             leading 0
         leax  HexBuff,u  point to storage
         cmpb  #4         4 hex bytes on stack?
         beq   hexstack   yes, no leading zeroes needed
         sta   ,x+        else, put in leading 0
         cmpb  #3         3 hex bytes on stack?
         beq   hexstack   yes, no more 0's needed
         sta   ,x+        else, put in 0
         cmpb  #2         2 hex bytes?
         beq   hexstack   yes, bra
         sta   ,x+        else, put in another 0
hexstack puls  a          get a hex byte off stack
         sta   ,x+        and put in templsn
         decb             done?
         bne   hexstack   no, bra
         clrb             clear carry bit
         rts             

invalid  lbsr  beep      
coma     set   carry      bit
rts                      

ExitHex  leas  2,s        strip off return address
         lbra  readloop   exit

hexdigit cmpa  #'0        char <0?
         blo   nothex     yes, bra
         cmpa  #'9        char <9 (digit)?
         bls   ishex      yes, bra
         anda  #$5f       lower->UPPER case
         cmpa  #'F        char >F?
         bhi   nothex     yes, bra
         cmpa  #'A        char <A?
         blo   nothex     yes, bra
ishex    clra             clear carry bit if char is hex
         rts             
nothex   coma             set carry bit if not hex char
         rts             

asciihex bsr   hexnib     convert B to LSNibble
         pshs  b          save LSNib
         tfr   a,b        get ready for MSN
         bsr   hexnib     convert it
         aslb             shift LSNib to MSN
         aslb            
         aslb            
         aslb            
         orb   ,s+        add in LSNib from stack
         rts             

hexnib   subb  #$30       convert asci # to hex
         cmpb  #$9        <=9?
         bls   nowhex     yes, bra
         andb  #$5f       lower->UPPER case
         subb  #7         else sub 7 or $A$F
nowhex   rts             

* Zap sector sub

zap                      
         clr   echobyte  
         com   echobyte   echo on
         lbsr  echo       set echo
         lbsr  movecmd   
         lbsr  clrline    clear line
         leax  zaprompt,pcr point to 'Zap '
         lbsr  pstring    print it
         tst   hexascii   ascii mode?
         bne   zapascii   yes, bra
         leax  byte,pcr   point to 'byte: '
         lbsr  pstring    print it
         ldy   #3         2 chars + CR
         bsr   zapread    read in chars
         bsr   hexobjct   convert to object
         bcs   exitzap    exit if invalid chars
zapstart leax  inbuff,u   point to data buffer
         stx   buffptr    new pointer
         clrb             counter
zapbuff  sta   ,x+        do zap
         decb             done?
         bne   zapbuff    no, loop
         clr   echobyte   echo off
         lbsr  echo       set echo
         inc   wrtflag    signal for auto-write if expert mode
         lbra  disploop   display zapped buffer

zapread  clra             stdin
         leax  i.o.buff,u point to buffer
         os9   i$readln   read in line
         bcs   cheksig1   check for break key if error
         rts              else return
cheksig1 cmpb  #2         break key signal?
         lbne  error      no, process error
         com   hexascii   yes, toggle hex/ascii flag
         leas  2,s        pull return addr off stack
         bra   zap        redo routine

exitzap  clr   echobyte   echo off
         lbsr  echo      
         lbra  getcmd     get new command

zapascii leax  char,pcr   point to 'char: '
         lbsr  pstring    print it
         ldy   #2         1 char + CR
         bsr   zapread    read in char
         lda   ,x         get char
         cmpa  #$20       valid ascii char?
         blo   exitzap    no, exit
         bra   zapstart   go do zap

* Convert 2 hex chars in buffer (X) to object byte

hexobjct bsr   cnvrtnib   convert 1st nibble
         bcs   badrts     exit if bad char
         tfr   a,b        save 1st byte (MS nibble)
         bsr   cnvrtnib   convert 2nd nibble
         bcs   badrts     exit if bad char
         aslb             shift LS nib to MS nib
         aslb            
         aslb            
         aslb            
         pshs  b          save
         ora   ,s+        add MS nib to LS nib
         bra   goodhex    exit

cnvrtnib bsr   isithex    is it valid char?
         bcs   badrts     no, exit
         bra   cnvrthex   yes, convert it to object

isithex  lda   ,x+       
         cmpa  #'0        <0?
         blo   badhex     yes, bra
         cmpa  #'9        <9?
         bls   goodhex    yes, bra
         anda  #$5F       lower->UPPER case
         cmpa  #'A        <A?
         blo   badhex     yes, bra
         cmpa  #'F        >F?
         bhi   badhex     yes, bra
goodhex  andcc  #$FE       clear carry bit if valid
         rts             
badhex   orcc  #1         set carry bit if invalid
badrts   rts             

cnvrthex suba  #$30       convert char to object
         cmpa  #9         decimal digit?
         bls   nowobjct   yes, done
         suba  #7         else, A-F
nowobjct bra   goodhex    clear carry & return

* Write current sector back to disk

writesec tst   xprtflag   expert mode on?
         lbne  getcmd     yes, exit
         bsr   rusure     Sure?
         lbne  getcmd     no, exit
         lbsr  movecmd   
         lbsr  clrline    clear line
         lbsr  movecmd   
         leax  writing,pcr point to message
         lbsr  pstring    display it
xprtwrt  lbsr  lsnseek    seek to start of sector
         lda   inpath     get path #
         lbsr  write100   write out sector
         tst   xprtflag   doing auto-write
         beq   opendone   no, go to getcmd
         clr   wrtflag    signal no more auto-write
         rts              else & return to caller

* Ask 'Are you sure?' and get response

rusure   lbsr  movecmd   
rusure10                 
         clr   echobyte  
         com   echobyte   echo on
         lbsr  echo       set echo
         leax  sure,pcr   point to 'Sure? '
         lbsr  pstring    print it
         lbsr  clrline    blank rest of line
         leax  i.o.buff,u input buffer
         lbsr  read1      read answer
         clr   echobyte   echo off
         lbsr  echo       set echo
         lda   ,x         get response
         anda  #$5f       lower->UPPER case
         cmpa  #'Y        set flags
         rts             

* Open output file sub

openout  tst   outpath    is a file open already?
         bne   opendone   yes, exit
         clr   echobyte  
         com   echobyte   echo on
         lbsr  echo       set echo
         lbsr  movecmd    position cursor
         leax  out$,pcr   point to prompt
         lbsr  pstring    print it
         lbsr  clrline    clear rest of line
         leax  i.o.buff,u point to input buffer
         ldy   #30        29 chars + CR
         lbsr  readlin    read in a line (pathlist)
         clr   echobyte   echo off
         lbsr  echo       set echo

***********************************************
* Return to command prompt if no filename given
* Added 01/09/90 (RAK)
*
         cmpy  #1         <enter> only pressed?
         beq   opendone   yes, abort
*
********************************** END modification

         pshs  x          save pointer to pathlist
         leay  outfile,u  point to storage area
savname  lda   ,x+        get a char from name
         sta   ,y+        save it
         cmpa  #$20       space or CR?
         bhi   savname   
         lda   #$0d       CR
         sta   -1,y       delimit filename
         puls  x          restore pointer to name
         lda   #write.    Access mode = Write
         ldb   #%00001011 attr ----R-wr
         os9   I$Create   create & open file
         bcs   error      exit if error
         sta   outpath    save output path #
         bsr   prntout   
opendone lbra  getcmd     exit

* move cursor & print 'Output pathlist'

prntout  ldd   #outpos   
         lbsr  movecurs  
         leax  out$,pcr   point to 'OUTFILE:'
         lbsr  pstring    print it
         leax  outfile,u  point to name
         lbra  wrtlin1    write name & return


* Write out a sector

write100 leax  inbuff,u   point to data
         ldy   seclen     # chars in sector
         os9   i$write    write sector
         bcs   error     
         rts             

* Close output file sub

closeout lda   outpath    get output path #
         beq   opendone   exit if none open
         os9   i$close    close it
         bcs   error     
         ldd   #outpos   
         lbsr  movecurs  
         lbsr  clrline   
         clr   outpath    flag no output file open
closed   bra   opendone   exit

* Append sector to output file sub

append   lda   outpath    get output path #
         beq   closed     exit if no file open
         bsr   write100   write sector out
         lbra  nxtsec     read in next sector & display it


* ERROR handling routine

error    pshs  b          save error code

* modification by BRI
         clr   <SgnlCode  clear intercept routine signal code
* end modification

         ldd   oldlsn     MSBs of last LSN read
         std   lsn        make it current LSN
         lda   oldlsn+2   LSB of last LSN
         sta   lsn+2      move it
         puls  b          error code
         lds   Ssave      restore Stack pointer
         cmpb  #2         break?
         beq   endexit    yes, don't worry
         cmpb  #3         shift break?
         bne   eofchk     no check if EOF
         clr   wrtflag    cancel auto-write
         bra   endexit   
eofchk   cmpb  #e$eof     EOF error?
         bne   true.err   exit
endexit  lbra  exitzap   
true.err cmpb  #e$bmid    bad module ID error?
         bne   othererr   no, bra
* If module is linked, BMID error must come from trying to Verify modules
* use standard error reporting routine. Otherwise BMID error occurs when
* trying to link (or list names of) modules; need to clear screen after these.
         tst   infile     module linked?
         bne   othererr   yes, use std error routine
         bsr   prterr     else display error #
         leax  cls,pcr   
         ldy   #clschrs  
         lbsr  writeout   clear screen
         lbra  disploop   & redisplay sector
othererr pshs  b          save error code
         lbsr  movecmd    position cursor
         lbsr  clrline   
         puls  b          pull error code
         bsr   prterr     print error # on cmd line
         lbra  getcmd    

* Display error #

prterr   lda   #2         error out path
         os9   f$perr     print error #
         clr   echobyte   echo off
         lbsr  echo      

         leax  i.o.buff,u point to input buffer
         lbra  read1      wait for keypress & return

* Exit with usage prompt if no pathname called

badcall                  
         lda   #2         errout
         leax  hints,pcr 
         ldy   #bufsiz   
         lbsr  wrtlin2   
         ldb   #e$bpnam   set bad path error
         bra   bye       

* Exit to OS9

quit     lda   oldecho    get original echo status
         sta   echobyte   reset echo
         lbsr  echo       to original status
         clrb             no error
bye      os9   f$exit     exit program

* Edit sector sub

edit     lbsr  movecmd   
         leax  edprompt,pcr point to prompt
         lbsr  pstring   
topleft  leax  inbuff,u   point to data buffer
         stx   edbufptr   save pointer
         lda   #1         init position counter
         sta   edpos     
         lda   #$23       top row code
         sta   rownum     save
         lda   #$25       1st hex dump col #
         sta   hexcol     save
         lda   #$58       1st ascii dump col
         sta   asciicol  

revbyte  lbsr  revdisp    set reverse video
         bsr   eddisply   display byte

         ifne  xyflipr   
edinput  lda   rownum     A=row
         ldb   hexcol     B=col
         else            

edinput  lda   hexcol     A=col
         ldb   rownum     B=row
         endc            

         tst   hexascii   Hex mode?
         beq   hexin      yes, bra

         ifne  xyflipr   
         ldb   asciicol   else B= ASCII col
         else            

         lda   asciicol   A= ASCII col
         endc            

hexin    lbsr  movecurs   position cursor
         leax  i.o.buff,u
         tst   hexascii   ascii mode?
         lbne  inputchr   yes, bra

* modification by BRI
* bra inputbyt
         lbra  inputbyt  
* end modification

* Sub to do Hex and ASCII dump for byte to be editted

         ifne  xyflipr   
eddisply lda   rownum     A=row
         ldb   hexcol     b= hex column
         else            

eddisply lda   hexcol     A=Hex column
         ldb   rownum     B=row
         endc            

         lbsr  movecurs   position cursor
         leay  i.o.buff,u point to output buff
         lda   [edbufptr,u] get byte
         pshs  a          save it
         lbsr  convert1   convert to hex, put in buff
         leax  -2,y       reset pointer to hex chars
         ldy   #2         2chars
         lda   #1         stdout
         lbsr  wrtlin2    display chars

         ifne  xyflipr   
         lda   rownum     same row
         ldb   asciicol   get ascii dump col #
         else            

         lda   asciicol   ascii dump col #
         ldb   rownum     same row
         endc            

         lbsr  movecurs   position cursor
         puls  a          get byte again
         anda  #$7F       clear bit 7 for ascii dump
         cmpa  #$20       printable?

         bhs   prntabl1   yes, bra
         lda   #'.        else print as '.'
prntabl1 leax  i.o.buff,u ouput buffer
         sta   ,x         put char in buff
         ldy   #1         1 char
         lbra  writeout   display char & return

* Read in a character; check for BREAK key

* modification by BRI
* toggles cursor on/off if enabled, checks for character
*readit ldy #1 1 char
readit   pshs  b,x        save previous char, input buffer pointer
CFlsh01  clra             std. input
         ldb   #SS.Ready 
         os9   I$GetStt  
         bcc   CFExit     character ready, go get it
         cmpb  #E$NotRdy  no character ready?
         bne   CrsrErr    no, go check other errors
         ldx   #$0001     give up remainder of tick
         os9   F$Sleep   
         bcs   CrsrErr    go clean up & check error
         dec   <CrsrCnt   decrement cursor toggle counter
         lda   <CrsrCnt   get new counter value
         eora  <CrsrFlg   cursor toggle required?
         anda  #%01000000 clear all but active counter bit
         beq   SigChk     no, go check for signal
         com   <CrsrFlg   toggle cursor on or off?
         beq   CrsrOff    go toggle cursor off
         bsr   CrsrOn     go toggle cursor on
         bra   SigChk     go check intercept routine signal code
CrsrOff  leax  CursrOff,pc point [X] to cursor off string
         ldy   #CursOff   number of bytes in string
         bsr   WritCrsr   go write cursor off string
SigChk   ldb   <SgnlCode  get intercept routine signal code
         cmpb  #S$Abort   keyboard abort signal? (error #2)
         beq   CrsrErr    yes, go report it
         cmpb  #S$Intrpt  keyboard interrupt signal? (error #3)
         bne   CFlsh01    no, go check for data again
CrsrErr  stb   ,s         save error code for sigchek2
         bsr   CrsrOn     go make sure cursor is on
         puls  b,x        recover error code, input buffer pointer
         bra   cheksig2  
CrsrOn   leax  CursrOn,pc point [X] to cursor on string
         ldy   #CursOn    number of bytes in string
WritCrsr lda   #1         std. output
         os9   I$Write   
         clrb             ignore any/all errors
         rts             
CFExit   bsr   CrsrOn     go make sure cursor is on
         puls  b,x        recover previous char, input buffer pointer
         ldy   #1         1 char
* end modification

         clra             stdin
         os9   i$read     read in char
         bcs   cheksig2   chek for BREAK if error
         rts              else return

* modification by BRI
* clears old signal, traps BREAK,
* cleans up before reporting other errors
* (fixes shift-BREAK/control-BREAK in edit mode and
* error report stack clean up bugs)
* cheksig2 cmpb #2 BREAK key signal?
* lbne error no, process error
* com hexascii yes, toggle hex/ascii flag
* leas 2,s pull return addr off stack
* bra edinput loop back
cheksig2 leas  2,s        dump return address
         clr   <SgnlCode  clear old signal
         cmpb  #2         keyboard abort? (BREAK)
         beq   TrapSgnl   yes, trap it & toggle hex/ascii
         pshs  b          save error code
         lbsr  reset      reset reversed chars
         clr   <rownum    reset row #
         puls  b          recover error code
         lbra  error      go process error
TrapSgnl com   <hexascii  yes, toggle hex/ascii flag
         lbra  edinput    loop back
* end modification


* Input a hex byte

inputbyt bsr   readit     read in a char
         bsr   digit      is it valid hex digit?
         bcs   edcurs     no, see if it's arrow key
         lbsr  writeout   yes, display char
         ldb   ,x         save char

* modification by BRI
* bsr readit read another char
         lbsr  readit     read another char
* end modification

         bsr   digit      is it valid?
         bcs   edcurs     no, check for arrows
         exg   a,b        A= 1st char
         lbsr  asciihex   change 2 ascii chars to hex byte
         stb   [edbufptr,u] put new byte in buffer
         lda   #1        
         sta   wrtflag    signal auto-write
         bra   movert     move to next byte

* Check to see if char is valid hex digit.
* Exit with Carry set if not valid.

digit    lda   ,x         get char from buffer
         cmpa  #'0        < 0?
         blo   notdig     YES, set carry
         cmpa  #'9        Between 0 & 9?
         bls   gotnib     Yes, return
         anda  #$5F       Lowercase -> Upper
         cmpa  #'F        > F?
         bhi   notdig     Yes, set carry
         cmpa  #'A        Between A & F?
         blo   notdig     No, set carry
gotnib   andcc  #$fe       clear carry bit
         rts             
notdig   orcc  #1         set carry bit
         rts             

* Input single ASCII character

* modification by BRI
*inputchr bsr readit read char
inputchr lbsr  readit     read char
* end modification

         lda   ,x         get char
         cmpa  #$20       valid ascii char?
         blo   edcurs     no, check for arrows
         sta   [edbufptr,u] yes, put in buffer
         lda   #1        
         sta   wrtflag    signal auto-write
         bra   movert     go do next byte

* Check if char is arrow (for cursor moves)

edcurs   cmpa  #9         Right arrow?
         beq   movert    
         cmpa  #8         Left arrow?
         beq   movelt    
         cmpa  #$c        Up arrow?
         lbeq  moveup    
         cmpa  #$a        Down arrow?
         lbeq  movedn    
         cmpa  #$d        CR?
         lbne  edinput    no, get another key

* Exit edit routine
         lbsr  reset      reset reversed chars
         clr   rownum     reset row #
         lbra  getcmd     return to command level

* Move to next byte on screen

movert   lbsr  reset      reset display byte
         tst   seclen+1   editting partial (last) sec?
         beq   rtptr      no, bra
         lda   edpos      position # in sector
         cmpa  seclen+1   last byte?
         lbeq  topleft    yes, bra
rtptr    ldd   edbufptr   get pointer
         addd  #1         set to next byte
         std   edbufptr   save
         inc   edpos     

displyrt inc   asciicol   inc display counter
         lda   asciicol   get counter
         cmpa  #$68       at end of screen row?
         bhs   rowdn      yes, move down a row
         lda   hexcol     no, inc hex display counter
         adda  #3         3 screen columns per byte
         sta   hexcol     save
         lbra  revbyte    go do next byte
rowdn    inc   rownum     next row
         lda   rownum     get row #
         cmpa  #$32       past bottom row?
         lbhi  topleft    yes, go to top row
         lda   #$25       1st hex column #
         sta   hexcol     reset counter
         lda   #$58       1st ascii col #
         sta   asciicol   reset counter
         lbra  revbyte    go do display

* Move to previous byte on screen

movelt   bsr   reset      reset displayed byte
         ldd   edbufptr   get data pointer
         subd  #1         dec it
         std   edbufptr  
         dec   edpos      & position counter
         dec   asciicol   dec display counter
         lda   asciicol   get col #
         cmpa  #$58       past left end of row?
         blo   rowup      yes, move up a row
         lda   hexcol     get hex col #
         suba  #3         move left 3 columns
         sta   hexcol     save
         lbra  revbyte   
rowup    dec   rownum     move up a row
         lda   #$52       col # of right end of hex dump
         sta   hexcol     save
         lda   #$67       col # of right end of ascii dump
         sta   asciicol   save
         lda   rownum     get row #
         cmpa  #$23       past top row?
         blo   gobot      yes, go to bottom row
         lbra  revbyte    no, display next byte
gobot    ldx   edbufptr   old pointer
         ldb   seclen+1   partial (last) sec?
         beq   botptr     no, bra
         stb   edpos      new last position
         clra            
         leax  d,x        new pointer with partial sector
         decb             offset to byte in buffer
         pshs  b         
* MSN of B is last row-1 with partial sector
         lsrb            
         lsrb            
         lsrb            
         lsrb             Now B is last row-1
         addb  #$23      
         stb   rownum    
         lda   ,s+        offset
         anda  #$0f       A=last col
         pshs  a         
         adda  #$58       left most ASCII column
         sta   asciicol   new ASCII col
         puls  a         
         ldb   #3         3 columns per hex byte
         mul             
         addb  #$25       1st hex col
         stb   hexcol    
         bra   savebot   
botptr   lda   #$32       bottom row #
         sta   rownum     save
         leax  $100,x     new pointer
savebot  stx   edbufptr   save new pointer
         lbra  revbyte    do next byte

* Reset byte displayed in reverse video to normal video

reset    lbsr  normdisp   set normal video
         lbra  eddisply   go display byte

* Move up a row on screen

moveup   bsr   reset      reset reversed byte
         ldb   seclen+1   partial sector?
         beq   moveup1    no, bra
         lda   rownum    
         cmpa  #$23       at top row now?
         beq   moveup2    yes, bra
moveup1  ldd   edbufptr   get data pointer
         subd  #$10       move back 16 bytes
         std   edbufptr   save new pointer
         ldb   edpos     
         subb  #$10       dec position counter by $10
         stb   edpos     
         dec   rownum     move up a row
         lda   rownum     get new row #
         cmpa  #$23       above top row
         bhs   updone     no, go display next byte
         lda   #$32       set to bottom row
         sta   rownum    
         ldd   edbufptr   get data pointer
         addd  #$100      point to new byte
         std   edbufptr   and save
updone   lbra  revbyte    display next byte

moveup2  andb  #$f0       MSN=row offset
         lda   seclen+1   bytes read
         anda  #$0f       last col in last row
         cmpa  edpos      to left of current position?
         bhs   moveup3    yes, bra
         subb  #$10       else correct row offset
moveup3  clra            
         pshs  b,a       
         ldd   edbufptr  
         addd  ,s+        add offset
         std   edbufptr  
         ldb   edpos     
         addb  ,s        
         stb   edpos      new position
         puls  b         
         lsrb            
         lsrb            
         lsrb            
         lsrb             row offset in LSNib
         addb  #$23       calc new rownum
         stb   rownum    
         bra   updone    

* Move down a row on screen

movedn   bsr   reset      reset reversed byte
         ldb   seclen+1   partial sector?
         beq   movedn1   
         subb  edpos     
         cmpb  #$10      
         blo   movedn2   
movedn1  ldd   edbufptr   get data pointer
         addd  #$10       point 16 bytes ahead
         std   edbufptr   and save
         lda   edpos     
         adda  #$10      
         sta   edpos     
         inc   rownum     move down a row
         lda   rownum     check to see if below
         cmpa  #$32       bottom row?
         lbls  revbyte    no, display next byte
         ldd   edbufptr   get data pointer
         subd  #$100      reset to new byte
         std   edbufptr   save
topptr   lda   #$23       yes, set for top row
         sta   rownum     save
         lbra  revbyte    display next byte

movedn2  clra            
         ldb   edpos     
         decb            
         andb  #$f0       B = offset to first row
         pshs  b,a       
         ldd   edbufptr  
         subd  ,s+        reset pointer
         std   edbufptr  
         ldb   edpos     
         subb  ,s+        reset position counter
         stb   edpos     
         bra   topptr    


* Start new SHELL

goshell  lda   oldecho    get original echo status
         sta   echobyte   set up for change
         bsr   echo       set echo
         leax  shell$,pcr point to 'SHELL' text
         ldy   #$10       # pages in new param area
         leau  i.o.buff,u new param area
         lda   #$0d       CR to
         sta   ,u         init param area
         ldd   #$0000     language/type
         os9   f$fork     fork to new shell
         lbcs  error     
         os9   f$wait     wait for shell to die
         ldu   usave      pull data pointer
         leax  inbuff,u  
         stx   buffptr    reset buffer pointer
         clr   echobyte   echo off
         bsr   echo       set echo
redo     lbsr  clrscr     clear screen
         lbra  disploop   redo display

* Read in option section (32 bytes) of stdin path descriptor & turn echo on/off

echo     pshs  x          save
         leas  -32,s      make room for data
         leax  ,s         point to buffer
         clra             path = 0
         clrb             SS.OPT
         os9   i$getstt   read in 32 bytes
         lbcs  error     
         lda   echobyte   new echo status byte
         sta   4,x        set echo
         clra             path =0
         os9   i$setstt   set new status
         lbcs  error     
         leas  32,s       reset stack
         puls  x,pc       pull x & return

* Verify CRC on file, if it's a valid module.

verify   lbsr  movecmd    position cursor
         leax  vrfymess,pcr display message
         lbsr  pstring   
         ldu   #$0000    
         ldx   #$0000    
         stx   fileln     init file length
         lda   inpath     path #
         os9   i$seek     rewind to LSN 0
         lbcs  error     
         ldu   Usave      restore U
initCRC  ldd   #$FFFF     initialize CRC bytes
         std   crc       
         stb   crc+2     
         leax  i.o.buff,u input buffer
         ldy   #8         8 bytes to read
         lda   inpath     path #
         os9   i$read     read in 8 header bytes
         lbcs  error      exit on error
         cmpy  #8         all read in ok?
         lbne  verr       no, error
         ldd   ,x         get 1st 2 bytes read in
         cmpa  #$87       module sync byte?
         lbne  verr       no, error
         cmpb  #$CD       module sync byte?
         lbne  verr       no, error
         ldd   2,x        get module length
         cmpd  #$f        minimum module length
         lbls  verr       exit if less
         subd  #3         omit old CRC bytes
         std   vmodlen    module length less CRC
         addd  fileln     update file length
         std   fileln     read so far

* Check header parity by EOR'ing 1st 8 bytes to themselves, then taking
* the one's complement. This is the 9th header byte, the parity check.

         clra             prepare for EORs
         ldb   #8         # header bytes to EOR
hedpar   eora  ,x+        EOR bytes read in
         decb             done?
         bne   hedpar     no, bra
         coma             A now is header parity
         sta   ,x         put in buffer
         ldy   #1         1 char to write
         lda   inpath     path #
         os9   i$write    write parity byte out
         lbcs  error     
         ldd   vmodlen    get # byte in module
         subd  #9         9 bytes already read
         std   vmodlen    save
         leax  i.o.buff,u start of header bytes
         ldy   #9        
         bsr   CRCcal     calculate CRC on 1st 9 bytes
bytsleft lda   inpath     path #
         ldy   #bufsiz    # chars to read
         cmpy  vmodlen    buffer <= # bytes left to read?
         bls   readmod    yes, bra
         ldy   vmodlen    else, get exact # chars left to read
readmod  os9   i$read     read in Y chars
         bcs   verr       exit on error
         sty   bytsread   save # bytes read in
         bsr   CRCcal     calc CRC on bytes just read in
         ldd   vmodlen    # bytes
         subd  bytsread   minus # bytes just read in
         std   vmodlen    save # byte left
         bne   bytsleft   do more if some left
* Compare current position in file with # of bytes in module header
* to prevent overwriting next module, in case module length changed.
         lda   inpath     path number
         ldb   #ss.pos    file position code
         os9   i$getstt   get position in file
         tfr   u,d        D = position
         ldu   Usave      restore U
         cmpd  fileln     same as bytes read so far?
         bne   verr       no, exit
         com   crc        do one's
         com   crc+1      complement on
         com   crc+2      CRC accumulator
         leax  crc,u      point to accumulator
         ldy   #3         3 bytes to write
         lda   inpath     path #
         os9   i$write    write out 3 CRC bytes
         lbcs  error     
         ldd   #3         update # bytes read/written
         addd  fileln    
         std   fileln    
         ldb   #ss.eof    test for EOF
         lda   inpath    
         os9   i$getstt  
         lbcc  initCRC    bra if not EOF
         cmpb  #e$eof     EOF?
         lbne  error      no, exit
* Redisplay LSN (may have changed with verify)
         lbsr  seeksec    read in sector again
         lbra  disploop   redo display

* Calculate CRC sub. Enter with Y = # of bytes to calculate CRC over.
*                               X = address of 1st byte

CRCcal   leau  crc,u      point to CRC bytes
         os9   f$crc      calc CRC
         lbcs  error     
         ldu   Usave      restore U
         rts             

* Verify error display sub

verr     ldd   #cmdpos    position cursor
         lbsr  movecurs   at cmd position
         leax  verrmess,pcr point to message
         lbsr  pstring    display it
         ldb   #e$bmid    bad module ID
         lbsr  prterr     display error #
         lbra  getcmd     exit

* 'Link' to a given module or display all modules if no name is input

linker   tst   infile     linked already?
         lbne  getcmd     yes, exit
         ldd   #0        
         std   fileln     init vars
         std   lmodlen    "
         clr   echobyte  
         com   echobyte  
         lbsr  echo       echo on
         lbsr  movecmd   
         lbsr  clrline   
         leax  linkmess,pcr prompt
         lbsr  pstring    print it
         leax  infile,u   point to buffer for module name
         ldy   #30        max name length+1
         lbsr  readlin    read in module name
         clr   echobyte  
         lbsr  echo       echo off
         cmpy  #1         any name entered?
         lbne  parsmod    yes, go find it
* else list all module names
         clr   infile     flag => no modules linked
         leax  linkhdr,pcr point to header
         lbsr  wrtlin1    write it
nxtmod   ldd   lmodlen    current mod length
         addd  fileln     + cummulative lengths
         std   fileln     save
         tfr   d,u        point u to next module
         ldx   #0        
         lda   inpath    
         os9   i$seek    
         bcs   moderr    
         ldu   Usave      restore U
         leax  i.o.buff,u
         ldy   #6         bytes to read
         os9   i$read    
         bcs   moderr    
         ldd   ,x++       get sync bytes
         cmpa  #$87       OK?
         bne   moderr1    no, exit
         cmpb  #$CD       OK?
         bne   moderr1    no, exit
         leay  i.o.buff,u
         ldd   ,x++       get module length
         std   lmodlen    save
         ldd   ,x++       offset to module name
         pshs  d          save
         ldd   fileln     current offset
         bsr   convert2   convert D to ASCII
         lda   #$20       space
         sta   ,y+        put in buffer
         ldd   lmodlen    current module length
         bsr   convert2   convert to ASCII
         lda   #$20      
         sta   ,y+        insert space
         ldd   fileln     offset to mod start
         addd  ,s++       add mod name offset
         tfr   d,u        U = offset to name
         ldx   #0        
         lda   inpath    
         os9   i$seek     seek to module name
         lbcs  error     
         ldu   Usave      restore U
         tfr   y,x        point x to buffer
         ldy   #29        max chars in name
         lda   inpath    
         os9   i$read    
         lbcs  error     
namend   lda   ,x+        find char w/ bit 7 set
         bpl   namend    
         anda  #$7f       clear bit 7
         sta   -1,x      
         lda   #$0d       CR
         sta   ,x         end output line
         leax  i.o.buff,u buffer start
         lbsr  wrtlin1   
         bra   nxtmod    

convert2 lbsr  convert1   put ASCII val of A in Y
         tfr   b,a        repeat for B
         lbra  convert1   and return

moderr2  cmpb  #e$eof    
         bne   moderr    
         ldb   #e$MNF     module not found error
         bra   moderr    
moderr1  ldb   #E$BMID    bad module ID error
moderr   clr   infile     flag => not linked
         cmpb  #e$eof     end of file?
         lbne  error      no, print error
         lbsr  read1      wait for keypress
         leax  inbuff,u  
         stx   buffptr    reset buffer pointer for display
         lbra  redo       redo display

parsmod  os9   f$prsnam  
         lbcs  error     
         stb   modnmlen   save length of name
         decb             name len -1
         lda   b,x        last char of name
         ora   #$80       set bit 7
         sta   b,x       
         stx   CRC        save pointer
         ldu   #0        
modloop  ldx   #0        
         lda   inpath    
         os9   i$seek     go to start of file
         lbcs  error     
         ldu   Usave      restore U
         leax  i.o.buff,u buffer
         ldy   #6         bytes to read in
         os9   i$read    
         bcs   moderr2   
         ldd   ,x++       sync bytes
         cmpa  #$87       OK?
         bne   moderr1   
         cmpb  #$CD       OK?
         bne   moderr1   
         ldd   ,x++       module length
         std   lmodlen    save
         ldd   ,x         mod name offset
         addd  fileln     d=true offset to name
         tfr   d,u       
         ldx   #0        
         lda   inpath    
         os9   i$seek     seek to mod name
         bcs   moderr2   
         ldu   Usave      restore U
         leax  i.o.buff,u buffer
         ldy   #29        max chars in name
         os9   i$read     read in name
         bcs   moderr2   
         tfr   x,y       
         ldx   CRC        point to desired name
         ldb   modnmlen   get len of name
         os9   f$cmpnam   do they match?
         bcc   newbase    yes, bra
         ldd   lmodlen    no, check next
         addd  fileln     new offset
         std   fileln    
         tfr   d,u       
         bra   modloop   

* Set Offset to module. LSN is functionally set to 0.

newbase  lda   #$0d       CR
         sta   b,x        delimit name
         decb            
         lda   b,x        last char
         anda  #$7f       clr bit 7
         sta   b,x       
         ldd   fileln     get offset
         std   offset    
         ldd   #0006     
         leax  LSN,u     
nbloop   sta   ,x+       
         decb            
         bne   nbloop    
         lbra  readloop   go read 1st 'LSN'

* Display module name and offset

prntmod  ldd   #modpos   
         lbsr  movecurs   point to screen position
         leax  modnmhdr,pcr mod name header
         lbsr  pstring    print it
         leax  infile,u   point to name
         lbsr  wrtlin1    print it
         ldd   #offpos    'offset' screen postion
         lbsr  movecurs  
         leax  offmess,pcr
         lbsr  pstring    print 'Offset' label
         leay  i.o.buff,u
         ldd   offset    
         lbsr  convert2   convert offset to ASCII
         lda   #$0d      
         sta   ,y         delimit offset
         lbra  writeout   display it & return

* 'Unlink' named module and restore LSN to original file's LSN

unlinker tst   infile     linked?
         lbeq  getcmd     no, exit
         ldd   #0008     
         leax  LSN,u     
unloop   sta   ,x+       
         decb            
         bne   unloop    
         ldd   #modpos    position cursor
         lbsr  movecurs  
         lbsr  clrline    erase module name
         lbsr  clrline    erase offset
         clr   infile     flag => no modules linked
         lbra  readloop  

* Toggle expert mode - edits and zaps of buffer are automatically written

expert   tst   xprtflag   in expert mode now?
         beq   xprton     no, go turn it on
         clr   xprtflag   signal mode off
         ldd   #xprtpos  
         lbsr  movecurs  
         lbsr  clrline    erase label
xprtout  lbra  getcmd    
xprton   lbsr  rusure     Sure?
         bne   xprtout    no, exit
         com   xprtflag   signal xpert mode
         ldd   #xprtpos  
         lbsr  movecurs   position cursor
         leax  xprtmess,pcr
         lbsr  pstring    display 'EXPERT'
         bra   xprtout   

help     lbsr  clrscr     clear screen
         leax  helper,pcr point to help message
         ldy   #helpchrs  length of message
         lbsr  wrtlin2    print it
         leax  i.o.buff,u
         lbsr  Read1      get 1 byte
         lbra  redo       redo display

find                     
         clr   echobyte  
         com   echobyte   echo on
         lbsr  echo      
         lbsr  movecmd   
         lbsr  clrline   
         tst   FHexAsc    Hex or Ascii mode?
         bne   charfind   bra if Ascii
         leax  findbyte,pcr
         lbsr  pstring    display prompt
         ldy   #33        max chars to read + 1
         lbsr  FRead     
         cmpy  #1         blank line entered?
         lbeq  exitfind   yes, exit find mode
         leay  -1,y       get rid of CR
         tfr   y,d       
         lsrb             divide # bytes read by 2
         lbcs  badfind    bra if odd # read
         stb   TargLen    save # bytes in find string
         leau  findstr,u  point to storage area
* Convert 2 bytes pointed to by X to object byte in A
FConvert lbsr  hexobjct  
         lbcs  badfind    bra if invalid char
         sta   ,u+        save byte
         leay  -2,y       all chars converted?
         bne   FConvert   no, bra
         ldu   Usave      restore U
         bra   gofind    

* Input a string of ASCII characters to search for

charfind leax  findchar,pcr
         lbsr  pstring    display prompt
         ldy   #17        max # of chars + 1
         lbsr  FRead     
         cmpy  #1         only CR entered?
         lbeq  exitfind   yes, exit find mode
         tfr   y,d        # bytes read
         decb             dump CR
         stb   TargLen    save length of target string
         leay  findstr,u 
find20   lda   ,x+        move target
         sta   ,y+        string to storage area
         decb             done?
         bne   find20    

* Check if byte from target string matches byte in buffer by EOR'ing the two.
*  If they match exactly, result is 0. If in 'char' search mode, EOR results
*  in bits 5 and/or 7 being set if 2 bytes differ only by case or bit 7 status

gofind                   
*****************************
* Added 01/08/90 (RAK)
*
         clr   echobyte   echo off
         lbsr  echo      
*
* END of modification
*****************************
         leax  inbuff,u   point to sector buffer
find30   ldb   seclen+1   # bytes in this sector
         leay  findstr,u  point to target string
find50   lda   ,y         get 1st target byte
         eora  ,x+        does it match?
         lbeq  found1     yes, bra
         tst   FHexAsc    in 'char' search mode?
         beq   find60     no, bra
         bita  #%01011111 else, only bits 5 &/or 7 set?
         lbeq  found1     bra if so
find60   decb             whole sector checked?
find70   bne   find50     no, bra
* No match in this sector. Read in next sector.

****************************************************
* Modification (addition) by RAK 01/08/90
* Read a character from std in to catch a break
* key which allows aborting a <F>IND.
* Note: "finderr2" resets the stack.
*
         pshs  d,x,y      save registers
         clra             std in
         ldb   #SS.Ready 
         os9   I$GetStt   was there a key press?
         bcs   NoKey      no, skip read
         leax  i.o.buff,u point to buffer
         lbsr  Read1      get a key
         lda   ,x         get the key
         cmpa  #5         break key?
         beq   finderr2   yes, stop <F>ind
NoKey    puls  d,x,y      no, restore registers
*
* End of modification
****************************************************

         bsr   FNxtsec    get next sector
         bra   find30     back to loop

FNxtSec  tst   infile     module linked?
         beq   find75     no, bra
         ldd   lmodlen    else, get module length
         subd  #1         now A = LSN of last sector
         cmpa  LSN+2      was this last sector?
         beq   finderr2   yes, bra
find75   ldd   lsn+1      else, get next sector
         addd  #1         inc lsn
         std   lsn+1     
         bne   find80     bra if no carry needed
         inc   lsn        else, do add in carry
find80   lbsr  lsnseek    seek to next sector
         leax  inbuff,u   point to sector buffer
         stx   buffptr    save
         tst   infile     module linked?
         beq   find256    no, bra
         ldd   lmodlen    linked mod length
         suba  lsn+2      > $100 bytes left?
         bne   find256    yes, bra
         tfr   d,y        else, set up for smaller read
         bra   FRdSome   
find256  ldy   #$100     
FRdSome  lda   inpath    
         os9   i$read    
         bcs   finderr   
         sty   seclen     save # bytes read
         rts             

* Input byte or char string to find

FRead    leax  i.o.buff,u
         clra             stdin
         os9   i$readln  
         bcs   cheksig3  
         rts             

ChekSig3 leas  2,s        scratch return addr
         clr   SgnlCode   clear old signal
         cmpb  #2         BREAK key?
         lbne  error      no, exit
         com   FHexAsc    yes, toggle Hex/Ascii flag
         lbra  find      

badfind  ldu   Usave      restore U
         bsr   beep      
         lbra  find      

* Make a beep
beep     leax  bell,pcr  
         ldy   #1        
         lbra  writeout   beep & return

* If error reading next sector was EOF, then find was unsuccessful.
* Re-read original sector and return to CMD: prompt

finderr  cmpb  #e$eof     EOF?
         lbne  error      no, exit
finderr2 lds   Ssave      dump return addr
         ldd   oldlsn     original LSN
         std   lsn       
         lda   oldlsn+2  
         sta   lsn+2     
         lbsr  seeksec    read original LSN
         sty   seclen     save bytes read
         bsr   beep      

exitfind lbra  exitzap    exit

found1   pshs  b          # bytes left in sector + 1
         decb             # save bytes left if this search unsuccessful
         stb   FBytes     and for 'Next' command
* Save pointer (X) to next byte in buffer for search to resume if this search
*  is unsuccessful or for 'Next' command
         stx   findptr    pointer for next search
         ldb   TargLen    #bytes in target string
find90   decb             whole string checked?
         beq   matched    yes, match found
         dec   ,s         else, more bytes left in sector?
         beq   find130    no, read in next
find100  leay  1,y        else, point to next target byte
         lda   ,y         target byte
         eora  ,x+        match?
         beq   find90     yes, loop back for more
         tst   FhexAsc    in 'char' search mode?
         beq   find110    no, bra
         bita  #%01011111 only bits 5 &/or 7 set?
         beq   find90     yes, bra
find110  leas  1,s        else, dump counter
* Restore buffer pointer (X) to byte after 1st byte found that matched in
*  search just completed (unsuccessfully). Restore B to # bytes left in 
*  sector at that point. Y = start of target string.
         ldx   findptr    ready for new search
find120  leay  findstr,u 
         ldb   FBytes     bytes left in sector
         lbra  find70    

* Read in next sector to complete test for match
find130  leas  1,s        dump counter
         pshs  b,y        save counter & target pointer
         lbsr  FNxtSec    read in next sector
         puls  b,y        restore counter & target pointer
         lda   seclen+1   # bytes in this sector
         pshs  a          save
         bra   find100    continue search

* Successful Find
*   Must determine whether target string starts in last LSN read or
*    next-to-last, for display.

matched  leas  1,s        dump counter
         lda   lsn+2     
         cmpa  oldlsn+2   did we have to read a new sector?
         beq   match40    no, bra
         cmpx  findptr    does target start in last sector read?
         bhs   match30    yes, bra
match10  ldd   lsn+1      else, set to re-read previous LSN
         subd  #1        
         std   lsn+1     
         cmpd  #$ffff    
         bne   match20   
         dec   lsn       
match20  lbsr  seeksec    re-read sector
         sty   seclen     save bytes read ($100)
match30  ldd   lsn        update 'oldlsn'
         std   oldlsn    
         lda   lsn+2     
         sta   oldlsn+2  
match40  lbsr  display    (re)display sector
* Get offset of found string from beginning of LSN
         ldd   findptr    addr 1 byte past start of found string
         subd  #1         D = addr of string
         std   edbufptr   save for display
         subd  buffptr    D (B) = offset from buff start
* Now LS nib of B = col #, MS nib = row # for display
         pshs  b         
         andb  #$0f       mask off MS nibble
         pshs  b         
         addb  #$58       add offset for ascii dump column
         stb   asciicol  
         puls  b         
         lda   #3         3 screen columns per hex byte dump
         mul             
         addb  #$25       add offset for hex dump column
         stb   hexcol    
         puls  b         
         andb  #$f0       mask off LS nibble
         lsrb            
         lsrb            
         lsrb            
         lsrb             B now = row #
         addb  #$23       add offset
         stb   rownum    
         lbsr  revdisp    reverse video
         lbsr  eddisply   display 1st byte in found string
         lbsr  normdisp   normal video
         clr   rownum    
         lbra  exitfind   done *** This line changed from 'lbra getcmd' in Version 2.0 ***

* Locate next occurrence of string located with 'Find' command.
*  Search starts where 'Find' left off, unless LSN has since changed,
*   in which case search starts at start of present LSN

next     tst   TargLen    is there a string to find?
         lbeq  getcmd     no, exit
         lbsr  movecmd   
         leax  srchmess,pcr
         lbsr  pstring    display "Searching"
         ldx   findptr    pointer into buffer where 'find' left off
         lbeq  gofind     0 => begin at start of LSN
         lbra  find120   

* Display file size and input new value

diddle   lbsr  movecmd   
         leax  lenmess,pcr
         lbsr  pstring   
         com   zeroflag   suppress leading zeroes
         leay  i.o.buff,u
         ldd   FileLen    MSB of file length
         lbsr  convert1   convert 1st nibble to ascii
         tfr   b,a       
         lbsr  convert1   do 2nd nibble
         ldd   FileLen+2  LSB of file length
         lbsr  convert1   do 3rd nibble
         clr   zeroflag   stop suppressing leading zeroes
         tfr   b,a       
         lbsr  convert1  
         ldd   #$2020    
         std   ,y++      
         std   ,y++      
         leax  i.o.buff,u
         stx   bytsread   temp storage
         tfr   y,d       
         subd  bytsread   get # chars to display
         tfr   d,y        setup for i$writln
         lbsr  writeout  
         leax  newmess,pcr
         lbsr  pstring    display message
         ldy   #9         max chars to read
         lbsr  MakeHex    convert them to object
         bcs   diddle    
         ldd   #cmd1pos  
         lbsr  movecurs  
         lbsr  rusure10   ask  'Sure?'
         lbne  getcmd    
         ldx   HexBuff    MSB of new file length
         ldu   HexBuff+2  LSB ""
         ldb   #ss.size  
         lda   inpath    
         os9   i$setstt   set new file length
         lbcs  error     
         stx   FileLen   
         stu   FileLen+2 
         ldu   Usave     
* Make sure LSN displayed is still within file (in case file shortened).
*  If not, reset display to show last LSN with new file length.
         lda   FileLen    MSB of file length
         cmpa  lsn        is max LSN > current LSN?
         blo   RstLSN     no, bra
         bne   diddled    else, bra if LSN not last
         ldd   FileLen+1  check LSB's (MSB's equal)
         cmpd  lsn+1     
         bls   RstLSN10  
diddled  lbra  readloop   re-read sector & display

RstLSN   sta   lsn        reset MSB of lsn
         ldd   FileLen+1  get LSB's of last sector
RstLSN10 tst   FileLen+3  need to correct?
         bne   RstLSN20  
         subd  #1        
RstLSN20 std   lsn+1      reset LSB's of lsn
* If D was 0, need to 'borrow'
         cmpd  #$ffff     was D 0?
         bne   diddled    no, bra
         dec   lsn        else, correct LSB of LSN
         bra   diddled   

push     lda   StackCnt   # of LSN's on stack
         cmpa  #MaxStack  more room?
         bhs   full       no, bra
         ldb   #3         3 bytes per entry
         mul             
         leax  Stack,u    start of stack
         leax  b,x        add offset
         ldd   lsn       
         std   ,x++       put current LSN on stack
         lda   lsn+2     
         sta   ,x        
* Now that LSN is on stack, check to make sure it isn't the last one
*  pushed, as well. If so, don't increment StackCnt, which effectively
*  cancels the Push operation.
         tst   StackCnt   any sectors thus far?
         beq   pushOK     no, do push
         cmpa  -3,x       Is LSB of LSN the same as previous LSN pushed?
         bne   pushOK     no, bra
         ldd   lsn        check MS bytes of LSN
         cmpa  -5,x       do they match?
         beq   pushed     yes, exit without completing push
pushOK   inc   StackCnt   complete push
pushed   lbra  getcmd     exit

* Stack is full - display message
full     lbsr  movecmd   
         leax  fullmess,pcr
         lbsr  pstring    display 
         lbsr  read1      wait for keypress
         bra   pushed    

remove   lda   StackCnt   # sectors on stack
         beq   pushed     exit if none
         ldb   #3         3 bytes per entry
         mul              offset to END of entry
         subb  #3         no B = offset to entry
         leax  Stack,u   
         leax  b,x        point to entry
         ldd   ,x++       get MS bytes of LSN
         std   lsn       
         lda   ,x         get LS byte of LSN
         sta   lsn+2      reset LSN
         dec   StackCnt   1 less sector on stack
         lbra  readloop   and go read in new sector

         emod            
dEDend   equ   *         

         ENDC

         end
