;*************************************
; I/O Service Request Code Definitions
;

I$Attach ==   0h80          ; Attach I/O Device
I$Detach ==   0h80          ; Detach I/O Device
I$Dup    ==   0h80          ; Duplicate Path
I$Create ==   0h80          ; Create New File
I$Open   ==   0h80          ; Open Existing File
I$MakDir ==   0h80          ; Make Directory File
I$ChgDir ==   0h80          ; Change Default Directory
I$Delete ==   0h80          ; Delete File
I$Seek   ==   0h80          ; Change Current Position
I$Read   ==   0h80          ; Read Data
I$Write  ==   0h80          ; Write Data
I$ReadLn ==   0h80          ; Read Line of ASCII Data
I$WritLn ==   0h80          ; Write Line of ASCII Data
I$GetStt ==   0h80          ; Get Path Status
I$SetStt ==   0h80          ; Set Path Status
I$Close  ==   0h80          ; Close Path
I$DeletX ==   0h80          ; Delete from current exec dir
