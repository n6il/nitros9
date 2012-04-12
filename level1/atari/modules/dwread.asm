* DWRead
*    Receive a response from the DriveWire server.
*    Times out if serial port goes idle for more than 1.4 (0.7) seconds.
*    Serial data format:  1-8-N-1
*
* Entry:
*    X  = starting address where data is to be stored
*    Y  = number of bytes expected
*
* Exit:
*    CC = carry set on framing error, Z set if all bytes received
*    X  = starting address of data received
*    Y  = checksum
*    U is preserved.  All accumulators are clobbered
*
DWRead                    
          clrb                     clear carry
          pshs      cc,a,x,y,u
          tfr       x,u
          ldx       #$0000
          orcc      #$50
*          lda       D.IRQENSHDW
*          sta       IRQEN
*          ora       #%00100000
* enable the serial input interrupt
          
          ldb  SERIN               read what is in the buffer
          lda	#$13
          sta	SKCTL
          sta	SKRES

inloop@
          lda       D.IRQENSHDW
          ora       #%00100000
          sta       IRQEN
          ldd       #$0000
loop@
          subd      #$0001
          beq       outtahere@
          pshs      b
          ldb       IRQST
          bitb      #%00100000
          puls      b
          bne       loop@
          ldb       SERIN
          lda       D.IRQENSHDW
          sta       IRQEN
* check for framing error
          lda       SKSTAT
          bpl       outtahere@	framing error
          lsla
          bpl       outtahere@	data input overrun
          stb       ,u+
          abx
          leay      -1,y
          bne       inloop@
          stx       4,s
bye
          sta	     SKRES          clear framing or data input overrun bits
          puls      cc,a,x,y,u,pc
outtahere@
          sta	     SKRES          clear framing or data input overrun bits
          puls      cc,a
          stx       2,s
          orcc      #$01
          puls      x,y,u,pc
