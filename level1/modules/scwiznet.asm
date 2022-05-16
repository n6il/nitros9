********************************************************************
* scwiznet - WizNet Network Driver
*
* $Id$
*
* How this wildcard /E stuff works:
* A process interested in obtaining a path to a network device
* can open any /Ex descriptor but it may be in use by another process.
* The safest way to obtain a new network device is to open the wildcard
* descriptor /E. This works similarly to the way /W works in the CoCo 3
* VTIO driver.
*
* When /E is open, the INIT routine is called but most of it is bypassed
* because it detects the wildcard device (which has an address of $FFFF). 
*
* The SS.Open I$SetStat entry point is called. That routine also detects
* the wildcard is used, so the hunt is on for the next available /Ex
* descriptor (it does this by checking the DW static storage for each /Ex
* in the DW static storage page).  If it finds a free page, it notes the
* offset as a number, then builds a descriptor name (ex: /E4) and then
* F$Links to it.  It then takes the descriptor module address and sticks it
* in the device table entry for /E.  It also takes the V.PORT address and sticks
* it in the static storage memory allocated for /E.
* Afer that, SS.Open does something really sneaky: it branches into the
* Init routine which detects via the static storage that this is not a /E 
* descriptor but a /E4 descriptor.  Init then sends the SERINIT and initializes
* the DW static storage for /E4.  Control is returned to the SS.Open code which
* then advertises the SS.Open to the server.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2020/05/16  Boisy Pitre.
* Started from scdwv.asm
*
               nam       scwiznet
               ttl       WizNet Network Driver

               use       defsfile
               use       drivewire.d

tylg           set       Drivr+Objct
atrv           set       ReEnt+Rev
rev            set       $00
edition        set       2

* Note: driver memory defined in dwdefs.d
               mod       eom,name,tylg,atrv,start,SCFDrvMemSz

* module info         	
               fcb       UPDAT.+SHARE.       ;driver access modes
name           fcs       /scwiznet/          ;driver name
               fcb       edition             ;driver edition 

* dispatch calls            
start          equ       *
               lbra      Init
               lbra      Read
               lbra      Write
               lbra      GetStat
               lbra      SetStat

***********************************************************************
* Term
*
* shut down the driver.
* should close only the correct port, tell server to close the port,
* and remove irq handler when no ports are left 
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code   
Term           equ       *
termbye        clrb      
               rts       

***********************************************************************
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

Init           equ       *
               rts       

*****************************************************************************
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
Write          equ       *

NotReady       comb      
               ldb       #E$NotRdy
               rts       

*************************************************************************************
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
Read           equ       *
               rts                           ; return


**********************************************************************
* GetStat - heavily borrowed from sc6551
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
GetStat                  
               clrb                          ; default to no error...

* Advertise Stat Code to server
* A = Function Code
* B = OP_SERGETSTAT or OP_SERSETSTAT
SendStat                 
; advertise our GetStt code to the server
               pshs      a,y,x,u
               puls      a,y,x,u,pc

*************************************************************************         
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
SetStat                  
               cmpa      #SS.Open
               bne       isitcomst
               bsr       open
               bcs       ssbye
               ldd       #SS.Open*256+OP_SERSETSTAT
               bra       SendStat
isitcomst                
               ldb       #OP_SERSETSTAT
               bsr       SendStat
               cmpa      #SS.ComSt
               beq       comst
               cmpa      #SS.Close
               beq       ex
               cmpa      #SS.SSig
               beq       ssig
               cmpa      #SS.Montr
               beq       ex
               cmpa      #SS.Relea
               bne       donebad
relea          lda       PD.CPR,y            get curr proc #
               cmpa      <SSigID,u           same?
               bne       ex
               clr       <SSigID,u           clear process id
ex             rts       
sskysns        
               rts
ssig           pshs      cc
               orcc      #IntMasks
               lda       PD.CPR,y            ; get curr proc #
               ldx       PD.RGS,y
               ldb       R$X+1,x             ; get user signal code
               tst       RxDatLen,u          ; get Rx data length
               beq       ssigsetup           ; branch if no data in buffer
