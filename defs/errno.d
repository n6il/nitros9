;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; errno - NitrOS-9 Error Definitions
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/07/02  Boisy G. Pitre
; Created.

           .title   NitrOS-9 Error Definitions

           .ifndef  Level
Level      ==       1
           .endif

;
; Basic09 Error Codes
;

E$UnkSym   ==       10         ; Unknown symbol
E$ExcVrb   ==       11         ; Excessive verbage
E$IllStC   ==       12         ; Illegal statement construction
E$ICOvf    ==       13         ; I-code overflow
E$IChRef   ==       14         ; Illegal channel reference
E$IllMod   ==       15         ; Illegal mode
E$IllNum   ==       16         ; Illegal number
E$IllPrf   ==       17         ; Illegal prefix
E$IllOpd   ==       18         ; Illegal operand
E$IllOpr   ==       19         ; Illegal operator
E$IllRFN   ==       20         ; Illegal record field name
E$IllDim   ==       21         ; Illegal dimension
E$IllLit   ==       22         ; Illegal literal
E$IllRet   ==       23         ; Illegal relational
E$IllSfx   ==       24         ; Illegal type suffix
E$DimLrg   ==       25         ; Dimension too large
E$LinLrg   ==       26         ; Line number too large
E$NoAssg   ==       27         ; Missing assignment statement
E$NoPath   ==       28         ; Missing path number
E$NoComa   ==       29         ; Missing coma
E$NoDim    ==       30         ; Missing dimension
E$NoDO     ==       31         ; Missing DO statement
E$MFull    ==       32         ; Memory full
E$NoGoto   ==       33         ; Missing GOTO
E$NoLPar   ==       34         ; Missing left parenthesis
E$NoLRef   ==       35         ; Missing line reference
E$NoOprd   ==       36         ; Missing operand
E$NoRPar   ==       36         ; Missing right parenthesis
E$NoTHEN   ==       38         ; Missing THEN statement
E$NoTO     ==       39         ; Missing TO statement
E$NoVRef   ==       40         ; Missing variable reference
E$EndQou   ==       41         ; Missing end quote
E$SubLrg   ==       42         ; Too many subscripts
E$UnkPrc   ==       43         ; Unknown procedure
E$MulPrc   ==       44         ; Multiply defined procedure
E$DivZer   ==       45         ; Divice by zero
E$TypMis   ==       46         ; Operand type mismatch
E$StrOvf   ==       46         ; String stack overflow
E$NoRout   ==       48         ; Unimplemented routine
E$UndVar   ==       49         ; Undefined variable
E$FltOvf   ==       50         ; Floating Overflow
E$LnComp   ==       51         ; Line with compiler error
E$ValRng   ==       52         ; Value out of range for destination
E$SubOvf   ==       53         ; Subroutine stack overflow
E$SubUnd   ==       54         ; Subroutine stack underflow
E$SubRng   ==       55         ; Subscript out of range
E$ParmEr   ==       56         ; Parameter error
E$SysOvf   ==       57         ; System stack overflow
E$IOMism   ==       58         ; I/O type mismatch
E$IONum    ==       59         ; I/O numeric input format bad
E$IOConv   ==       60         ; I/O conversion: number out of range
E$IllInp   ==       61         ; Illegal input format
E$IOFRpt   ==       62         ; I/O format repeat error
E$IOFSyn   ==       63         ; I/O format syntax error
E$IllPNm   ==       64         ; Illegal path number
E$WrSub    ==       65         ; Wrong number of subscripts
E$NonRcO   ==       66         ; Non-record type operand
E$IllA     ==       67         ; Illegal argument
E$IllCnt   ==       68         ; Illegal control structure
E$UnmCnt   ==       69         ; Unmatched control structure
E$IllFOR   ==       70         ; Illegal FOR variable
E$IllExp   ==       71         ; Illegal expression type
E$IllDec   ==       72         ; Illegal declarative statement
E$ArrOvf   ==       73         ; Array size overflow
E$UndLin   ==       74         ; Undefined line number
E$MltLin   ==       75         ; Multiply defined line number
E$MltVar   ==       76         ; Multiply defined variable
E$IllIVr   ==       77         ; Illegal input variable
E$SeekRg   ==       78         ; Seek out of range
E$NoData   ==       79         ; Missing data statement

