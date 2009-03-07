 IFNE H6309-1
**
** Rev 3 Notes:
**
**   For CoCo 1,2 or 3
**   6809 Timing
**   No Read Count in Receiver
**


******************************************************************************
* COCO 57600 / 115.2K BAUD BIT-BANGER TRANSMITTER
******************************************************************************
*
* TRNSMITS A SPECIFIED NUMBER OF DATA BYTES THROUGH THE BIT-BANGER PORT
* AT HIGH SPEED. ALL OF THE DATA IS SENT IN A SINGLE BURST, NO HANDSHAKING
* IS PROVIDED. THE TRANSMISSION FORMAT IS:
*    1 START BIT, 8 DATA BITS, NO PARITY, 1 STOP BIT.
*
*  ON ENTRY:
*    X = ADDRESS OF DATA TO TRANSMIT
*    Y = NUMBER OF BYTES TO TRANSMIT
*
*  ON EXIT:
*    X = ADDRESS OF LAST BYTE TRANSMITTED + 1
*    Y = 0
*    A, B AND U ARE PRESERVED
*
******************************************************************************
BBOUT     EQU       $FF20               ; BIT-BANGER OUTPUT ADDRESS

DWWrite
XMT56K    PSHS      U,DP,D,CC           ; PRESERVE REGISTERS
          LDD       #$04FF              ; A = LOOP COUNTER, B = $FF
          ORCC      #$50                ; MASK INTERRUPTS
          TFR       B,DP                ; SET DIRECT PAGE TO $FFXX
          SETDP     $FF                 ; INFORM ASSEMBLER OF NEW DP VALUE
          FCB       $8C                 ; SKIP NEXT INSTRUCTION

OUTBYT    STB       <BBOUT    4 \       ; STOP BIT
          LDB       ,X+       6  |      ; GET NEXT BYTE FROM STORAGE
          NOP                 2  | 16   ; CONSUME 2 CYCLES
          LSLB                2  |      ; BIT 7->CARRY .. BIT 0->B.1 ..'0'->B.0
          ROLB                2 /       ; BIT 7 -> B.0 .. BIT 0->B.2 ..'0'->B.1

ODDBIT    STB       <BBOUT    4 \       ; START BIT, DATA BITS 1,3 AND 5
          RORB                2  | 16   ; MOVE NEXT BIT INTO POSITION
          EXG       A,A       8  |      ; 8-CYCLE DELAY
          NOP                 2 /       ; MORE DELAY

          STB       <BBOUT    4 \       ; DATA BITS 0,2,4 AND 6
          RORB                2  |      ; MOVE NEXT BIT INTO POSITION
          LEAU      ,U        4  | 15   ; 4-CYCLE DELAY
          DECA                2  |      ; DECREMENT LOOP COUNTER
          BNE       ODDBIT    3 /       ; LOOP UNTIL BIT 6 HAS BEEN TRANSMITTED

          STB       <BBOUT    4 \       ; DATA BIT 7
          LDD       #$0402    3  | 16   ; A = LOOP COUNTER, B = STOP BIT VALUE
          LEAY      ,-Y       6  |      ; DECREMENT BYTES REMAINING COUNT
          BNE       OUTBYT    3 /       ; LOOP IF MORE TO TRANSMIT

          STB       <BBOUT              ; FINAL STOP BIT
          PULS      CC,D,DP,U,PC        ; RESTORE REGISTERS AND RETURN
          SETDP     $00




 ELSE




** Rev 4 Notes:
**
**   For CoCo 2 or 3
**   6309 Native Mode
**   No Read Count in Receiver
**


******************************************************************************
* COCO 57600 / 115.2K BAUD BIT-BANGER TRANSMITTER
******************************************************************************
*
* TRNSMITS A SPECIFIED NUMBER OF DATA BYTES THROUGH THE BIT-BANGER PORT
* AT HIGH SPEED. ALL OF THE DATA IS SENT IN A SINGLE BURST, NO HANDSHAKING
* IS PROVIDED. THE TRANSMISSION FORMAT IS:
*    1 START BIT, 8 DATA BITS, NO PARITY, 1 STOP BIT.
*
*  ON ENTRY:
*    X = ADDRESS OF DATA TO TRANSMIT
*    Y = NUMBER OF BYTES TO TRANSMIT
*
*  ON EXIT:
*    X = ADDRESS OF LAST BYTE TRANSMITTED + 1
*    Y = 0
*    A, B, E, F AND U ARE PRESERVED
*
******************************************************************************
BBOUT     EQU       $FF20               ; BIT-BANGER OUTPUT ADDRESS

DWWrite
XMT56K    PSHS      U,D,CC              ; PRESERVE REGISTERS
          LDU       #BBOUT              ; POINT U TO BIT BANGER OUTPUT
          ORCC      #$50                ; MASK INTERRUPTS
*          LDMD      #1                  ; REQUIRES 6309 NATIVE MODE
          BRA       XSTART              ; SKIP NEXT INSTRUCTION

OUTBYT    STB       ,U        4 \       ; STOP BIT
XSTART    LDB       ,X+       5  |      ; GET NEXT BYTE FROM STORAGE
          LSLB                1  | 16   ; BIT 7->CARRY .. BIT 0->B.1 ..'0'->B.0
          ROLB                1  |      ; BIT 7 -> B.0 .. BIT 0->B.2 ..'0'->B.1
          LDA       #8        2  |      ; BIT COUNT (START BIT, DATA BITS 0-6)
          BRA       BSEND     3 /       ; ENTER THE LOOP

XLOOP     BITA      #1        2         ; BIT COUNTER EVEN OR ODD?
          BEQ       BSEND     3         ; BRANCH IF EVEN (15-CYCLE BIT)
          NOP                 1         ; ONE MORE FOR A 16-CYCLE BIT
BSEND     STB       ,U        4 \       ; BIT OUTPUT
          RORB                1  |      ; ROTATE NEXT BIT INTO POSITION
          NOP                 1  | 10   ; DELAY CYCLE
          DECA                1  |      ; DECREMENT BIT COUNTER
          BNE       XLOOP     3 /       ; LOOP UNTIL BIT 6 HAS BEEN SAMPLED
          LEAU      ,U++      6         ; CONSUME 6 CYCLES (16 TOTAL FOR BIT 6)

          STB       ,U        4 \       ; BIT 7 OUTPUT
          LDB       #2        2  |      ; PREPARE STOP BIT
          NOP                 1  | 15   ; DELAY CYCLE
          LEAY      -1,Y      5  |      ; DECREMENT BYTES REMAINING COUNT
          BNE       OUTBYT    3 /       ; LOOP IF MORE TO TRANSMIT

          STB       ,U                  ; FINAL STOP BIT
          PULS      CC,D,U,PC           ; RESTORE REGISTERS AND RETURN

 ENDC


