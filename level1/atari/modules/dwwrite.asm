* Write
*    Send a packet to the DriveWire server.
*    Serial data format:  1-8-N-1
*
* Entry:
*    X  = starting address of data to send
*    Y  = number of bytes to send
*
* Exit:
*    X  = address of last byte sent + 1
*    Y  = 0
*    All others preserved
*
SKSEND    equ   $23
MSKSEND   equ   %00010000
DWWrite        
          pshs      d,cc
          orcc      #$50
*          lda	    #SKSEND
*          sta	    SKCTL
*          sta	    SKRES
          lda       D.IRQENSHDW
byteloop@
          ora       #%00001000
          sta       IRQEN
          lda       ,x+
          sta       SEROUT
waitloop@
          ldb       IRQST
          bitb      #%00001000
          bne       waitloop@
          lbsr      Wait
          lda       D.IRQENSHDW
          sta       IRQEN
          leay      -1,y
          bne       byteloop@
ex@
          clrb
          puls      cc,d,pc

Wait
          pshs      x
          ldx       #$100
wait@          
          leax      -1,x
          bne       wait@
          puls      x,pc
          
