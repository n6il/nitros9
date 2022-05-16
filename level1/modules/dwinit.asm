*******************************************************
*
* DWInit
*    Initialize DriveWire for CoCo Bit Banger

DWInit
               IFNE     ARDUINO

* setup PIA PORTA (read)
               clr       $FF51
               clr       $FF50
               lda       #$2C
               sta       $FF51

* setup PIA PORTB (write)
               clr       $FF53
               lda       #$FF
               sta       $FF52
               lda       #$2C
               sta       $FF53
               rts

               ELSE

               pshs      a,x

               IFNE MEGAMINIMPI
               pshs b,cc,dp
               orcc #$50                 ; clear interrupts
               lda #$ff                  ; set up DP
               tfr a,dp

               lda <MPIREG               ; save mpi settings
               pshs a
               anda #CTSMASK             ; Save previous CTS, clear off STS
               ora #MMMSLT               ; Set STS for MMMPI Uart Slot
               sta <MPIREG

               ; FF48
               sta <MMMUARTB+RST         ; Reset UART

               ; FF41
               clr <MMMUARTB+IER         ; IER: disable interrupts

               ; FF42
               lda #FCRFEN|FCRRXFCLR|FCRTXFCLR|FCRTRG8B ; FCR: enable,clear fifos, 8-byte trigger
               sta <MMMUARTB+FCR
               ;ldd #$0087
               ;std <MMMUARTB+IER

               ; FF43
               lda #LCR8BIT|LCRPARN       ; LCR: 8N1,DLAB=0
               sta <MMMUARTB+LCR

               ; FF44
               lda #MCRDTREN|MCRRTSEN|MCRAFEEN ; MCR: DTR & Auto Flow Control
               sta <MMMUARTB+MCR
               ; ldd #$8323
               ; std <MMMUARTB+LCR

               ; FF43
               lda <MMMUARTB+LCR          ; enable DLAB
               ora #DLABEN
               sta <MMMUARTB+LCR

               ; FF40
               ldd #MMMB921600            ; Set Divisor Latch
               ; std MMMUARTB+DL16        ; 16-bit DL helper
               sta <MMMUARTB+DLM
               stb <MMMUARTB+DLL

               ; FF43
               lda <MMMUARTB+LCR          ; disable DLAB
               anda #DLABDIS
               ; lda #$03
               sta <MMMUARTB+LCR

; clrloop@       lda <MMMUARTB+LSR          ; check RX FiFo Status
;                bita #LSRDR
;                beq restore@               ; its empty
;                lda <MMMUARTB              ; dump any data that's there
;                bra clrloop@
; restore@

               puls a                     ; restore mpi settings
               ; lda #$33
               sta <MPIREG
               puls b,cc,dp
               ENDC

               IFDEF     PIA1Base
               ldx       #PIA1Base           $FF20
               clr       1,x                 clear CD
               lda       #%11111110
               sta       ,x
               lda       #%00110100
               sta       1,x
               lda       ,x
               ENDC
               puls       a,x,pc

               ENDC