* if here, we have data so send signal immediately
               os9       F$Send
               puls      cc,pc
ssigsetup      std       <SSigID,u           ; save process ID & signal
               puls      cc,pc

donebad        comb      
               ldb       #E$UnkSvc
               rts       

comst          leax      PD.OPT,y
               ldy       #OPTCNT
               clrb      
ssbye          rts       

* SS.Open processor
* Entry: X=Register stack pointer
*        U=Static memory pointer
*        Y=Path descriptor pointer
open           tst       <V.PORT+1,u         check if this is $FFFF (wildcard)
               bpl       ssbye               if not, we have nothing to do
               pshs      u,y                 preserve registers
               ldx       PD.DEV,y            get pointer to device table entry
               ldx       V$DESC,x            get pointer to /N descriptor
               pshs      x                   save device descriptor pointer
* start at /N1
               ldb       #1
L0B58          equ       *
; cheat: we know DW.StatTbl is at offset $00 from D.DWStat, do not bother with leax
;		leax      DW.StatTbl,x
next           cmpb      #DW.StatCnt
               bge       opexer
               tst       b,x
               beq       found
               incb      
               bra       next
opexer         comb                          set carry
               ldb       #E$MNF              get module not found error
               puls      x,y,u,pc            purge stack and return

* Found a free spot
found          pshs      b                   save # of free entry
               leas      -5,s
               leay      ,s
               ldb       #'N                 get netdev name prefix
               stb       ,y+                 put it in buffer
               ldb       5,s                 get netdev # that was free
* Convert netdev # in B to ASCII eqivalent with high bit set

               ifne      H6309
               clra
               divd      #10                 divide it by 10
               else      
               lda       #-1
L0B87b         inca      
               subb      #10
               bcc       L0B87b
               addb      #10
               exg       a,b
               cmpb      #0
               endc      
               beq       L0B87               if answer is 0 there is only 1 digit, skip ahead 
               orb       #$30                make first digit ASCII
               stb       ,y+                 put it in buffer
L0B87          ora       #$B0                make remainder ASCII with high bit set
               sta       ,y+                 put it in buffer
L0B92          leas      -2,s                make a buffer for process decriptor pointer
               ifgt      Level-1
               lbsr      L0238               switch to system process descriptor
               endc      
               leax      2,s                 Point to calculated dsc. name
               lda       #Devic+Objct        get module type
               os9       F$Link              try & link it
               ifgt      Level-1
               lbsr      L0244               switch back to current process
               endc      
               leas      7,s                 purge stack
               bcc       L0BAB               it's linked, skip ahead
L0BA7          puls      b                   get original number
               incb      
               bra       L0B58               go find another free space

               ifgt      Level-1
* Switch to system process descriptor
L0238          pshs      d                   Preserve D
               ldd       <D.Proc             Get current process dsc. ptr
               std       4,s                 Preserve on stack
               ldd       <D.SysPrc           Get system process dsc. ptr
               std       <D.Proc             Make it the current process
               puls      d,pc                Restore D & return

* Switch back to current process
L0244          pshs      d                   Preserve D
               ldd       4,s                 Get current process ptr
               std       <D.Proc             Make it the current process
               puls      d,pc                Restore D & return
               endc      

* Got a device descriptor, put into device table & save netdev # into static
L0BAB                    
               lda       M$PORT+2,u          get MSB of port byte of newly linked /N? descriptor
               ldy       3,s                 get path descriptor pointer
               ldx       PD.DEV,y            get pointer to device table
               stu       V$DESC,x            save pointer to descriptor into it
               ldu       1,s                 get pointer to /N descriptor
               os9       F$UnLink            unlink it from system map
               ldu       5,s                 get static mem pointer
               sta       V.PORT+1,u
               leas      7,s                 purge stack
* Load Y with address of descriptor and U with address of memory area
               ldy       V$DESC,x
               pshs      x,y,u
               lbsr      Init                call Init to setup dw statics
               puls      x,y,u,pc

               emod      
eom            equ       *
               end       
