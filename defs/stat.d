;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; stat - GetStat/SetStat Code Definitions
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/07/02  Boisy G. Pitre
; Created.

           .title   GetStat/SetStat Code Definitions

           .area    STAT (ABS)

           .ifndef  Level
Level      ==       1
           .endif

           .org    0

SS.Opt::   .byte   1          ; Read/Write PD Options
SS.Ready:: .byte   1          ; Check for Device Ready
SS.Size::  .byte   1          ; Read/Write File Size
SS.Reset:: .byte   1          ; Device Restore
SS.WTrk::  .byte   1          ; Device Write Track
SS.Pos::   .byte   1          ; Get File Current Position
SS.EOF::   .byte   1          ; Test for End of File
SS.Link::  .byte   1          ; Link to Status routines
SS.ULink:: .byte   1          ; Unlink Status routines
SS.Feed::  .byte   1          ; issue form feed
SS.Frz::   .byte   1          ; Freeze DD. information
SS.SPT::   .byte   1          ; Set DD.TKS to given value
SS.SQD::   .byte   1          ; S  ==   ence down hard disk
SS.DCmd::  .byte   1          ; Send direct command to disk
SS.DevNm:: .byte   1          ; Return Device name (32-bytes at [X])
SS.FD::    .byte   1          ; Return File Descriptor (Y-bytes at [X])
SS.Ticks:: .byte   1          ; Set Lockout honor duration
SS.Lock::  .byte   1          ; Lock/Release record
SS.DStat:: .byte   1          ; Return Display Status (CoCo)
SS.Joy::   .byte   1          ; Return Joystick Value (CoCo)
SS.BlkRd:: .byte   1          ; Block Read
SS.BlkWr:: .byte   1          ; Block Write
SS.Reten:: .byte   1          ; Retension cycle
SS.WFM::   .byte   1          ; Write File Mark
SS.RFM::   .byte   1          ; Read past File Mark
SS.ELog::  .byte   1          ; Read Error Log
SS.SSig::  .byte   1          ; Send signal on data ready
SS.Relea:: .byte   1          ; Release device
SS.AlfaS:: .byte   1          ; Return Alfa Display Status (CoCo, SCF/GetStat)
SS.Attr     ==     SS.AlfaS   ; to serve 68K/RBF/SetStat only, thru NET
SS.Break:: .byte   1          ; Send break signal out acia
SS.RsBit:: .byte   1          ; Reserve bitmap sector (do not allocate in) LSB(X)=sct#
           .byte   1          ; reserved
SS.FDInf    ==     0h20        ; to serve 68K/RBF/GetStat only, thru NET
           .byte   4          ; reserve $20-$23 for Japanese version (Hoshi)
SS.SetMF:: .byte   1          ; reserve $24 for Gimix G68 (Flex compatability?)
SS.Cursr:: .byte   1          ; Cursor information for COCO
SS.ScSiz:: .byte   1          ; Return screen size for COCO
SS.KySns:: .byte   1          ; Getstat/SetStat for COCO keyboard
SS.ComSt:: .byte   1          ; Getstat/SetStat for Baud/Parity
SS.Open::  .byte   1          ; SetStat to tell driver a path was opened
SS.Close:: .byte   1          ; SetStat to tell driver a path was closed
SS.HngUp:: .byte   1          ; SetStat to tell driver to hangup phone
SS.FSig::  .byte   1          ; new signal for temp locked files
SS.DSize   ==      SS.ScSiz   ; Return disk size (RBF GetStat)
SS.VarSect ==      SS.DStat   ; Variable Sector Size (RBF GetStat)

; System Specific and User defined codes above $80

           .org    0h80

SS.AAGBf:: .byte   1          ; SetStat to Allocate Additional Graphic Buffer
SS.SLGBf:: .byte   1          ; SetStat to Select a different Graphic Buffer
SS.Mount:: .byte   1          ; Network 4 Mount Setstat
SS.RdNet:: .byte   1          ; Read Raw Sector from Network 4 Omnidrive
SS.MpGPB:: .byte   1          ; SetStat to r  ==   est a Get/Put Buffer be mapped in workspace
SS.Slots:: .byte   1          ; Network 4 slots? getstat

           .ifgt   Level-1

