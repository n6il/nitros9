********************************************************************
* NGU - The "Next Great Utility"
*
* $Id$
*
* NGU is a template for writing utilities under OS-9/6809. It has
* robust option handling and is littered with comments to help you
* write your own utilities.
*
* NGU uses a two-pass method for parsing the command line.  On the
* first pass, dash options are processed and internal flags are set
* accordingly.  As the options are processed, they are cleared to
* spaces so that they won't be present on the second pass.
*
* For the second pass, NGU parses options that don't begin with -.
* Presumably these are filenames or other names that are to be
* processed.
*
* Features:
*    - Both options and files can be specified anywhere
*      on the command line
*          (i.e ngu -a test1 -b test2 -c=foo)
*
*    - Options can be combined behind one dash:
*          (i.e ngu -ab test1 -c=foo test2 test3)
*
*    - Several useful assembly routines are provided for
*      copying strings and determining string length.
*
* Limitations:
*    - Only single character options can be processed.
*      Multi-character options (i.e. -delete) are not allowed.
*
*    - The current file counter is one byte, allowing a maximum
*      of 255 files.
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   1    Put your development info here                 BGP 03/01/11

         nam   NGU
         ttl   The "Next Great Utility"

         ifp1
         use   defsfile
         use   rbfdefs
         endc

* Here are some tweakable options
DOHELP   set   1	1 = include help info
STCKSIZE set   64	our stack size in bytes
COPTSIZ  set   64	max size of C option's parameter

* Module header definitions
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   1

         mod   eom,name,tylg,atrv,start,size


* Your utility's static storage vars go here
         org   0
parmptr  rmb   2	pointer to our command line params
bufptr   rmb   2	pointer to user expandable buffer
bufsiz   rmb   2	size of user expandable buffer
* What follows are utility specific options
gota     rmb   1
gotb     rmb   1
filecnt  rmb   1
coptflg  rmb   1	1 = this option has been processed once already
clrmark  equ   .	everything before here gets cleared at start
copt     rmb   COPTSIZ	buffer for what follows after -c=
* Next is a user adjustable buffer with # modifier on command line.
* Some utilities won't need this, some will.
* Currently set up to be larger for Level 2 than Level 1
* Note: this buffer must come just before the stack
         IFGT  Level-1
bigbuff  rmb   8*1024		8K default buffer for Level 2
         ELSE
bigbuff  rmb   512		512 byte default buffer for Level 1
         ENDC
* Finally the stack for any PSHS/PULS/BSR/LBSRs that we might do
stack    rmb   STCKSIZE
size     equ   .

* The utility name and edition goes here
name     fcs   /NGU/
         fcb   edition

* Place constant strings here
         IFNE  DOHELP
HlpMsg   fcb   C$LF
         fcc   /Use: NGU [<opts>] <path> [<path>] [<opts>]/
         fcb   C$LF
         fcc   /   -a    option 1/
         fcb   C$LF
         fcc   /   -b    option 2/
         fcb   C$LF
         fcc   /   -c=f  option 3/
         fcb   C$LF
         fcb   C$CR
HlpMsgL  equ   *-HlpMsg
         ENDC
UnkOpt   fcc   /unknown option: /
UnkOptL  equ   *-UnkOpt

* Here's how registers are set when this process is forked:
*
*   +-----------------+  <--  Y          (highest address)
*   !   Parameter     !
*   !     Area        !
*   +-----------------+  <-- X, SP
*   !   Data Area     !
*   +-----------------+
*   !   Direct Page   !
*   +-----------------+  <-- U, DP       (lowest address)
*
*   D = parameter area size
*  PC = module entry point abs. address
*  CC = F=0, I=0, others undefined

* The start of the program is here
* Before any command line processing is done, we clear out
* our static memory from U to clrmark, then determine the
* size of our data area (minus stack)
start    pshs  u,x		save registers for later
         leax  <clrmark,u	point to end of area to zero out
         IFNE  H6309
         subr  u,x		subtract U from X
         tfr   x,w		and put X in W
         clr   ,-s		put a zero on the stack
         tfm   s,u+		and use TFM to clear starting at U
         leas  1,s		clean up the stack
         ELSE
         pshs   x		save end pointer on stack
clrnxt   clr   ,u+		clear out
         cmpu  ,s		done?
         bne   clrnxt		branch if not
         leas  2,s		else clear stack
         ENDC
         puls  x,u		and restore our earlier saved registers
         leay  bigbuff,u	point Y to copy buffer offset in U
         stx   <parmptr		save parameter pointer
         sty   <bufptr		save pointer to buffer
         tfr   s,d		place top of stack in D
         IFNE  H6309
         subr  y,d
         ELSE
         pshs  y		save Y on stack
         subd  ,s++		get size of space between copybuf and X
         ENDC
         subd  #STCKSIZE	subtract out our stack
         std   <bufsiz		size of our buffer

* At this point we have determined our buffer space and saved pointers
* for later use.  Now we will parse the command line for options that
* begin with -
         lbsr  SkipSpcs         move past any spaces on command line
         cmpa  #C$CR		CR?
         lbeq  ShowHelp		if so, no parameters... show help and exit
GetChar  lda   ,x+		get next character on cmd line
         cmpa  #C$CR		CR?
         lbeq  DoNGU		if so, do whatever this utility does
         cmpa  #'-		is it an option?
         beq   GetDash		if so, process it
         inc   <filecnt         else must be a non-option argument (file)
         lbsr  SkipNSpc         move past the argument
ChkDash  lbsr  SkipSpcs         and any following spaces
         bra   GetChar          start processing again
