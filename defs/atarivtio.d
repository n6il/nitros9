               IFNE      VTIODEFS-1
VTIODEFS       SET       1

********************************************************************
* VTIODefs - Video Terminal I/O Definitions for Atari XE/XL
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2012/02/21  Boisy G. Pitre
* Started

               NAM       VTIODefs  
               TTL       Video Terminal I/O Definitions for Atari XE/XL

               USE       antic.d
               
********************
* VTIO Definitions
*
ScrStart       EQU       $0500
Cols           EQU       40
Rows           EQU       24

********************
* VTIO Static Memory
*
               ORG       V.SCF
V.CurRow       RMB       1
V.CurCol       RMB       1
V.KySns        RMB       1                   key sense flags
V.IBufH        RMB       1                   input buffer head
V.IBufT        RMB       1                   input buffer tail
V.InBuf        RMB       1                   input buffer ptr
               RMB       250-.
V.Last         EQU       .

               ENDC      
