* F$CRCMod entry point - CHANGED 05/20/93
* Entry : A = 0 Report current mode
*           = 1 Shut CRC Checking off
*           =>2 Turn CRC Checking on
* Exit  : A = 0 CRC is off
*             1 CRC is on
*         no error can be returned
*         except if call not available
FCRCMod  lda    R$A,u       do they want a report or a toggle?
         beq    CRCRep      a report only
         deca               Check for OFF
         bne    GoCRCon     No, must be on
         fcb   $8C        --- skip 2 bytes, saves 3 bytes of memory
*         sta    <D.CRC      Shut CRC flag off
*         bra    CRCRep2     Save in caller's A & return
GoCRCon  lda    #$1         CRC checking on
         sta    <D.CRC      Turn CRC checking on
CRCRep   lda    <D.CRC      get current CRC flag for return
CRCRep2  sta    R$A,u       save it to their register stack
         clrb               no error 
         rts                and exit
