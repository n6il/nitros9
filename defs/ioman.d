**************************************
* I/O Service Request Code Definitions
*
         org   $80
I$Attach rmb   1          Attach I/O Device
I$Detach rmb   1          Detach I/O Device
I$Dup    rmb   1          Duplicate Path
I$Create rmb   1          Create New File
I$Open   rmb   1          Open Existing File
I$MakDir rmb   1          Make Directory File
I$ChgDir rmb   1          Change Default Directory
I$Delete rmb   1          Delete File
I$Seek   rmb   1          Change Current Position
I$Read   rmb   1          Read Data
I$Write  rmb   1          Write Data
I$ReadLn rmb   1          Read Line of ASCII Data
I$WritLn rmb   1          Write Line of ASCII Data
I$GetStt rmb   1          Get Path Status
I$SetStt rmb   1          Set Path Status
I$Close  rmb   1          Close Path
I$DeletX rmb   1          Delete from current exec dir