; Level 2 Windowing
SS.WnSet:: .byte   1          ; Set up High Level Windowing Information
SS.MnSel:: .byte   1          ; R  ==   est High level Menu Handler take determine next event
SS.SBar::  .byte   1          ; SetStat to set position block on Window scroll bars
SS.Mouse:: .byte   1          ; Return Mouse information packet (COCO)
SS.MsSig:: .byte   1          ; SetStat to tell driver to send signal on mouse event
SS.AScrn:: .byte   1          ; Allocate a screen for application poking
SS.DScrn:: .byte   1          ; Display a screen allocated by SS.AScrn
SS.FScrn:: .byte   1          ; Free a screen allocated by SS.AScrn
SS.PScrn:: .byte   1          ; Polymorph Screen into different screen type
SS.ScInf:: .byte   1          ; Get Current screen info for direct writes
           .byte   1          ; Reserved
SS.Palet:: .byte   1          ; Return palette information
SS.Montr:: .byte   1          ; Get and Set Monitor Type
SS.ScTyp:: .byte   1          ; Get screen type information
SS.GIP::   .byte   1          ; Global Input Parameters (SetStat)
SS.UMBar:: .byte   1          ; update menu bar (SetStat)
SS.FBRgs:: .byte   1          ; return color registers (GetStat)
SS.DfPal:: .byte   1          ; set/return default palette registers (Getstat/Setstat)
SS.Tone::  .byte   1          ; Generate a tone using 6 bit sound
SS.GIP2::  .byte   1          ; Global Input Params #2 (L2V3)
SS.AnPal:: .byte   1          ; Animate palettes (L2V3)
SS.FndBf:: .byte   1          ; Find named buffer (L2V3)

; sc6551 defined
SS.CDSta   ==      SS.GIP2
SS.CDSig   ==      SS.AnPal
SS.CDRel   ==      SS.FndBf
         
           .else

; These are wide open in Level 1
           .byte    19

; sc6551 defined
SS.CDSta:: .byte    1
SS.CDSig:: .byte    1
SS.CDRel:: .byte    1

           .endif


           .org     0hA0

; New Default SCF input buffer Set status call
SS.Fill::  .byte    1          ; Pre-load SCF device input buffer
SS.Hist::  .byte    1          ; Enable command-line history easily


           .org     0hB0

; New WDDisk get/set status calls
SS.ECC::   .byte    1          ; ECC corrected data error enable/disable (GetStat/SetStat)

           .ifgt    Level-1

; VRN get/set status calls.  Named by Alan DeKok.
SS.VCtr    ==       0h80         ; Return FS2 total VIRQ counter
SS.VSig    ==       0h81         ; Return FS2 number of signals sent

SS.FClr    ==       0h81         ; Set/clear FS2 VIRQ
SS.FSet    ==       0hC7         ; Set FS2+ VIRQ
SS.KSet    ==       0hC8         ; Set KQ3 VIRQ
SS.KClr    ==       0hC9         ; Clr KQ3 VIRQ
SS.ARAM    ==       0hCA         ; Allocate RAM blocks
SS.DRAM    ==       0hCB         ; De-allocate RAM blocks

; SDisk 3 Definition equates
SS.DRead   ==      SS.AAGBf     ; SDisk3 Direct Sector Read ($80)
SS.DWrit   ==      SS.DRead     ; SDisk3 Direct sector Write ($80)
SS.UnFrz   ==      SS.SLGBf     ; SDisk3 UNFreeze DD info ($81)
SS.MOFF    ==      SS.Mount     ; SDisk3 fast motor off call ($82)
SS.MoTim   ==      SS.RdNet     ; SDisk3 Set motor shut off time ($83)
SS.SDRD    ==      SS.MpGPB     ; SDisk3 System direct read ($84)
SS.SDWRT   ==      SS.SDRD      ; SDisk3 System direct writes ($84)
SS.Sleep   ==      SS.Slots     ; SDisk3 (DMC ONLY) Enable/disable F$Sleep calls in read/write 1773 I/O ($85)
SS.DrvCh   ==      SS.WnSet     ; SDisk3 (DMC ONLY) Set drive number to cache, or return drive number being cached ($86)

           .endif

