;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; errno
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/07/02  Boisy G. Pitre
; Started

           .title   NitrOS-9 Error Definitions

           .area    ERRNO (ABS)

;
; Basic09 Error Codes
;
           .org   10
E$UnkSym:: .rmb   1          ; Unknown symbol
E$ExcVrb:: .rmb   1          ; Excessive verbage
E$IllStC:: .rmb   1          ; Illegal statement construction
E$ICOvf::  .rmb   1          ; I-code overflow
E$IChRef:: .rmb   1          ; Illegal channel reference
E$IllMod:: .rmb   1          ; Illegal mode
E$IllNum:: .rmb   1          ; Illegal number
E$IllPrf:: .rmb   1          ; Illegal prefix
E$IllOpd:: .rmb   1          ; Illegal operand
E$IllOpr:: .rmb   1          ; Illegal operator
E$IllRFN:: .rmb   1          ; Illegal record field name
E$IllDim:: .rmb   1          ; Illegal dimension
E$IllLit:: .rmb   1          ; Illegal literal
E$IllRet:: .rmb   1          ; Illegal relational
E$IllSfx:: .rmb   1          ; Illegal type suffix
E$DimLrg:: .rmb   1          ; Dimension too large
E$LinLrg:: .rmb   1          ; Line number too large
E$NoAssg:: .rmb   1          ; Missing assignment statement
E$NoPath:: .rmb   1          ; Missing path number
E$NoComa:: .rmb   1          ; Missing coma
E$NoDim::  .rmb   1          ; Missing dimension
E$NoDO::   .rmb   1          ; Missing DO statement
E$MFull::  .rmb   1          ; Memory full
E$NoGoto:: .rmb   1          ; Missing GOTO
E$NoLPar:: .rmb   1          ; Missing left parenthesis
E$NoLRef:: .rmb   1          ; Missing line reference
E$NoOprd:: .rmb   1          ; Missing operand
E$NoRPar:: .rmb   1          ; Missing right parenthesis
E$NoTHEN:: .rmb   1          ; Missing THEN statement
E$NoTO::   .rmb   1          ; Missing TO statement
E$NoVRef:: .rmb   1          ; Missing variable reference
E$EndQou:: .rmb   1          ; Missing end quote
E$SubLrg:: .rmb   1          ; Too many subscripts
E$UnkPrc:: .rmb   1          ; Unknown procedure
E$MulPrc:: .rmb   1          ; Multiply defined procedure
E$DivZer:: .rmb   1          ; Divice by zero
E$TypMis:: .rmb   1          ; Operand type mismatch
E$StrOvf:: .rmb   1          ; String stack overflow
E$NoRout:: .rmb   1          ; Unimplemented routine
E$UndVar:: .rmb   1          ; Undefined variable
E$FltOvf:: .rmb   1          ; Floating Overflow
E$LnComp:: .rmb   1          ; Line with compiler error
E$ValRng:: .rmb   1          ; Value out of range for destination
E$SubOvf:: .rmb   1          ; Subroutine stack overflow
E$SubUnd:: .rmb   1          ; Subroutine stack underflow
E$SubRng:: .rmb   1          ; Subscript out of range
E$ParmEr:: .rmb   1          ; Parameter error
E$SysOvf:: .rmb   1          ; System stack overflow
E$IOMism:: .rmb   1          ; I/O type mismatch
E$IONum::  .rmb   1          ; I/O numeric input format bad
E$IOConv:: .rmb   1          ; I/O conversion: number out of range
E$IllInp:: .rmb   1          ; Illegal input format
E$IOFRpt:: .rmb   1          ; I/O format repeat error
E$IOFSyn:: .rmb   1          ; I/O format syntax error
E$IllPNm:: .rmb   1          ; Illegal path number
E$WrSub::  .rmb   1          ; Wrong number of subscripts
E$NonRcO:: .rmb   1          ; Non-record type operand
E$IllA::   .rmb   1          ; Illegal argument
E$IllCnt:: .rmb   1          ; Illegal control structure
E$UnmCnt:: .rmb   1          ; Unmatched control structure
E$IllFOR:: .rmb   1          ; Illegal FOR variable
E$IllExp:: .rmb   1          ; Illegal expression type
E$IllDec:: .rmb   1          ; Illegal declarative statement
E$ArrOvf:: .rmb   1          ; Array size overflow
E$UndLin:: .rmb   1          ; Undefined line number
E$MltLin:: .rmb   1          ; Multiply defined line number
E$MltVar:: .rmb   1          ; Multiply defined variable
E$IllIVr:: .rmb   1          ; Illegal input variable
E$SeekRg:: .rmb   1          ; Seek out of range
E$NoData:: .rmb   1          ; Missing data statement

