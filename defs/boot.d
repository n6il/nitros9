;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; boot
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/05/17  Boisy G. Pitre
; Started.

           .title   Boot Definitions

           .area    BOOT (ABS)

           .ifgt  Level-1

;
; Boot defs for NitrOS-9 Level 1
;
; These defs are not strictly for 'Boot', but are for booting the
; system.
;
Bt.Start   ==     0hEE00     ; Start address of the boot track in memory
Bt.Size    ==     0h1080     ; Maximum size of bootfile

           .else

;
; Boot defs for NitrOS-9 Level 2 and above
;
; These defs are not strictly for 'Boot', but are for booting the
; system.
;
Bt.Block   ==     0h3B       ; Block to map in for the 'OS9BOOT' screen
Bt.Flag    ==     0h8A34     ; Flag in Bt.Block to verify that it's unchanged
Bt.Offst   ==     2          ; Offset into the screen where the current ptr is
Bt.Start   ==     0hED00     ; Start address of the boot track in memory

           .endif

Bt.Track   ==     34         ; Boot track


           .ifgt  Level-2
;
; Level 3 Defs
;
; These definitions apply to NitrOS-9 Level 3
;
L3.Start   ==     0h2000      ; Start off at slot 1
L3.Size    ==     0h40        ; Go for 64 pages: 2 slots total
L3.Blks    ==     L3.Size/0h20 ; Number of slots
L3.End     ==     L3.Start+L3.Size*0h0100 ; end of L3 memory
L3.SCF     ==     0h0660      ; SCF block ptr
L3.RBF     ==     L3.SCF+1    ; RBF block ptr
           .endif

           .endif
