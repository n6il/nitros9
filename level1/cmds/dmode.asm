         nam   dmode     

* DMode   by Kevin K. Darling
* Disk descriptor utility.
*
* This version will do desc file on disk also.
* 23 Sept 86, 1 Oct 86, 2 Oct 86

* Modified by Roger A. Krupski (HARDWAREHACK)
* Fixes "lower case bug", allows "$" prefix for hex
* Last updated: 08-24-89 RAK

* Oversized and kludgy, but works.
* Apologies for lack of comments.
************************************************
* RBF descriptor utility similar to xmode.
* Use: dmode </devicename> [options]
*      dmode -<filename>   [options]
*       (allows dmode use on a saved desc)
*       (-filename will use data dir for default)
*      dmode -?  will give bit definitions
* If no options given, just returns desc info.
* All numbers must be in HEX.
* dmode
* dmode /h0 cyl=0200 sas=8 ilv=4
* dmode /d0
* dmode -?
* dmode -/d1/modules/d2.dd cyl=0028

         ifp1            
         use   defsfile use defsfile
         use   rbfdefs
         endc            

         mod   size,name,$11,$81,entry,msiz

         org   0         
desc     rmb   $40        dev desc copy
dsize    rmb   2          desc size
path     rmb   1          file path
parmptr  rmb   2          next name dataptr
module   rmb   2          desc address
dataptr  rmb   2          current option ptr
buffptr  rmb   2          buffer address
txtptr   rmb   2          option name ptr
hexin    rmb   2          2 byte hex number
hexcnt   rmb   1          number of option bytes
buffer   rmb   10         output buffer
stack    rmb   200       
params   rmb   150       
msiz     equ   .         

************************************************
name     fcs   "Dmode"   
         fcb   8          version

helpmsg                  
         fcb   C$CR,C$LF
         fcc   "drv  Drive Number 0...n"
         fcb   C$CR,C$LF
         fcc   "stp  Step Rate    0=30, 1=20, 2=12, 3=6ms"
         fcb   C$CR,C$LF
         fcb   C$CR,C$LF
         fcc   'typ  Device Type  bit0- 0=5"   1=8"'
         fcb   C$CR,C$LF
         fcc   "            $20   bit5- 0=non  1=coco"
         fcb   C$CR,C$LF
         fcc   "            $40   bit6- 0=std  1=non"
         fcb   C$CR,C$LF
         fcc   "            $80   bit7- 0=flop 1=hard"
         fcb   C$CR,C$LF
         fcb   C$CR,C$LF
         fcc   "dns  Density      bit0- 0=SD   1=DD"
         fcb   C$CR,C$LF
         fcc   "                  bit1- 0=48   1=96 tpi"
         fcb   C$CR,C$LF
         fcb   C$CR,C$LF
         fcc   "cyl  Cylinders (tracks) (in hex)"
         fcb   C$CR,C$LF
         fcc   "sid  Sides (heads) (in hex)"
         fcb   C$CR,C$LF
         fcc   "vfy  Verify (0=yes)"
         fcb   C$CR,C$LF
         fcc   "sct  Sectors/Track (in hex)"
         fcb   C$CR,C$LF
         fcc   "tos  Sectors/Track on track 0 (in hex)"
         fcb   C$CR,C$LF
         fcc   "ilv  Interleave (in hex)"
         fcb   C$CR,C$LF
         fcc   "sas  Minimum segment allocation (in hex)"
         fcb   C$CR,C$LF
helplen  equ   *-helpmsg 

errmsg                   
         fcb   C$CR,C$LF
         fcc   "Use Dmode /<dev_name> [options...]"
         fcb   C$CR,C$LF
         fcc   " or Dmode -<filename> [options...]"
         fcb   C$CR,C$LF
         fcc   " or Dmode -?  for options help"
         fcb   C$CR,C$LF
         fcb   C$CR,C$LF
         fcc   " NOTE: specify options in hex."
cr       fcb   C$CR,C$LF
msglen   equ   *-errmsg  

synmsg                   
         fcb   C$CR,C$LF
         fcc   "Syntax Error: "
synlen   equ   *-synmsg  


muchhelp                 
         leax  helpmsg,pc
         ldy   #helplen  
         bra   helpprnt  

rbfmsg                   
         fcb   C$CR,C$LF
         fcc   "NOT an RBF descriptor!"
         fcb   C$CR,C$LF
rbflen   equ   *-rbfmsg  

notrbf                   
         leax  rbfmsg,pc 
         ldy   #rbflen   
         lda   #2        
         os9   I$Write   

help                     
         leax  errmsg,pc 
         ldy   #msglen   

helpprnt                 
         lda   #2        
         os9   I$Write   
         lbra  okayend2  