;
; System Dependent Error Codes
;

; Level 2 windowing error codes
           .org   183
E$IWTyp::  .rmb   1          ; Illegal window type
E$WADef::  .rmb   1          ; Window already defined
E$NFont::  .rmb   1          ; Font not found
E$StkOvf:: .rmb   1          ; Stack overflow
E$IllArg:: .rmb   1          ; Illegal argument
           .rmb   1          ; reserved
E$ICoord:: .rmb   1          ; Illegal coordinates
E$Bug::    .rmb   1          ; Bug (should never be returned)
E$BufSiz:: .rmb   1          ; Buffer size is too small
E$IllCmd:: .rmb   1          ; Illegal command
E$TblFul:: .rmb   1          ; Screen or window table is full
E$BadBuf:: .rmb   1          ; Bad/Undefined buffer number
E$IWDef::  .rmb   1          ; Illegal window definition
E$WUndef:: .rmb   1          ; Window undefined

E$Up::     .rmb   1          ; Up arrow pressed on SCF I$ReadLn with PD.UP enabled
E$Dn::     .rmb   1          ; Down arrow pressed on SCF I$ReadLn with PD.DOWN enabled
E$Alias::  .rmb   1


;
; Standard NitrOS-9 Error Codes
;
           .org   200
E$PthFul:: .rmb   1          ; Path Table full
E$BPNum::  .rmb   1          ; Bad Path Number
E$Poll::   .rmb   1          ; Polling Table Full
E$BMode::  .rmb   1          ; Bad Mode
E$DevOvf:: .rmb   1          ; Device Table Overflow
E$BMID::   .rmb   1          ; Bad Module ID
E$DirFul:: .rmb   1          ; Module Directory Full
E$MemFul:: .rmb   1          ; Process Memory Full
E$UnkSvc:: .rmb   1          ; Unknown Service Code
E$ModBsy:: .rmb   1          ; Module Busy
E$BPAddr:: .rmb   1          ; Bad Page Address
E$EOF::    .rmb   1          ; End of File
           .rmb   1
E$NES::    .rmb   1          ; Non-Existing Segment
E$FNA::    .rmb   1          ; File Not Accesible
E$BPNam::  .rmb   1          ; Bad Path Name
E$PNNF::   .rmb   1          ; Path Name Not Found
E$SLF::    .rmb   1          ; Segment List Full
E$CEF::    .rmb   1          ; Creating Existing File
E$IBA::    .rmb   1          ; Illegal Block Address
E$HangUp:: .rmb   1          ; Carrier Detect Lost
E$MNF::    .rmb   1          ; Module Not Found
           .rmb   1
E$DelSP::  .rmb   1          ; Deleting Stack Pointer memory
E$IPrcID:: .rmb   1          ; Illegal Process ID
E$BPrcID   ==     E$IPrcID   ; Bad Process ID (formerly #238)
           .rmb   1
E$NoChld:: .rmb   1          ; No Children
E$ISWI::   .rmb   1          ; Illegal SWI code
E$PrcAbt:: .rmb   1          ; Process Aborted
E$PrcFul:: .rmb   1          ; Process Table Full
E$IForkP:: .rmb   1          ; Illegal Fork Parameter
E$KwnMod:: .rmb   1          ; Known Module
E$BMCRC::  .rmb   1          ; Bad Module CRC
E$USigP::  .rmb   1          ; Unprocessed Signal Pending
E$NEMod::  .rmb   1          ; Non Existing Module
E$BNam::   .rmb   1          ; Bad Name
E$BMHP::   .rmb   1          ; (bad module header parity)
E$NoRAM::  .rmb   1          ; No (System) RAM Available
E$DNE::    .rmb   1          ; Directory not empty
E$NoTask:: .rmb   1          ; No available Task number
;           .rmb   0hF0-.     ; reserved
           .org   0hF0
E$Unit::   .rmb   1          ; Illegal Unit (drive)
E$Sect::   .rmb   1          ; Bad Sector number
E$WP::     .rmb   1          ; Write Protect
E$CRC::    .rmb   1          ; Bad Check Sum
E$Read::   .rmb   1          ; Read Error
E$Write::  .rmb   1          ; Write Error
E$NotRdy:: .rmb   1          ; Device Not Ready
E$Seek::   .rmb   1          ; Seek Error
E$Full::   .rmb   1          ; Media Full
E$BTyp::   .rmb   1          ; Bad Type (incompatable) media
E$DevBsy:: .rmb   1          ; Device Busy
E$DIDC::   .rmb   1          ; Disk ID Change
E$Lock::   .rmb   1          ; Record is busy (locked out)
E$Share::  .rmb   1          ; Non-sharable file busy
E$DeadLk:: .rmb   1          ; I/O Deadlock error

