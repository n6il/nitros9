;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; io.d - I/O Service Request Code Definitions
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/07/02  Boisy G. Pitre
; Created.

I$Attach ==   0h80          ; Attach I/O Device
I$Detach ==   0h81          ; Detach I/O Device
I$Dup    ==   0h82          ; Duplicate Path
I$Create ==   0h83          ; Create New File
I$Open   ==   0h84          ; Open Existing File
I$MakDir ==   0h85          ; Make Directory File
I$ChgDir ==   0h86          ; Change Default Directory
I$Delete ==   0h87          ; Delete File
I$Seek   ==   0h88          ; Change Current Position
I$Read   ==   0h89          ; Read Data
I$Write  ==   0h8A          ; Write Data
I$ReadLn ==   0h8B          ; Read Line of ASCII Data
I$WritLn ==   0h8C          ; Write Line of ASCII Data
I$GetStt ==   0h8D          ; Get Path Status
I$SetStt ==   0h8E          ; Set Path Status
I$Close  ==   0h8F          ; Close Path
I$DeletX ==   0h90          ; Delete from current exec dir