************************************************
entry                    
         ldd   #0        
         std   module     zero mod flag
         sta   path       zero file flag
         ldd   ,x+        check for device name
         cmpa  #'-        file option?
         bne   link      
         cmpb  #'?        help option?
         beq   muchhelp  

* Use Filename to Get Desc:
         lda   #UPDAT.    open path to desc file
         os9   I$Open    
         bcs   error     
         stx   parmptr   
         sta   path       save path number

         ldy   #$40       max size
         leax  desc,u     desc buff
         os9   I$Read     get it
         bcc   use10     
         cmpb  #E$EOF    
         bne   error     

use10                    
         sty   dsize      save desc size
         bra   gotit     

link                     
         cmpa  #PDELIM    else must be /<devicename> 
         bne   help      
         pshs  u         
         lda   #Devic    
         os9   F$Link     link to descriptor
         bcs   error     
         stx   parmptr    update after name
         tfr   u,x       
         puls  u         
         stx   module    
         ldd   M$Size,x   get desc size
         std   dsize     
         leay  desc,u    

mloop                    
         lda   ,x+       
         sta   ,y+       
         decb            
         bne   mloop     

gotit                    
         leax  desc,u    
         lda   $12,x      test device type
         cmpa  #1         RBF?
         bne   notrbf    

         leax  $13,x      point to drive #
         stx   dataptr    save mod option ptr

         ldx   parmptr    point to input parms

skip                     
         lda   ,x+       
         cmpa  #$20       skip blanks
         beq   skip      

         leax  -1,x      
         cmpa  #$0D       no options?
         lbeq  info       ..yes, give info
         lbra  findtxt    else find options

okayend                  
         lbsr  outcr     
okayend2                 
         clrb             okay
error                    
         pshs  b,cc      
         ldu   module    
         beq   bye       
         os9   F$UnLink  
bye                      
         puls  b,cc      
         os9   F$Exit     end dmode.

table                    
         fcc   " drv"     option name 
         fcb   IT.DRV,1      option offset & byte count
         fcc   " stp"    
         fcb   IT.STP,1     
         fcc   " typ"    
         fcb   IT.TYP,1     
         fcc   " dns"    
         fcb   IT.DNS,1     
         fcc   " cyl"    
         fcb   IT.CYL,2     
         fcc   " sid"    
         fcb   IT.SID,1     
         fcc   " vfy"    
         fcb   IT.VFY,1     
         fcc   " sct"    
         fcb   IT.SCT,2     
         fcc   " tos"    
         fcb   IT.T0S,2     
         fcc   " ilv"    
         fcb   IT.ILV,1     
         fcc   " sas"    
         fcb   IT.SAS,1     
         fcc   " t0s"     extra so it parses, but doesn't print!
         fcb   IT.T0S,2     
         fcb   $80        end of table

info     equ   *          Output Current Desc Info:
         ldb   #11        eleven entries (we won't print #12)
         pshs  b         
         leax  table,pc   point to text table
         stx   txtptr    
ilup                     
         bsr   outtext    print label and =
         lbsr  outnum     print value
         ldx   txtptr    
         leax  6,x       
         stx   txtptr    
         dec   ,s        
         lbeq  okayend    ..end of info
         ldb   ,s        
         cmpb  #5         <cr> after 6th option
         bne   ilup      
         bsr   outcr      <cr>
         bra   ilup       ..loop

outcr    equ   *          Print a <CR/LF>:
         leax  cr,pc     
         ldy   #2         byte count

output   equ   *          Print generic
         lda   #1         std out
         os9   I$Write   
         bcc   okay      
         leas  2,s        purge return
         lbra  error      error
okay     rts             


* -----------------------
equal    fcc   "=$"      
outtext  equ   *          Print Option Name:
         ldx   txtptr    
         ldy   #4        
         bsr   output     print option name
         leax  equal,pc  
         ldy   #2        
         bsr   output     sorry, must be a bsr
         rts              return

* -----------------------
outnum   equ   *          Print Hex Option Values:
         ldx   txtptr    
         ldb   5,x        get # of digits
         stb   hexcnt    
numlup                   
         bsr   outhex    
         dec   hexcnt    
         bne   numlup    
         rts             

outhex   equ   *          Print One Byte:
         ldx   dataptr   
         lda   ,x+       
         stx   dataptr   
         pshs  a         
         lsra            
         lsra            
         lsra            
         lsra            
         bsr   outone    
         puls  a         
         anda  #$0F      

outone   equ   *          Print 1/2 Byte Hex Char:
         cmpa  #10       
         bcs   number    
         adda  #$11-10    make alpha
number                   
         adda  #$30       make ASCII
         sta   buffer    
         leax  buffer,u  
         ldy   #1        
         lbra  output    

