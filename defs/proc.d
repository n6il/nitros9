;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; proc - Process Descriptor Constants
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/05/17  Boisy G. Pitre
; Created.

           .title   Process Descriptor Constants

           .area    PROC (ABS)

           .ifndef  Level
Level      ==       1
           .endif

           .iflt    Level-2

; Level 1 process descriptor defs
DefIOSiz   ==     12
NumPaths   ==     16         ; Number of Local Paths

P$ID       ==     0h00          ; Process ID
P$PID      ==     0h01          ; Parent's ID
P$SID      ==     0h02          ; Sibling's ID
P$CID      ==     0h03          ; Child's ID
P$SP       ==     0h04          ; Stack ptr
P$CHAP     ==     0h06          ; process chapter number
P$ADDR     ==     0h07          ; user address beginning page number
P$PagCnt   ==     0h08          ; Memory Page Count
P$User     ==     0h09          ; User Index
P$Prior    ==     0h0B          ; Priority
P$Age      ==     0h0C          ; Age
P$State    ==     0h0D          ; Process State
P$Queue    ==     0h0E          ; Queue Link (Process ptr)
P$IOQP     ==     0h10          ; Previous I/O Queue Link (Process ID)
P$IOQN     ==     0h11          ; Next     I/O Queue Link (Process ID)
P$PModul   ==     0h12          ; Primary Module
P$SWI      ==     0h14          ; SWI Entry Point
P$SWI2     ==     0h16          ; SWI2 Entry Point
P$SWI3     ==     0h18          ; SWI3 Entry Point
P$DIO      ==     0h1A          ; default I/O ptrs
P$PATH     ==     P$DIO+DefIOSiz ; I/O path table
P$Signal   ==     P$PATH+NumPaths   ; Signal Code
P$SigVec   ==     P$Signal+2          ; Signal Intercept Vector
P$SigDat   ==     P$SigVec+22          ; Signal Intercept Data Address
P$NIO      ==     4          ; additional DIO pointers for net
                             ; unused
           .org   0h40
P$Size     ==     .          ; Size of Process Descriptor

;
; Process State Flags
;
SysState   ==     0b10000000
TimSleep   ==     0b01000000
TimOut     ==     0b00100000
ImgChg     ==     0b00010000
Condem     ==     0b00000010
Dead       ==     0b00000001

           .else

; Level 2 process descriptor defs
DefIOSiz   ==     16         ; Default I/O Data Length
NefIOSiz   ==     12         ; On-Net Default I/O Data Length
NumPaths   ==     16         ; Number of Local Paths

           .org   0
P$ID::     .rmb   1          ; Process ID
P$PID::    .rmb   1          ; Parent's ID
P$SID::    .rmb   1          ; Sibling's ID
P$CID::    .rmb   1          ; Child's ID
P$SP::     .rmb   2          ; Stack ptr
P$Task::   .rmb   1          ; Task Number
P$PagCnt:: .rmb   1          ; Memory Page Count
P$User::   .rmb   2          ; User Index
P$Prior::  .rmb   1          ; Priority
P$Age::    .rmb   1          ; Age
P$State::  .rmb   1          ; Status
P$Queue::  .rmb   2          ; Queue Link (Process ptr)
P$IOQP::   .rmb   1          ; Previous I/O Queue Link (Process ID)
P$IOQN::   .rmb   1          ; Next I/O Queue Link (Process ID)
P$PModul:: .rmb   2          ; Primary Module
P$SWI::    .rmb   2          ; SWI Entry Point
P$SWI2::   .rmb   2          ; SWI2 Entry Point
P$SWI3::   .rmb   2          ; SWI3 Entry Point
P$Signal:: .rmb   1          ; Signal Code
P$SigVec:: .rmb   2          ; Signal Intercept Vector
P$SigDat:: .rmb   2          ; Signal Intercept Data Address
P$DeadLk:: .rmb   1          ; Dominant proc ID if I/O locked
           .org   0h20
P$DIO::    .rmb   DefIOSiz   ; Default I/O ptrs
P$Path::   .rmb   NumPaths   ; I/O Path Table
P$DATImg:: .rmb   64         ; DAT Image
P$Links::  .rmb   32         ; Block Link counts
P$NIO::    .rmb   6*2        ; additional DIO ptrs for net, compatible  with 68k
P$SelP::   .rmb   1          ; Selected Path for COCO Windows (Default 0)
P$UTicks:: .rmb   4          ; proc User Tick counter        (L2V3)
P$STicks:: .rmb   4          ; proc System Tick counter      (L2V3)
P$FCalls:: .rmb   4          ; proc F$ call counter          (L2V3)
P$ICalls:: .rmb   4          ; proc I$ call counter          (L2V3)
P$DatBeg:: .rmb   3          ; proc Date of creation (Y/M/D) (L2V3)
P$TimBeg:: .rmb   3          ; proc Time of creation (H/M/S) (L2V3)
P$Alarm::  .rmb   6
                             ; Local stack
           .org   0h200
P$Stack    ==     .          ; Top of Stack
P$Size     ==     .          ; Size of Process Descriptor

;
; Process State Flags
;
SysState   ==     0b10000000
TimSleep   ==     0b01000000
TimOut     ==     0b00100000
ImgChg     ==     0b00010000
Suspend    ==     0b00001000
Condem     ==     0b00000010
Dead       ==     0b00000001

           .endif
