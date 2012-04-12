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
* Based on the hipatch source for the Atari and translated
* into 6809 assembly language by Boisy G. Pitre.
*
RMSEND    equ       %11101111
SKSEND    equ       %00100011
MSKSEND   equ       %00010000
IMSEND    equ       %00010000
IMSCPL    equ       $08
DWWrite
          andcc     #^$01               ; clear carry to assume no error
          pshs      d,cc
; setup pokey
          lda       #$28
          sta       AUDCTL
*          lda       #$A0
          lda       #$A8
          sta       AUDC4
* short delay before send
          clra
shortdelay@
          deca
          bne       shortdelay@
          orcc      #$50                ; mask interrupts
          lda	     #SKSEND        	; set pokey to transmit data mode
          sta	     SKCTL
          sta	     SKRES
          lda       D.IRQENSHDW
          ora       #MSKSEND
          sta       IRQEN
          lda       ,x+
          sta       SEROUT
          leay      -1,y
          beq       ex@
byteloop@
          lda       ,x+
          ldb       #IMSEND
* NOTE: Potential infinite loop here!
waitloop@
          bitb      IRQST
          bne       waitloop@
          ldb       #RMSEND
          stb       IRQEN
          ldb       D.IRQENSHDW
          orb       #MSKSEND
          stb       IRQEN
          sta       SEROUT
          leay      -1,y
          bne       byteloop@
ex@
          lda       #IMSCPL
wt        bita      IRQST	; wait until transmit complete
          bne       wt
          puls      cc,d,pc