skipspc  equ   *          Skip Spaces:
         lda   ,x+       
         cmpa  #C$SPAC
         beq   skipspc   
         rts             

************************************************
* X=parmptr

findtxt  equ   *          Find and Set Options:

flup10                   
         bsr   skipspc    get next input param
         stx   parmptr    save for syntax error use
         cmpa  #C$CR      end?
         lbeq  verify     ..yes, update desc CRC

         ora   #$20       force lower case first char
         leay  table-6,pc ready option table ptr
         pshs  d,u       
         ldd   ,x++       get next two chars
         ora   #$20       force lower case
         orb   #$20       -ditto-
         tfr   d,u        place two chars in U
         puls  d          restore A&B (u is still pushed)

flup20                   
         leay  6,y        next option entry
         tst   ,y         last entry?
         lbmi  syntax     ..yes, bad option
         cmpa  1,y       
         bne   flup20     same name?
         cmpu  2,y       
         bne   flup20     ..no, loop

* Found Option
         puls  u         
         sty   txtptr    
         lda   ,x+        must be followed by "="
         cmpa  #'=       
         lbne  syntax    

         bsr   setnum     set that option
         bra   flup10    

* -------------
setnum   equ   *          Get Hex Input and Set Option:
         ldb   5,y        get # of bytes
         stb   hexcnt    
         clr   hexin      zero hex input bytes
         clr   hexin+1   

setloop                  
         lda   ,x+        get next #
         cmpa  #'$        optional hex $?
         beq   setloop    yes, ignore
         cmpa  #C$SPAC    end of number?
         beq   setnum2    ..yes, set option, rts
         cmpa  #C$CR      end of line?
         beq   setnum1   
         bsr   hexcnvt    else, get next num
         bra   setloop    ..loop

setnum1                  
         leax  -1,x       reset so can find <cr>
setnum2                  
         ldb   4,y        get option offset
         leay  desc,u     point to desc
         leay  b,y        point to option
         ldd   hexin      pick up hex input
         dec   hexcnt    
         beq   setone    
         std   ,y         set two byte option
         rts             
setone                   
         tsta            
         lbne  syntax    
         stb   ,y         set one byte option
         rts             

hexcnvt  equ   *          Convert ASCII Hex-->Byte:
         suba  #$30       make number from ASCII
         lbmi  syntax    
         cmpa  #10        is it number?
         bcs   num       
         anda  #$5F       make uppercase 
         suba  #$11-$0a   make hex $A-$F
         cmpa  #$0A      
         lbcs  syntax    
         cmpa  #$10       not hex char?
         lbcc  syntax    
num                      
         ldb   #16        fancy asl *4
         mul             
         pshs  b          save top 4 bits
         ldd   hexin     
         rol   ,s        
         rolb            
         rola            
         rol   ,s        
         rolb            
         rola            
         rol   ,s        
         rolb            
         rola            
         rol   ,s        
         rolb            
         rola            
         std   hexin     
         puls  b,pc       drop temp, rts.

verify   equ   *          Update Descriptor CRC:
         pshs  u          save data ptr
         leau  desc,u    
         tfr   u,x        X is mod address

         ldy   M$Size,x   Y is mod size
         leay  -3,y       beginning of chksum
         tfr   y,d        Y is byte count
         leau  d,u        set U to chksum

         lda   #$FF       init chksum
         sta   ,u        
         sta   1,u       
         sta   2,u       
         pshs  u         
         os9   F$CRC      calc new crc
         puls  u         
         com   ,u+        fix it up right
         com   ,u+       
         com   ,u        

         lda   path       was it file?
         beq   memmod     ..no, in memory
         ldx   #0        
         tfr   x,u       
         os9   I$Seek     go back to file begin
         lbcs  error     
         puls  u         
         leax  desc,u    
         ldy   dsize     
         os9   I$Write    update desc file
         lbra  okayend   

memmod                   
         puls  u         
         leax  desc,u    
         ldb   dsize+1   
         ldy   module    

move                     
         lda   ,x+       
         sta   ,y+       
         decb            
         bne   move      

         lbra  okayend2  


syntax   equ   *         
         leax  synmsg,pc 
         ldy   #synlen   
         lda   #2        
         os9   I$Write   

         ldx   parmptr   
         leax  -1,x      
         pshs  x         
         ldy   #0        

slup                     
         leay  1,y       
         lda   ,x+       
         cmpa  #C$CR
         beq   synsay    
         cmpa  #C$SPAC
         bne   slup      

synsay                   
         puls  x         
         lda   #2        
         os9   I$Write    output err
         lbra  okayend   

         emod            
size     equ   *         
         end             
