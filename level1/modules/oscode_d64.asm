*        org 2600
         nam Bootstrap
         ttl   Dragon Bootstrap code

os9start equ $EF00
os9size  equ $0F80

Start    fcc "OS"

         clr   >$FF03
         clr   >$FF01
         sta   >$FFDF
         ldb   #6
         ldx   #$FFC6
L0010    sta   ,x++
         decb  
         bne   L0010
         sta   $01,x
         ldx   #$8000
         ldy   #$0200
         lda   #$60
L0020    sta   ,x+
         leay  -$01,y
         bne   L0020

* Write "OS9 BOOT" to the screen
         ldx   #$810C
         leay  <L0056,pcr
         ldb   #$08
L002E    lda   ,y+
         sta   ,x+
         decb  
         bne   L002E
         tst   <$72
         beq   L004C

* Move the kernel to $F000
         leau  >Start,pcr
         ldx   #os9size
         ldy   #os9start
L0044    lda   ,u+
         sta   ,y+
         leax  -$01,x
         bne   L0044

* Jump to OS9
L004C    jmp   >os9start+$4F     After the move, this is like jumping to L004F
L004F    leax  <end,pcr
         ldd   $09,x
         jmp   d,x

L0056    fcc  "OS"
         fcb  $79
         fcb  $60
         fcb  'B
         fcb  'O
         fcb  'O
         fcb  'T
end      equ *