GetDash  lda   #C$SPAC		get a space char
         sta   -1,x		and wipe out the dash from the cmd line
GetDash2 ldd   ,x+		load option char and char following
         ora   #$20		make lowercase
IsItA    cmpa  #'a		is it this option?
         bne   IsItB		branch if not
         inc   <gota
         lbra  FixCmdLn
IsItB    cmpa  #'b		is it this option?
         bne   IsItC		branch if not
         inc   <gotb
         bra   FixCmdLn
IsItC    cmpa  #'c		is it this option?
         bne   BadOpt		branch if not
         tst   <coptflg		was this option already specified?
         bne   BadOpt		show help if so
         cmpb  #'=		2nd char =?
         bne   BadOpt		show help if not
         inc   <coptflg		else tag this option as parsed
         ldb   #C$SPAC		get space
         stb   -$01,x		write over c
         stb   ,x+		and = sign, inc X to dest dir
* check for valid char after -c=
         lda   ,x
         cmpa  #C$SPAC
         lbeq  ShowHelp         
         cmpa  #C$COMA
         lbeq  ShowHelp         
         cmpa  #C$CR
         lbeq  ShowHelp         
         leay  <copt,u		point Y to parameber buffer
         tfr   y,d		transfer Y to D
         addd  #COPTSIZ
         pshs  b,a		save updated ptr value
         ldb   #C$SPAC		get space
L0339    lda   ,x		get byte at X
         stb   ,x+		store space at X and inc
         sta   ,y+		save loaded byte at Y and inc
         cmpy  ,s		are we at end?
         beq   L035D		branch if so (buffer too small)
         cmpa  #C$SPAC		else is char in A a space?
         beq   L0350		branch if so
         cmpa  #C$COMA		coma?
         beq   L0350		branch if so
         cmpa  #C$CR		cr?
         bne   L0339		get next byte if not
L0350    leax  -1,x
         sta   ,x		restore previous A
         leas  $02,s		kill stack
         lbra  ChkDash
L035D    leas  $02,s
         ldb   #$BF		else buffer size too small
         orcc  #Carry
         lbra  Exit
FixCmdLn lda   #C$SPAC		get space
         sta   -$01,x		and wipe out option character
         cmpb  #'0
         lblt  ChkDash		start dash option processing again
         lbra  GetDash		possibly another option following?

* We branch here if we encounter an unknown option character
* A = bad option character
BadOpt   leax  UnkOpt,pcr
         ldy   #UnkOptL
         ldb   #C$CR
         pshs  d		save bad option and CR on stack
         lda   #$02		stderr
         os9   I$Write
         leax  ,s		point X at option char on stack
         os9   I$WritLn		print option and CR
         puls  d		clean up stack
         lbra  ShowHelp


* At this point options are processed.
* We load X with our parameter pointer and go down the command line
* looking at each file to process (options have been wiped out with
* spaces)
DoNGU    tst   <filecnt		we should have at least one file on cmdline
         lbeq  ShowHelp		if not, exit with error
         ldx   <parmptr		get our parameter pointer off stack
         lbsr  SkipSpcs		skip any leading spaces
         bra   ExitOk

ShowHelp equ   *
         IFNE  DOHELP
         leax  >HlpMsg,pcr	point to help message
         ldy   #HlpMsgL		get length
         lda   #$02		std error
         os9   I$WritLn 	write it
         ENDC
ExitOk   clrb  			clear carry
Exit     os9   F$Exit   	and exit

* This routine counts the number of non-whitespace characters
* starting at X
*
* Entry:
*   X = ptr to string (space, comma or CR terminated)
* Exit:
*   D = length of string
*   X = ptr to byte after string
StrLen   pshs  u
         ldu   #$0000
StrLenLp lda   ,x+
         cmpa  #C$SPAC
         beq   StrLenEx
         cmpa  #C$COMA
         beq   StrLenEx
         cmpa  #C$CR
         beq   StrLenEx
         leau  1,u
         bra   StrLenLp
StrLenEx tfr   u,d
         puls  u,pc

* This routine copies a string of text from X to Y until
* a whitespace character or CR is encountered
*
* Entry:
*   X = ptr to src string
*   Y = ptr to dest string
* Exit:
*   D = number of bytes copied
*   X = ptr to byte after original string
*   Y = ptr to byte after copied string
StrCpy   pshs  u
         ldu   #$0000
CopyFnLp lda   ,x+
         cmpa  #C$SPAC
         beq   CopyFnEx
         cmpa  #C$COMA
         beq   CopyFnEx
         cmpa  #C$CR
         beq   CopyFnEx
         sta   ,y+
         leau  1,u
         bra   CopyFnLp
CopyFnEx tfr   u,d
         puls  u,pc

* This routine skip over spaces and commas
*
* Entry:
*   X = ptr to data to parse
* Exit:
*   X = ptr to first non-whitespace char
*   A = non-whitespace char
SkipSpcs lda   ,x+
         cmpa  #C$SPAC
         beq   SkipSpcs
         cmpa  #C$COMA
         beq   SkipSpcs
         leax  -1,x
         rts

* This routine skips over everything but spaces, commas and CRs
*
* Entry:
*   X = ptr to data to parse
* Exit:
*   X = ptr to first whitespace char
*   A = whitespace char
SkipNSpc lda   ,x+
         cmpa  #C$SPAC
         beq   EatOut
         cmpa  #C$COMA
         beq   EatOut
         cmpa  #C$CR
         bne   SkipNSpc
EatOut   leax  -1,x
         rts

         emod
eom      equ   *
         end