;
; System Dependent Error Codes
;

; Level 2 windowing error codes

E$IWTyp    ==       183        ; Illegal window type
E$WADef    ==       184        ; Window already defined
E$NFont    ==       185        ; Font not found
E$StkOvf   ==       186        ; Stack overflow
E$IllArg   ==       187        ; Illegal argument
; 188 is reserved
E$ICoord   ==       189        ; Illegal coordinates
E$Bug      ==       190        ; Bug (should never be returned)
E$BufSiz   ==       191        ; Buffer size is too small
E$IllCmd   ==       192        ; Illegal command
E$TblFul   ==       193        ; Screen or window table is full
E$BadBuf   ==       194        ; Bad/Undefined buffer number
E$IWDef    ==       195        ; Illegal window definition
E$WUndef   ==       196        ; Window undefined

E$Up       ==       197        ; Up arrow pressed on SCF I$ReadLn with PD.UP enabled
E$Dn       ==       198        ; Down arrow pressed on SCF I$ReadLn with PD.DOWN enabled
E$Alias    ==       199


;
; Standard NitrOS-9 Error Codes
;
E$PthFul   ==       200        ; Path Table full
E$BPNum    ==       201        ; Bad Path Number
E$Poll     ==       202        ; Polling Table Full
E$BMode    ==       203        ; Bad Mode
E$DevOvf   ==       204        ; Device Table Overflow
E$BMID     ==       205        ; Bad Module ID
E$DirFul   ==       206        ; Module Directory Full
E$MemFul   ==       207        ; Process Memory Full
E$UnkSvc   ==       208        ; Unknown Service Code
E$ModBsy   ==       209        ; Module Busy
E$BPAddr   ==       210        ; Bad Page Address
E$EOF      ==       211        ; End of File
E$NES      ==       213        ; Non-Existing Segment
E$FNA      ==       214        ; File Not Accesible
E$BPNam    ==       215        ; Bad Path Name
E$PNNF     ==       216        ; Path Name Not Found
E$SLF      ==       217        ; Segment List Full
E$CEF      ==       218        ; Creating Existing File
E$IBA      ==       219        ; Illegal Block Address
E$HangUp   ==       220        ; Carrier Detect Lost
E$MNF      ==       221        ; Module Not Found
E$DelSP    ==       223        ; Deleting Stack Pointer memory
E$IPrcID   ==       224        ; Illegal Process ID
E$BPrcID   ==       E$IPrcID   ; Bad Process ID (formerly #238)
; 225 is reserved
E$NoChld   ==       226        ; No Children
E$ISWI     ==       227        ; Illegal SWI code
E$PrcAbt   ==       228        ; Process Aborted
E$PrcFul   ==       229        ; Process Table Full
E$IForkP   ==       230        ; Illegal Fork Parameter
E$KwnMod   ==       231        ; Known Module
E$BMCRC    ==       232        ; Bad Module CRC
E$USigP    ==       233        ; Unprocessed Signal Pending
E$NEMod    ==       234        ; Non Existing Module
E$BNam     ==       235        ; Bad Name
E$BMHP     ==       236        ; (bad module header parity)
E$NoRAM    ==       237        ; No (System) RAM Available
E$DNE      ==       238        ; Directory not empty
E$NoTask   ==       239        ; No available Task number
E$Unit     ==       240        ; Illegal Unit (drive)
E$Sect     ==       241        ; Bad Sector number
E$WP       ==       242        ; Write Protect
E$CRC      ==       243        ; Bad Check Sum
E$Read     ==       244        ; Read Error
E$Write    ==       245        ; Write Error
E$NotRdy   ==       246        ; Device Not Ready
E$Seek     ==       247        ; Seek Error
E$Full     ==       248        ; Media Full
E$BTyp     ==       249        ; Bad Type (incompatable) media
E$DevBsy   ==       250        ; Device Busy
E$DIDC     ==       251        ; Disk ID Change
E$Lock     ==       252        ; Record is busy (locked out)
E$Share    ==       253        ; Non-sharable file busy
E$DeadLk   ==       254        ; I/O Deadlock error
