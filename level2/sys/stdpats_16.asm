********************************************************************
* StdPats_16 - Standard Patterns for 16 colors
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2003/11/26  Boisy G. Pitre
* Made into source form.

         nam   StdPats_16
         ttl   Standard Patterns for 16 colors


         org   0

pat1     fcb   $1B,$2B
         fcb   $CD		group #
         fcb   $01              buffer #
         fcb   $05              style 640x192x2
         fdb   $0020            xsize
         fdb   $0008            ysize
         fdb   $0080            bytes

         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
         fcb   $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
         fcb   $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
         fcb   $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
         fcb   $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F

pat2     fcb   $1B,$2B
         fcb   $CD		group #
         fcb   $02              buffer #
         fcb   $05              style 640x192x2
         fdb   $0020            xsize
         fdb   $0008            ysize
         fdb   $0080            bytes

         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0

pat3     fcb   $1B,$2B
         fcb   $CD		group #
         fcb   $03              buffer #
         fcb   $05              style 640x192x2
         fdb   $0020            xsize
         fdb   $0008            ysize
         fdb   $0080            bytes

         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $00,$00,$00,$00,$00,$00,$00,$00

pat4     fcb   $1B,$2B
         fcb   $CD		group #
         fcb   $04              buffer #
         fcb   $05              style 640x192x2
         fdb   $0020            xsize
         fdb   $0008            ysize
         fdb   $0080            bytes

         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
         fcb   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0

pat5     fcb   $1B,$2B
         fcb   $CD		group #
         fcb   $05              buffer #
         fcb   $05              style 640x192x2
         fdb   $0020            xsize
         fdb   $0008            ysize
         fdb   $0080            bytes

         fcb   $0F,$00,$0F,$00,$0F,$00,$0F,$00
         fcb   $0F,$00,$0F,$00,$0F,$00,$0F,$00
         fcb   $F0,$00,$F0,$00,$F0,$00,$F0,$00
         fcb   $F0,$00,$F0,$00,$F0,$00,$F0,$00
         fcb   $00,$0F,$00,$0F,$00,$0F,$00,$0F
         fcb   $00,$0F,$00,$0F,$00,$0F,$00,$0F
         fcb   $00,$F0,$00,$F0,$00,$F0,$00,$F0
         fcb   $00,$F0,$00,$F0,$00,$F0,$00,$F0
         fcb   $0F,$00,$0F,$00,$0F,$00,$0F,$00
         fcb   $0F,$00,$0F,$00,$0F,$00,$0F,$00
         fcb   $F0,$00,$F0,$00,$F0,$00,$F0,$00
         fcb   $F0,$00,$F0,$00,$F0,$00,$F0,$00
         fcb   $00,$0F,$00,$0F,$00,$0F,$00,$0F
         fcb   $00,$0F,$00,$0F,$00,$0F,$00,$0F
         fcb   $00,$F0,$00,$F0,$00,$F0,$00,$F0
         fcb   $00,$F0,$00,$F0,$00,$F0,$00,$F0

pat6     fcb   $1B,$2B
         fcb   $CD		group #
         fcb   $06              buffer #
         fcb   $05              style 640x192x2
         fdb   $0020            xsize
         fdb   $0008            ysize
         fdb   $0080            bytes

         fcb   $00,$F0,$00,$F0,$00,$F0,$00,$F0
         fcb   $00,$F0,$00,$F0,$00,$F0,$00,$F0
         fcb   $00,$0F,$00,$0F,$00,$0F,$00,$0F
         fcb   $00,$0F,$00,$0F,$00,$0F,$00,$0F
         fcb   $F0,$00,$F0,$00,$F0,$00,$F0,$00
         fcb   $F0,$00,$F0,$00,$F0,$00,$F0,$00
         fcb   $0F,$00,$0F,$00,$0F,$00,$0F,$00
         fcb   $0F,$00,$0F,$00,$0F,$00,$0F,$00
         fcb   $00,$F0,$00,$F0,$00,$F0,$00,$F0
         fcb   $00,$F0,$00,$F0,$00,$F0,$00,$F0
         fcb   $00,$0F,$00,$0F,$00,$0F,$00,$0F
         fcb   $00,$0F,$00,$0F,$00,$0F,$00,$0F
         fcb   $F0,$00,$F0,$00,$F0,$00,$F0,$00
         fcb   $F0,$00,$F0,$00,$F0,$00,$F0,$00
         fcb   $0F,$00,$0F,$00,$0F,$00,$0F,$00
         fcb   $0F,$00,$0F,$00,$0F,$00,$0F,$00

pat7     fcb   $1B,$2B
         fcb   $CD		group #
         fcb   $07              buffer #
         fcb   $05              style 640x192x2
         fdb   $0020            xsize
         fdb   $0008            ysize
         fdb   $0080            bytes

         fcb   $F0,$00,$F0,$00,$F0,$00,$F0,$00
         fcb   $F0,$00,$F0,$00,$F0,$00,$F0,$00
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $00,$F0,$00,$F0,$00,$F0,$00,$F0
         fcb   $00,$F0,$00,$F0,$00,$F0,$00,$F0
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $F0,$00,$F0,$00,$F0,$00,$F0,$00
         fcb   $F0,$00,$F0,$00,$F0,$00,$F0,$00
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $00,$F0,$00,$F0,$00,$F0,$00,$F0
         fcb   $00,$F0,$00,$F0,$00,$F0,$00,$F0
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $00,$00,$00,$00,$00,$00,$00,$00

pat8     fcb   $1B,$2B
         fcb   $CD		group #
         fcb   $08              buffer #
         fcb   $05              style 640x192x2
         fdb   $0020            xsize
         fdb   $0008            ysize
         fdb   $0080            bytes

         fcb   $0F,$F0,$0F,$F0,$0F,$F0,$0F,$F0
         fcb   $0F,$F0,$0F,$F0,$0F,$F0,$0F,$F0
         fcb   $F0,$0F,$F0,$0F,$F0,$0F,$F0,$0F
         fcb   $F0,$0F,$F0,$0F,$F0,$0F,$F0,$0F
         fcb   $F0,$0F,$F0,$0F,$F0,$0F,$F0,$0F
         fcb   $F0,$0F,$F0,$0F,$F0,$0F,$F0,$0F
         fcb   $0F,$F0,$0F,$F0,$0F,$F0,$0F,$F0
         fcb   $0F,$F0,$0F,$F0,$0F,$F0,$0F,$F0
         fcb   $0F,$F0,$0F,$F0,$0F,$F0,$0F,$F0
         fcb   $0F,$F0,$0F,$F0,$0F,$F0,$0F,$F0
         fcb   $F0,$0F,$F0,$0F,$F0,$0F,$F0,$0F
         fcb   $F0,$0F,$F0,$0F,$F0,$0F,$F0,$0F
         fcb   $F0,$0F,$F0,$0F,$F0,$0F,$F0,$0F
         fcb   $F0,$0F,$F0,$0F,$F0,$0F,$F0,$0F
         fcb   $0F,$F0,$0F,$F0,$0F,$F0,$0F,$F0
         fcb   $0F,$F0,$0F,$F0,$0F,$F0,$0F,$F0
