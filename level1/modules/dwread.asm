 IFNE H6309-1
**
** Rev 3 Notes:
**
**   For CoCo 1,2 or 3
**   6809 Timing
**   No Read Count in Receiver
**


******************************************************************************
* COCO 57600 / 115.2K BAUD BIT-BANGER RECEIVER
******************************************************************************
*
* WAITS FOR A SPECIFIED TIMEOUT PERIOD UNTIL A START-BIT APPEARS ON THE
* BIT-BANGER INPUT. DATA RECEPTION IS INITIATED IF A START-BIT APPEARS
* BEFORE THE TIMEOUT PERIOD EXPIRES. THE SERIAL DATA FORMAT MUST BE:
*    1 START BIT, 8 DATA BITS, NO PARITY, 1..2 STOP BITS.
*
* DATA RECPEPTION TERMINATES WHEN:
*   - A PERIOD OF APPROX 5.5 MS (2.75 MS) ELLAPSES WITHOUT A NEW START-BIT
*   - A FRAMING ERROR IS DETECTED.
*
*  ON ENTRY:
*    X = START ADDRESS FOR DATA STORAGE
*    A = TIMEOUT VALUE (182 = APPROX ONE SECOND @ 0.89 MHZ)
*
*  ON EXIT:
*    Y = DATA CHECKSUM
*    D = ACTUAL NUMBER OF BYTES RECEIVED
*    X AND U ARE PRESERVED
*    CC.CARRY IS SET ONLY IF A FRAMING ERROR WAS DETECTED
*
******************************************************************************
BBIN      EQU       $FF22               ; BIT-BANGER INPUT ADDRESS
BCTR      EQU       1                   ; OFFSET TO BIT LOOP COUNTER ON STACK
RCVSTA    EQU       2                   ; OFFSET TO CC VALUE ON THE STACK
BUFBAS    EQU       4                   ; OFFSET TO STORAGE ADDRESS ON STACK

DWRead
RCV56K    CLRB                          ; CLEAR CARRY FLAG (NO FRAMING ERROR)
          PSHS      U,X,DP,CC           ; PRESERVE REGISTERS
          STA       ,--S                ; STORE INITIAL TIMEOUT DURATION
          LDD       #$01FF              ; A = SERIAL INPUT MASK, B = $FF
          ORCC      #$50                ; MASK INTERRUPTS
          TFR       B,DP                ; SET DIRECT PAGE TO $FFXX
          SETDP     $FF                 ; INFORM ASSEMBLER OF NEW DP VALUE
          LEAU      ,X                  ; POINT U TO STORAGE ADDRESS
          LDX       #0                  ; INITIALIZE CHECKSUM
          BRA       WAIT1               ; GO WAIT FOR A START BIT

BSTART    LEAU      1,U       5 \ 11    ; ADVANCE THE STORAGE PTR
          CLR       ,S        6 /       ; RESET TIMEOUT MSB TO 1

          LDB       <BBIN     4 \       ; BIT 0
          LSRB                2  |
          RORB                2  | 15
          LDA       #3        2  |
          STA       BCTR,S    5 /

BLOOP     LDA       <BBIN     4 \       ; BITS 1,3 AND 5
          LSRA                2  | 15
          RORB                2  |
          DEC       BCTR,S    7 /

          LDA       <BBIN     4 \       ; BITS 2,4 AND 6
          LSRA                2  |
          RORB                2  | 16
          LDA       BCTR,S    5  |
          BNE       BLOOP     3 /

          LDA       <BBIN     4 \       ; BIT 7
          LSRA                2  |
          RORB                2  | 16
          ABX                 3  |      ; ACCUMULATE CHECKSUM
          STB       -1,U      5 /       ; PUT BYTE INTO STORAGE

          LDA       <BBIN     4 \       ; STOP BIT
          ANDA      #1        2  | 9    ; MASK OUT ALL OTHER BITS (1-7)
          BEQ       FINISH    3 /       ; BRANCH IF FRAMING ERROR

