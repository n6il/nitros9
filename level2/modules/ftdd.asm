         nam   FTDD
         ttl   VRN (VIRQ/RAM/Nil driver) device descriptor

         ifp1  
         use   defsfile
         endc  

Edtn     equ   1
Vrsn     equ   1

         mod   ModSize,DvcNam,Devic+Objct,ReEnt+Vrsn,MgrNam,DrvNam

         fcb   UPDAT.     access mode(s)
         fcb   $07        hardware page
         fdb   $FF01      hardware port
         fcb   OptSize
OptStart fcb   DT.SCF
OptSize  equ   *-OptStart
MgrNam   fcs   "SCF"
DrvNam   fcs   "VRN"
DvcNam   fcs   "FTDD"
         fcb   Edtn

         emod  
ModSize  equ   *
         end   
