********************************************************************
* Mfree - Show free memory
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   5      ????/??/??
* From Tandy OS-9 Level One VR 02.00.00.

         nam   Mfree
         ttl   Show free memory

* Disassembled 02/04/05 15:22:05 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   5
stdout   set   1

         mod   eom,name,tylg,atrv,start,size

         org   0
fmbegin  rmb   2
fmend    rmb   2
u0004    rmb   1
u0005    rmb   1
upper    rmb   2    Upper boundary of free segment
lower    rmb   2    Lower boundary of free segment
pages    rmb   1
bufptr   rmb   2
buffer   rmb   530
size     equ   .

name     fcs   /Mfree/
         fcb   edition

header   fcb   C$LF
         fcc   " Address  pages"
         fcb   C$LF
         fcc   "--------- -----"
         fcb   $80+C$CR
totfree  fcb   C$LF
         fcs   "Total pages free = "
L0048    fcs   "Graphics Memory "
notalloc fcs   "Not Allocated"
ataddr   fcs   "at: $"

start    leay  buffer,u
         sty   <bufptr
         leay  <header,pcr
         bsr   ApndStr
         bsr   print
         ldx   >D.FMBM      The free memory bitmap pointer start
         stx   <fmbegin
         ldx   >D.FMBM+2    The free memory bitmap pointer end
         stx   <fmend
         clra  
         clrb  
         sta   <u0005       Clear
         std   <upper       Clear
         std   <lower       Clear
         stb   <pages       Clear
         ldx   <fmbegin
nextbyte lda   ,x+
         bsr   L00A8
         cmpx  <fmend
         bcs   nextbyte
         bsr   L00B8
         leay  <totfree,pcr
         bsr   ApndStr
         ldb   <u0005
         bsr   bDeci
         bsr   print
         lbsr  display
         clrb  
         os9   F$Exit   
*
L00A8    bsr   L00AA
L00AA    bsr   L00AC
L00AC    bsr   L00AE
L00AE    lsla  
         bcs   L00B8
         inc   <u0005
         inc   <pages
         inc   <upper
         rts   
L00B8    pshs  b,a
         ldb   <pages
         beq   L00D7
         ldd   <lower
         bsr   dHexa
         lda   #$2D     '-' char
         bsr   ApndA
         ldd   <upper
         subd  #$0001
         bsr   dHexa
         bsr   aspace   Append a space to buffer
         bsr   aspace   Append a space to buffer
         ldb   <pages
         bsr   bDeci
         bsr   print
L00D7    inc   <upper
         ldd   <upper
         std   <lower
         clr   <pages
         puls  pc,b,a
*
* Append string (in reg y) to buffer
*
ApndStr  lda   ,y
         anda  #$7F
         bsr   ApndA
         lda   ,y+
         bpl   ApndStr
         rts   
* 
* Print the buffer
*
print    pshs  y,x,a
         lda   #C$CR     Add form feed to buffer
         bsr   ApndA
         leax  buffer,u   Reset bufptr to start of buffer
         stx   <bufptr
         ldy   #80        Max line length = 80
         lda   #stdout
         os9   I$WritLn 
         puls  pc,y,x,a
*
* Appends the content of register B in decimal
* to the buffer
*
bDeci    lda   #$FF
         clr   <u0004
L0105    inca  
         subb  #$64
         bcc   L0105
         bsr   L0119
         lda   #$0A
L010E    deca  
         addb  #$0A
         bcc   L010E
         bsr   L0119
         tfr   b,a
         inc   <u0004
L0119    tsta  
         beq   L011E
         sta   <u0004
L011E    tst   <u0004
         bne   L0124
aspace   lda   #$F0
L0124    adda  #$30    Offset to "0" in ascii table
         cmpa  #$3A
         bcs   ApndA
         adda  #$07
*
* Append character (in a) to buffer
*
ApndA    pshs  x
         ldx   <bufptr
         sta   ,x+
         stx   <bufptr
         puls  pc,x
*
* Append register D as hex string to buffer
*
dHexa    clr   <u0004
         bsr   L013C
         tfr   b,a
L013C    pshs  a
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L0146
         puls  a
L0146    anda  #$0F
         bra   L0119
display  pshs  y,x
         leay  >L0048,pcr
         bsr   ApndStr
         lda   #stdout
         ldb   #SS.DStat
         os9   I$GetStt 
         bcc   L0163
         leay  >notalloc,pcr
         bsr   ApndStr
         bra   L016E
L0163    leay  >ataddr,pcr
         lbsr  ApndStr
         tfr   x,d
         bsr   dHexa
L016E    puls  y,x
         lbra  print

         emod
eom      equ   *
         end