WAIT1     BITA      <BBIN     4 \  7    ; TWO RAPID TESTS FOR NEXT START BIT
          BEQ       BSTART    3 /
          BITA      <BBIN     4 \
          BEQ       BSTART    3  | 9
          LDB       #$FF      2 /       ; INIT TIMEOUT LSB

WAIT2     BITA      <BBIN     4 \
          BEQ       BSTART    3  | 9
          SUBB      #1        2 /       ; DECREMENT TIMEOUT LSB
          BITA      <BBIN     4 \
          BEQ       BSTART    3  | 10
          BCC       WAIT2     3 /       ; LOOP UNTIL TIMEOUT LSB < 0

          BITA      <BBIN     4 \
          BEQ       BSTART    3  | 11
          LDB       ,S        4 /       ; GET TIMEOUT MSB
          BITA      <BBIN     4 \
          BEQ       BSTART    3  | 9
          SUBB      #1        2 /       ; DECREMENT TIMEOUT MSB
          BITA      <BBIN     4 \
          BEQ       BSTART    3  | 11
          STB       ,S        4 /       ; STORE TIMEOUT MSB
          BITA      <BBIN     4 \
          BEQ       BSTART    3  | 10
          BCC       WAIT1     3 /       ; LOOP IF TIMEOUT NOT EXPIRED

FINISH    INCA                          ; IF FRAMING ERROR THEN A=1 ELSE A=2
          ORA       RCVSTA,S            ; SET CARRY BIT IN CC VALUE ON..
          STA       RCVSTA,S            ; ..THE STACK ONLY IF FRAMING ERROR
          LEAY      ,X                  ; RETURN CHECKSUM IN Y
          TFR       U,D                 ; CALCULATE ACTUAL NUMBER..
          SUBD      BUFBAS,S            ; ..OF BYTES RECEIVED
          LEAS      2,S                 ; POP TIMEOUT AND BIT LOOP COUNTERS
          PULS      CC,DP,X,U,PC        ; RESTORE REGISTERS AND RETURN
          SETDP     $00








 ELSE



** Rev 4 Notes:
**
**   For CoCo 2 or 3
**   6309 Native Mode
**   No Read Count in Receiver
**

******************************************************************************
* COCO 57600 / 115.2K BAUD BIT-BANGER RECEIVER
******************************************************************************
*
* WAITS FOR A SPECIFIED TIMEOUT PERIOD UNTIL A START-BIT APPEARS ON THE
* BIT-BANGER INPUT. DATA RECEPTION IS INITIATED IF A START-BIT APPEARS
* BEFORE THE TIMEOUT PERIOD EXPIRES. THE SERIAL DATA FORMAT MUST BE:
*    1 START BIT, 8 DATA BITS, NO PARITY, 1..2 STOP BITS.
*
* DATA RECPEPTION TERMINATES WHEN:
*   - A PERIOD OF APPROX 5.5 MS (2.75 MS) ELLAPSES WITHOUT A NEW START-BIT
*   - A FRAMING ERROR IS DETECTED.
*
*  ON ENTRY:
*    X = START ADDRESS FOR DATA STORAGE
*    A = TIMEOUT VALUE (183 = APPROX ONE SECOND @ 0.89 MHZ)
*
*  ON EXIT:
*    Y = DATA CHECKSUM
*    D = ACTUAL NUMBER OF BYTES RECEIVED
*    X AND U ARE PRESERVED
*    E AND F ARE CLOBBERED
*    CC.CARRY IS SET ONLY IF A FRAMING ERROR WAS DETECTED
*
******************************************************************************
BBIN      EQU       $FF22               ; BIT-BANGER INPUT ADDRESS
RCVSTA    EQU       0                   ; OFFSET TO CC VALUE ON THE STACK
BUFBAS    EQU       1                   ; OFFSET TO STORAGE ADDRESS ON STACK

