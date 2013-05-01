********************************************************************
* llcocosdc - CoCo SD Low-level driver
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2004/??/??  Boisy G. Pitre
* Created.

               NAM       llcocosdc
               TTL       CoCo SDC Low-level driver

               USE       defsfile
               USE       rbsuper.d

tylg           SET       Sbrtn+Objct
atrv           SET       ReEnt+rev
rev            SET       0


               MOD       eom,name,tylg,atrv,start,0

               ORG       V.LLMem
* Low-level driver static memory area

name           FCS       /llcocosdc/

start          bra       ll_init
               nop       
               lbra      ll_read
               lbra      ll_write
               bra       ll_getstat
               nop       
               lbra      ll_setstat
*         lbra  ll_term   

* ll_term
*
* Entry:
*    Y  = address of device descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
ll_term                  
               clrb      
               rts       

* ll_init
*
* Entry:
*    Y  = address of device descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
ll_init                  
               clrb      
               rts       


* ll_getstat
*
* Entry:
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
ll_getstat               
               lda       R$B,x
               cmpa      #SS.DSize
               beq       SSDSize
               ldb       #E$UnkSvc
               coma      
               rts       


* SS.DSize - Return size information about a device
*
* Entry: B = SS.DSize
* Exit:  Carry = 1; error with code in B
*        Carry = 0:
*          IF B = 0
*            A = Sector Size (1 = 256, 2 = 512, 4 = 1024, 8 = 2048)
*            X = Number of Sectors (bits 31-16)
*            Y = Number of Sectors (Bits 15-0)
*          IF B != 0
*            A = Sector Size (1 = 256, 2 = 512, 4 = 1024, 8 = 2048)
*            X = Number of Logical Cylinders
*            B = Number of Logical Sides
*            Y = Number of Logical Sectors/Track
*
SSDSize                  
               clrb      
               rts


* ll_setstat
*
* Entry:
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
ll_setstat               
               clrb      
               rts       

* ll_read
*
* Entry:
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Static memory referenced:
*    V.CchPSpot     = address of spot in cache where physical sector data will go
*    sectsize       = sector size (0=256,1=512,2=1024,3=2048)
*    V.SectCnt      = sectors to read
*    V.PhysSect = physical sector to start read from
ll_read                  
               lda       PD.DRV,y
               ldb       V.PhysSect,u
               ldx       V.PhysSect+1,u
               ldu       V.CchPSpot,u
 ldy #$FF4A
 stb -1,y
 stx ,y
 ldb #$43
 stb $FF40
 ora #$80
 sta -2,y
 exg a,a

 ldx #0
rdWait lda -2,y
 bmi rdFail
 bita #2
 bne rdRdy
 leax -1,x
 bne rdWait
rdFail clr $FF40
 ldb #E$Read
 coma
 rts

rdRdy leax ,u
 ldd #32*256+8
rdChnk ldu ,y
 stu ,x
 ldu ,y
 stu 2,x
 ldu ,y
 stu 4,x
 ldu ,y
 stu 6,x
 abx
 deca
 bne rdChnk

 clr $FF40
 rts


* ll_write
*
* Entry:
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Static memory referenced:
*    V.CchPSpot     = address of spot in cache where physical sector data is
*    sectsize       = sector size (0=256,1=512,2=1024,3=2048)
*    V.SectCnt      = sectors to read
*    V.PhysSect     = physical sector to start read from
ll_write                 
               lda       PD.DRV,y
               ldb       V.PhysSect,u
               ldx       V.PhysSect+1,u
               ldu       V.CchPSpot,u

 ldy #$FF4A
 stb -1,y
 stx ,y
 ldb #$43
 stb $FF40
 ora #$A0
 sta -2,y
 exg a,a

 ldx #0
wrWait lda -2,y
 bmi wrFail
 bita #2
 bne wrRdy
 leax -1,x
 bne wrWait
wrFail clr $FF40
 ldb  #E$Write
 coma
 rts

wrRdy leax ,u
 ldd #64*256+4
wrChnk ldu ,x
 stu ,y
 ldu 2,x
 stu ,y
 abx
 deca
 bne wrChnk

wrComp lda -2,y
 bmi wrFail
 lsra
 bcs wrComp

 clr $FF40
 rts

               EMOD      
eom            EQU       *
               END       

