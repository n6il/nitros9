********************************************************************
* StdPats_4 - Standard Patterns for 4 colors
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2003/11/26  Boisy G. Pitre
* Made into source form.

         nam   StdPats_4
         ttl   Standard Patterns for 4 colors


         org   0

L0000    fcb   $1B,$2B,$CC
         fcb   $01              buffer #
         fcb   $05              style 640x192x2
         fdb   $0020            xsize
         fdb   $0008            ysize
         fdb   $0040            bytes


L0008    fcb   $CC,$CC,$CC,$CC,$CC   ..@LLLLL
L0010    fcb   $CC,$CC,$CC,$33,$33,$33,$33,$33   LLL33333
L0018    fcb   $33,$33,$33,$CC,$CC,$CC,$CC,$CC   333LLLLL
L0020    fcb   $CC,$CC,$CC,$33,$33,$33,$33,$33   LLL33333
L0028    fcb   $33,$33,$33,$CC,$CC,$CC,$CC,$CC   333LLLLL
L0030    fcb   $CC,$CC,$CC,$33,$33,$33,$33,$33   LLL33333
L0038    fcb   $33,$33,$33,$CC,$CC,$CC,$CC,$CC   333LLLLL
L0040    fcb   $CC,$CC,$CC,$33,$33,$33,$33,$33   LLL33333
L0048    fcb   $33,$33,$33,$1B,$2B,$CC,$02,$05   333.+L..
L0050    fcb   $00,$20,$00,$08,$00,$40,$CC,$CC   . ...@LL
L0058    fcb   $CC,$CC,$CC,$CC,$CC,$CC,$CC,$CC   LLLLLLLL
L0060    fcb   $CC,$CC,$CC,$CC,$CC,$CC,$CC,$CC   LLLLLLLL
L0068    fcb   $CC,$CC,$CC,$CC,$CC,$CC,$CC,$CC   LLLLLLLL
L0070    fcb   $CC,$CC,$CC,$CC,$CC,$CC,$CC,$CC   LLLLLLLL
L0078    fcb   $CC,$CC,$CC,$CC,$CC,$CC,$CC,$CC   LLLLLLLL
L0080    fcb   $CC,$CC,$CC,$CC,$CC,$CC,$CC,$CC   LLLLLLLL
L0088    fcb   $CC,$CC,$CC,$CC,$CC,$CC,$CC,$CC   LLLLLLLL
L0090    fcb   $CC,$CC,$CC,$CC,$CC,$CC,$1B,$2B   LLLLLL.+
L0098    fcb   $CC,$03,$05,$00,$20,$00,$08,$00   L... ...
L00A0    fcb   $40,$FF,$FF,$FF,$FF,$FF,$FF,$FF   @.......
L00A8    fcb   $FF,$00,$00,$00,$00,$00,$00,$00   ........
L00B0    fcb   $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF   ........
L00B8    fcb   $FF,$00,$00,$00,$00,$00,$00,$00   ........
L00C0    fcb   $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF   ........
L00C8    fcb   $FF,$00,$00,$00,$00,$00,$00,$00   ........
L00D0    fcb   $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF   ........
L00D8    fcb   $FF,$00,$00,$00,$00,$00,$00,$00   ........
L00E0    fcb   $00,$1B,$2B,$CC,$04,$05,$00,$20   ..+L... 
L00E8    fcb   $00,$08,$00,$40,$FF,$FF,$FF,$FF   ...@....
L00F0    fcb   $FF,$FF,$FF,$FF,$CC,$CC,$CC,$CC   ....LLLL
L00F8    fcb   $CC,$CC,$CC,$CC,$FF,$FF,$FF,$FF   LLLL....
L0100    fcb   $FF,$FF,$FF,$FF,$CC,$CC,$CC,$CC   ....LLLL
L0108    fcb   $CC,$CC,$CC,$CC,$FF,$FF,$FF,$FF   LLLL....
L0110    fcb   $FF,$FF,$FF,$FF,$CC,$CC,$CC,$CC   ....LLLL
L0118    fcb   $CC,$CC,$CC,$CC,$FF,$FF,$FF,$FF   LLLL....
L0120    fcb   $FF,$FF,$FF,$FF,$CC,$CC,$CC,$CC   ....LLLL
L0128    fcb   $CC,$CC,$CC,$CC,$1B,$2B,$CC,$05   LLLL.+L.
L0130    fcb   $05,$00,$20,$00,$08,$00,$40,$30   .. ...@0
L0138    fcb   $30,$30,$30,$30,$30,$30,$30,$C0   0000000@
L0140    fcb   $C0,$C0,$C0,$C0,$C0,$C0,$C0,$03   @@@@@@@.
L0148    fcb   $03,$03,$03,$03,$03,$03,$03,$0C   ........
L0150    fcb   $0C,$0C,$0C,$0C,$0C,$0C,$0C,$30   .......0
L0158    fcb   $30,$30,$30,$30,$30,$30,$30,$C0   0000000@
L0160    fcb   $C0,$C0,$C0,$C0,$C0,$C0,$C0,$03   @@@@@@@.
L0168    fcb   $03,$03,$03,$03,$03,$03,$03,$0C   ........
L0170    fcb   $0C,$0C,$0C,$0C,$0C,$0C,$0C,$1B   ........
L0178    fcb   $2B,$CC,$06,$05,$00,$20,$00,$08   +L... ..
L0180    fcb   $00,$40,$0C,$0C,$0C,$0C,$0C,$0C   .@......
L0188    fcb   $0C,$0C,$03,$03,$03,$03,$03,$03   ........
L0190    fcb   $03,$03,$C0,$C0,$C0,$C0,$C0,$C0   ..@@@@@@
L0198    fcb   $C0,$C0,$30,$30,$30,$30,$30,$30   @@000000
L01A0    fcb   $30,$30,$0C,$0C,$0C,$0C,$0C,$0C   00......
L01A8    fcb   $0C,$0C,$03,$03,$03,$03,$03,$03   ........
L01B0    fcb   $03,$03,$C0,$C0,$C0,$C0,$C0,$C0   ..@@@@@@
L01B8    fcb   $C0,$C0,$30,$30,$30,$30,$30,$30   @@000000
L01C0    fcb   $30,$30,$1B,$2B,$CC,$07,$05,$00   00.+L...
L01C8    fcb   $20,$00,$08,$00,$40,$C0,$C0,$C0    ...@@@@
L01D0    fcb   $C0,$C0,$C0,$C0,$C0,$00,$00,$00   @@@@@...
L01D8    fcb   $00,$00,$00,$00,$00,$0C,$0C,$0C   ........
L01E0    fcb   $0C,$0C,$0C,$0C,$0C,$00,$00,$00   ........
L01E8    fcb   $00,$00,$00,$00,$00,$C0,$C0,$C0   .....@@@
L01F0    fcb   $C0,$C0,$C0,$C0,$C0,$00,$00,$00   @@@@@...
L01F8    fcb   $00,$00,$00,$00,$00,$0C,$0C,$0C   ........
L0200    fcb   $0C,$0C,$0C,$0C,$0C,$00,$00,$00   ........
L0208    fcb   $00,$00,$00,$00,$00,$1B,$2B,$CC   ......+L
L0210    fcb   $08,$05,$00,$20,$00,$08,$00,$40   ... ...@
L0218    fcb   $3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C   <<<<<<<<
L0220    fcb   $C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3   CCCCCCCC
L0228    fcb   $C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3   CCCCCCCC
L0230    fcb   $3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C   <<<<<<<<
L0238    fcb   $3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C   <<<<<<<<
L0240    fcb   $C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3   CCCCCCCC
L0248    fcb   $C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3   CCCCCCCC
L0250    fcb   $3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C   <<<<<<<<