DWRead
RCV56K    CLRB                          ; CLEAR CARRY FLAG (NO FRAMING ERROR)
          PSHS      U,X,CC              ; PRESERVE REGISTERS
          LDU       #BBIN               ; POINT U TO BIT BANGER INPUT
          TFR       A,F                 ; COPY INTITAL TIMEOUT TO F
          LDD       #$01FF              ; A = SERIAL IN MASK, B = TIMEOUT LSB
          LEAY      ,X                  ; POINT Y TO STORAGE ADDRESS
          LDX       #0                  ; INITIALIZE CHECKSUM
          ORCC      #$50                ; MASK INTERRUPTS
*          LDMD      #1                  ; REQUIRES 6309 NATIVE MODE
          BRA       WAIT1               ; GO WAIT FOR A START BIT

BSTART    SEXW                4 \       ; 4-CYCLE DELAY (CLOBBERS D)
          LDW       #$005A    4  | 11   ; PREP SHIFT COUNTER / TIMING FLAGS
          BRA       BSAMP     3 /       ; ENTER THE LOOP

BLOOP     BCC       BSAMP     3         ; BRANCH IF A 15-CYCLE BIT
          NOP                 1         ; ONE MORE FOR A 16-CYCLE BIT
BSAMP     LDA       ,U        4 \       ; SAMPLE DATA BIT
          LSRA                1  |      ; SHIFT INTO CARRY
          RORB                1  | 12   ; ROTATE INTO BYTE ACCUMULATOR
          NOP                 1  |      ; DELAY CYCLE
          LSRW                2  |      ; BUMP THE SHIFT COUNTER / TIMING FLAGS
          BNE       BLOOP     3 /       ; LOOP UNTIL BIT 6 HAS BEEN SAMPLED
          LEAU      ,U        4         ; CONSUME 4 CYCLES (16 TOTAL FOR BIT 6)

          LDA       ,U        4 \       ; BIT 7
          LSRA                1  |
          RORB                1  | 15
          STB       ,Y+       5  |      ; PUT BYTE INTO STORAGE
          ABX                 1  |      ; ACCUMULATE CHECKSUM
          LDD       #$01FF    3 /       ; A = SERIAL IN MASK, B = TIMEOUT LSB

          ANDA      ,U        4 \ 7     ; STOP BIT
          BEQ       FINISH    3 /       ; BRANCH IF FRAMING ERROR

WAIT1     BITA      ,U        4 \  7    ; TWO RAPID TESTS FOR NEXT START BIT
          BEQ       BSTART    3 /
WAIT2     BITA      ,U        4 \
          BEQ       BSTART    3  | 9
          SUBB      #1        2 /       ; DECREMENT TIMEOUT LSB
          BITA      ,U        4 \
          BEQ       BSTART    3  | 10
          BCC       WAIT2     3 /       ; LOOP UNTIL TIMEOUT LSB < 0

          BITA      ,U        4 \  7 
          BEQ       BSTART    3 /
          BITA      ,U        4 \
          BEQ       BSTART    3  | 10
          SUBF      #1        3 /       ; DECREMENT TIMEOUT MSB
          BITA      ,U        4 \
          BEQ       BSTART    3  | 10
          BCC       WAIT1     3 /       ; LOOP IF TIMEOUT NOT EXPIRED

FINISH    INCA                          ; IF FRAMING ERROR THEN A=1 ELSE A=2
          ORA       RCVSTA,S            ; SET CARRY BIT IN CC VALUE ON..
          STA       RCVSTA,S            ; ..THE STACK ONLY IF FRAMING ERROR
          TFR       Y,D                 ; CALCULATE ACTUAL NUMBER..
          SUBD      BUFBAS,S            ; ..OF BYTES RECEIVED
          LEAY      ,X                  ; RETURN CHECKSUM IN Y
          PULS      CC,X,U,PC           ; RESTORE REGISTERS AND RETURN

 ENDC


