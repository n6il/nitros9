********************************************************************
* SHDW - Kings Quest III screen rendering module??
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 0      Disassembly of original distribution           PWZ 03/03/14
*        using a combination of disasm v1.6 and
*        the os9tools disassembler Os9disasm
*
*        Note the header shows a data size of 0
*        called from the sierra module and accesses
*        data set up in that module
*
*        Much credit and thanks is give to Nick Sonneveld and 
*        the other NAGI folks. Following his sources made it
*        so much easier to document what was happening in here.
  
*        This source will assemble byte for byte 
*        to the original kq3 shdw module.
*
*        Header for : shdw
*        Module size: $A56  #2646
*        Module CRC : $E9E019 (Good)
*        Hdr parity : $74
*        Exec. off  : $0012  #18
*        Data size  : $0000  #0
*        Edition    : $00  #0
*        Ty/La At/Rv: $11 $81
*        Prog mod, 6809 Obj, re-ent, R/O



* Disassembly by Os9disasm of shdw


         nam   shdw
         ttl   program module       


         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size

size           equ   .

Xffa9          equ $FFA9
X01af          equ $01AF   pointer to state.flag
X0551          equ $0551   pointer to a linked list of picture data


* OS9 data area definitions

u001a          equ $001A    shdw MMU block data
u002e          equ $002E    Load offset 
u0042          equ $0042    Sierra process descriptor block
u0043          equ $0043    Sierra 2nd 8K data block    
u005a          equ $005A    color
u005b          equ $005B    sbuff_drawmask
u005c          equ $005C    flag_control 
u006b          equ $006B    pen_status
u009e          equ $009E    pos_init_x
u009f          equ $009F    pos_init_y
u00a0          equ $00A0    pos_final_x
u00a1          equ $00A1    pos_final_y 
u00a2          equ $00A2    pen_x position
u00a3          equ $00A3    pen_y position

* these look like gen purpose scratch vars

u00a4          equ $00A4    
u00a5          equ $00A5    
u00a6          equ $00A6    
u00a7          equ $00A7    
u00a8          equ $00A8    
u00a9          equ $00A9    
u00aa          equ $00AA
u00ab          equ $00AB    
u00ac          equ $00AC    
u00ad          equ $00AD    
u00ae          equ $00AE
u00af          equ $00AF
u00b0          equ $00B0
u00b2          equ $00B2
u00b3          equ $00B3
u00e9          equ $00E9


* Local Program Defines

PICBUFF_WIDTH  equ 160
PICBUFF_HEIGHT equ 168


* VIEW OBJECTS FLAGS

O_DRAWN        equ $01   * 0  - object has been drawn
O_BLKIGNORE    equ $02   * 1  - ignore blocks and condition lines
O_PRIFIXED     equ $04   * 2  - fixes priority agi cannot change it based on position
O_HRZNIGNORE   equ $08   * 3  - ignore horizon
O_UPDATE       equ $10   * 4  - update every cycle
O_CYCLE        equ $20   * 5  - the object cycles
O_ANIMATE      equ $40   * 6  - animated
O_BLOCK        equ $80   * 7  - resting on a block
O_WATER        equ $100  * 8  - only allowed on water
O_OBJIGNORE    equ $200  * 9  - ignore other objects when determining contacts
O_REPOS        equ $400  * 10 - set whenever a obj is repositioned
*                                that way the interpeter doesn't check it's next movement for one cycle
O_LAND         equ $800  * 11 - only allowed on land
O_SKIPUPDATE   equ $1000 * 12 - does not update obj for one cycle
O_LOOPFIXED    equ $2000 * 13 - agi cannot set the loop depending on direction
O_MOTIONLESS   equ $4000 * 14 - no movement.  
*                                if position is same as position in last cycle then this flag is set.
*                                follow/wander code can then create a new direction
*                                (ie, if it hits a wall or something)
O_UNUSED       equ $8000


picb_size      equ PICBUFF_WIDTH*PICBUFF_HEIGHT
x_max          equ PICBUFF_WIDTH-1  
y_max          equ PICBUFF_HEIGHT-1 

gfx_picbuff    equ $6040   screen buff low address
gbuffend       equ $C940   screen buff high address

cmd_start      equ $F0     first command value


name  equ   *
L000d fcs 'shdw'
      fcb $00

* This module is linked to in sierra

start equ   *
L0012 lbra  L05fb      screen init ?
      lbra  L0713      obj_chk_control
      lbra  L0175      render_pic  (which calls pic_cmd_loop)  
      lbra  L0189      pic_cmd_loop
      lbra  L07be      obj_blit
      lbra  L0927
      lbra  L0a0f
      lbra  L09d8
      lbra  L040e      sbuff_fill
      lbra  L063a
      lbra  L0615

      fcc  'AGI (c) copyright 1988 SIERRA On-Line'
      fcc  'CoCo3 version by Chris Iden'
      fcb   C$NULL

* Twiddles with MMU
* accd is loaded by calling program
L0074 cmpa  u001a      compare to shdw mem block
      beq   L008e      equal ?? no work to be done move on
      orcc  #IntMasks  turn off interupts
      sta   u001a      store the value passed in by a
      lda   u0042      get sierra process descriptor map block
      sta   Xffa9      map it in to $2000-$3FFF
      ldu   u0043      2nd 8K data block in Sierra
      lda   u001a      load my mem block value
      sta   ,u         save my values at address held in u0043
      stb   2,u        
      std   Xffa9      map it to task 1 block 2
      andcc #^IntMasks restore the interupts
L008e rts              we done
   
L008f fcb $00          load offsets updated flag

* binary_list[] (pic_render.c)
L0090 fdb $8000
      fdb $4000
      fdb $2000
      fdb $1000
      fdb $0800
      fdb $0400
      fdb $0200
      fdb $0100
      fdb $0080
      fdb $0040
      fdb $0020
      fdb $0010
      fdb $0008
      fdb $0004
      fdb $0002
      fdb $0001

* circle_data[] (pic_render.c)
L00b0 fdb $8000
      fdb $e000
      fdb $e000
      fdb $e000
      fdb $7000
      fdb $f800
      fdb $f800
      fdb $f800
      fdb $7000
      fdb $3800
      fdb $7c00
      fdb $fe00
      fdb $fe00
      fdb $fe00
      fdb $7c00
      fdb $3800
      fdb $1c00
      fdb $7f00
      fdb $ff80
      fdb $ff80
      fdb $ff80
      fdb $ff80
      fdb $ff80
      fdb $7f00
      fdb $1c00
      fdb $0e00
      fdb $3f80
      fdb $7fc0
      fdb $7fc0
      fdb $ffe0
      fdb $ffe0
      fdb $ffe0
      fdb $7fc0
      fdb $7fc0
      fdb $3f80
      fdb $1f00
      fdb $0e00
      fdb $0f80
      fdb $3fe0
      fdb $7ff0
      fdb $7ff0
      fdb $fff8
      fdb $fff8
      fdb $fff8
      fdb $fff8
      fdb $fff8
      fdb $7ff0
      fdb $7ff0
      fdb $3fe0
      fdb $0f80
      fdb $07c0
      fdb $1ff0
      fdb $3ff8
      fdb $7ffc
      fdb $7ffc
      fdb $fffe
      fdb $fffe
      fdb $fffe
      fdb $fffe
      fdb $fffe
      fdb $7ffc
      fdb $7ffc
      fdb $3ff8
      fdb $1ff0
      fdb $07c0

* circle_list[] (pic_render.c) 
* I "assume" this data is different in the file
* { 0, 1, 4, 9, 16, 25, 37, 50 }
* These run like a set of numbers**2 {0,1,2,3,4,5,~6,~7} 
* ah ha these are multiples 2*(0,1,2,3,4,5,~6,~7)**2)

L0132 fcb $00,$00        0
      fcb $00,$02        2
      fcb $00,$08        8
      fcb $00,$12       18
      fcb $00,$20       32
      fcb $00,$32       50
      fcb $00,$4a       74
      fcb $00,$64      100
      

* select case dispatch table for pic_cmd_loop()

L0142 fdb $01bc        enable_pic_draw()
      fdb $01c9        disable_pic_draw()
      fdb $01d4        enable_pri_draw()
      fdb $01e9        disable_pri_draw()
      fdb $02de        draw_y_corner()
      fdb $02d1        draw_x_corner()
      fdb $0309        absolute_line()
      fdb $031d        relative_line()
      fdb $0359        pic_fill()
      fdb $0211        read_pen_status()
      fdb $01f4        plot_with_pen()


* This code adds the load offsets to the program offsets above
L0158 tst   L008f,pcr  test if we've loaded the offsets already
      bne   L0174      done once leave
      inc   L008f,pcr  not done set the flag 
      lda   #$0b       set our index to 11
      sta   u00ab      stow it in mem since we are going to clobber b
      leau  >L0142,pcr load table head address
L016a ldd   u002e      get load offset set in sierra
      addd  ,u         add the load offset 
      std   ,u++       and stow it back, bump pointer
      dec   u00ab      decrement the index
      bne   L016a      ain't done go again
L0174 rts              we're out of here


* The interaction between render_pic and pic_cmd_loop is divided 
* differently in the NAGI source pic_render.c

* render_pic()
* color = F, 4 = proirity so the note says

L0175 ldd   #$4f4f     load the color
      pshs  d          push it on the stack for the pass
      lbsr  L040e      call sbuff_fill routine
      leas  2,s        reset stack to value at entry
      ldd   2,s        pull the next word 
      pshs  d          push it on top of the stack        
      lbsr  L0189      call pic_cmd_loop()
      leas  2,s        once we return clean up stack again
      rts              return
      
* pic_cmd_loop() (pic_render.c)        
L0189 pshs  y
      bsr   L0158      ensure load offset has been added to table address
      lbsr  L06fc      sbuff_fill()
      clra             make a zero
      sta   u005b      sbuff_drawmask
      sta   u006b      pen_status
      coma             make the complement FF
      sta   u005a      store color
      
      ldu   4,s
      ldd   5,u
      lbsr  L0074      twiddle mmu 
      
* pic_cmd_loop()  (pic_render.c) starts here      
      ldx   X0551      given_pic_data  set in pic_res.c
L01a2 lda   ,x+        pic_byte
L01a4 cmpa  #$ff       if it's FF were done 
      beq   L01b9      so head out
      suba  #cmd_start first valid cmd = F0 so subtract to get index
      blo   L01a2      less than F0 ignore it
      cmpa  #$0a       check for top end
      bhi   L01a2      greater than FA ignore it
      leau  >L0142,pcr load the addr of the dispatch table
      asla             sign extend multiply by two for double byte offset
      jsr   [a,u]      make the call
      bra   L01a4      loop again
L01b9 puls  y          done then fetch the y back 
      rts              and return
      
* Command $F0 change picture color and enable picture draw
*  enable_pic_draw() pic_render.c
*  differs slightly with pic_render.c 
*  don't have colour_render()
*  and setting of colour_picpart
*  
*  x contains pic_byte         
*  after ldd
*  a contains color
*  b contains draw mask
*  returns the next pic_byte in a

L01bc ldd   u005a      pulls in color and sbuff_drawmask
      anda  #$f0       and color with $F0
      ora   ,x+        or that result with the pic_byte and bump to next
      orb   #$0f       or the sbuff_drawmask with $0F
      std   u005a      store the updated values
      lda   ,x+        return value ignored so this just bumps to next pic_byte
      rts
      

* Command $F1 Disable picture draw
*  disable_pic_draw()         
L01c9 ldd   u005a      pulls in color and sbuff_drawmask
      ora   #$0f       ors color with $0F (white ??)
      andb  #$f0       ands draw mask with $F0
      std   u005a      store the updated values
      lda   ,x+        return value ignored so this just bumps to next pic_byte
      rts
      
* Command $F2 Changes priority color and enables priority draw
*  enable_pri_draw
L01d4 ldd   u005a      pulls in color and sbuff_drawmask      
      anda  #$0f       ands color with $0F
      sta   u005a      save color 
      lda   ,x+        loads pic_byte and bumps to next
      asla             times 2 with sign extend
      asla             again times 2
      asla             and again times 2
      asla             end result is multiply pic_byte by 16 ($10)  
      ora   u005a      or that value with the modified color
      orb   #$f0       or the sbuff_drawmask with $F0
      std   u005a      store the updated values
      lda   ,x+        return value ignored so this just bumps to next pic_byte
      rts
      
* Command $F3 Disable priority draw
*  diasable_pri_draw() pic_render.c
L1e9  ldd   u005a      pulls in color and sbuff_drawmask
      ora   #$f0       or the color with $F0
      andb  #$0f       and the sbuff_drawmask with $0F
      std   u005a      store the updated values
      lda   ,x+        return value ignored so this just bumps to next pic_byte
      rts
      
* Command $FA plot with pen 
* Logic is pic_byte >= 0xF0 in c source.
* Emailed Nick Sonneveld 3/14/ 03

* plot_with_pen()  (pic_render.c)        
L01f4 lda   u006b      pen_status
      bita  #$20       and but don't change check for pen type solid or splater ($20)
      beq   L0204      is splater 
      lda   ,x+        load pic_byte (acca) from pic_code and bump pointer
      cmpa  #cmd_start       test against $F0 if a is less than
*                      based on discussions with Nick this must have been a bug 
*                      in the earlier versions of software...
*                      if it is less than $F0 it's just a picture byte 
*                      fix next rev. 
      lblo  L02ea      branch to a return statement miles away (could be fixed)
      sta   u00a6      save our pic_byte in texture_num
L0204 lbsr  L0364      call read_xy_postion
      lblo  L02ea      far off rts
      std   u00a2      pen x/y position 
      bsr   L0218      call plot_with_pen2
      bra   L01f4      go again ...
*                      yes there is no rts here in the c source either


* Command $F9 Change pen size and style
*  read_pen_status() pic_render.c
L0211 lda   ,x+        get pic_byte
      sta   u006b      save as pen_status
      lda   ,x+        return value ignored so this just bumps to next pic_byte  
      rts
      

* plot_with_pen2
*  Set up circle_ptr         
*  u00a7 = pen.size
*  u00a9 = pensize x 2
*  u00ab = scratch var
*  u00ad = penwidth

L0218 ldb   u006b      pen_status
      andb  #$07        
      stb   u00a7      pen.size ?? save for pen_status & $07 
      
      clra             clear a and condition codes
      lslb             multiply by 2 
      std   u00a9      pen size x 2
      leau  L0132,pcr  circle_list[]
      ldd   b,u        d now holds one of the circle_list values 
      leau  L00b0,pcr  circle_data[]
      leau  d,u        use that to index to a circle_data item
*                      u now is circle_ptr      

*  Set up x position       
      clra  
      ldb   u00a2      load pen_x position
      lslb             multiply by two
      rola  
      subb  u00a7      subtract the pen.size
      bcc   L023f      outcome not less than zero move on
      deca               
      bpl   L023f      if we still have pos must be 0 or >
      ldd   #0000        
      bra   L024d
L023f std   u00ab      store pen_x at scratch 

      ldd   #$0140     start with 320
      subd  u00a9      subtract 2 x pen.size
      cmpd  u00ab      pen_x to calc
      bls   L024d      if pen_x is greater keep temp calc
      ldd   u00ab      otherwise use pen_x
      
L024d lsra             divide by 2
      rorb  
      stb   u00a2      stow at pen_x
      stb   u00a4      stow at pen_final_x
      
*  Set up y position      
      lda   u00a3      pen_y
      suba  u00a7      pen.size
      bcc   L025c      >= 0 Ok go stow it
      clra             otherwise less than zero so set it to 0
      bra   L0268      go stow it
L025c sta   u00ab      store pen_y at scratch

      lda   #y_max     start with 167
      suba  u00aa      subtract 2 x pen.size
      cmpa  u00ab      compare to pen_y calced so far
      bls   L0268      if pen_y > calc use calc and save it
      lda   u00ab      otherwise use pen_y
L0268 sta   u00a3      pen_y
      sta   u00a5      pen_final_y
      
      lda   u00a6      texture_num
      ora   #$01
      sta   u00a8      t ??
      
      ldb   u00aa      2 x pen.size
      incb             bump it by one
      tfr   b,a        copy b into a
      adda  u00a5      add value to pen_final_y
      sta   u00a5      save new pen_final_y
      lslb             shift b left (multiply by 2)
      
      leax  L0090,pcr  binary list[]
      ldd   b,x        use 2x pensize + 1 to index into list 
      std   u00ad      pen width ???

*   this looks like it should have been nested for loops
*   but not coded that way in pic_render.c

*  new y
L0284 leax  L0090,pcr  binary_list[]

*  new x
L0288 lda   u006b      pen_status
      bita  #O_UPDATE  and it with $10 but don't change 
      bne   L0298      not equal zero go on to next pen status test
      ldd   ,u         otherwise  load data at circle_ptr
      anda  ,x         and that with first element in binary_list
      bne   L0298      if thats not zero go on to next pen status check

      andb  1,x        and the second bytes of data at circle_ptr
*                      and binary_list       
      beq   L02ba      that outcome is equ zero head for next calcs 

L0298 lda   u006b      pen_status
      bita  #$20       anded with $20 but don't change  
      beq   L02af      equals zero set up and plot buffer
      lda   u00a8      otherwise load t (texture_num | $01)
      lsra             divide by 2
      bcc   L02a5      no remainder save that number as t
      eora  #$b8       exclusive or t with$B8
L02a5 sta   u00a8      save new t
      bita  #O_DRAWN     anded with 1 but don't change 
      bne   L02ba        not equal zero don't plot
      bita  #O_BLKIGNORE anded with 2 but don't change 
      beq   L02ba        does equal zero don't plot

L02af pshs  u          save current u sbuff_plot uses it
      ldd   u00a2      load pen_x/pen_y values
      std   u009e      save at pos_init_x/y positions
      lbsr  L046f      head for sbuff_plot()
      puls  u          retrieve u from before call

L02ba inc   u00a2      increment pen_x value

      leax  4,x        move four bytes in the binary_list
      cmpx  u00ad      comapre that value to pen_width
      bls   L0288      less or same go again
      
      leau  2,u        bump circle_ptr to next location in circle_data[]
      
      lda   u00a4      load pen_final_x
      sta   u00a2      store at pen_x       
      inc   u00a3      bump pen_y
      lda   u00a3      pen_y
      cmpa  u00a5      compare to pen_final_y
      bne   L0284      not equal go do the next row
      rts
      

* Command $F5 Draw an X corner 
* draw_x_corner()  pic_render.c        
L02d1 lbsr  L0364      call read_xy_pos
      bcs   L02ea      next subs rts
      std   u009e      save pos_init_x/y positions
      lbsr  L046f      head for sbuff_plot()
      bsr   L02eb      draw_corner(0)
      rts
      

* Command $F4 Draw a Y corner         
L02de lbsr  L0364      call read_xy_pos
      bcs   L02ea      return
      std   u009e      save at pos_init_x/y positions
      lbsr  L046f      head for sbuff_plot()
      bsr   L02f9      draw_corner(1)
L02ea rts



* draw_corner()
draw_x:   
L02eb lbsr  L036f      get_x_pos()
      bcs   L02ea      prior subs return
      sta   u00a0      store as pos_final_x
      ldb   u009f      load pos_init_y
      stb   u00a1      store as pos_final_y
      lbsr  L0421      call sbuff_xline()

draw_y:
L02f9 lbsr  L0381      get_y_pos
      bcs   L02ea      prior subs return
      stb   u00a1      save pos_final_y
      lda   u009e      load pos_init_x
      sta   u00a0      save pos_final_x
      lbsr  L0447      sbuff_yline()     
      bra   L02eb      head for draw_x



* Command $F6 Absolute line
* absolute_line()
* NAGI has these out of order
* This command is before Draw X corner in their source
L0309 bsr   L0364      call read_xy_pos
      bcs   L02ea      prior subs return
      std   u009e      save at pos_init_x/y positions
      lbsr  L046f      head for sbuff_plot()
L0312 bsr   L0364      call read_xy_pos
      bcs   L02ea      prior subs return
      std   u00a0      save at pos_final_x/y and passed draw_line in d
      lbsr  L0394      call draw_line()
      bra   L0312      go again
      
      
      
* relative_line()      
L031D bsr   L0364      call read_xy_pos
      bcs   L02ea      prior subs return
      std   u009e      save at pos_init_x/y positions
      lbsr  L046f      head for sbuff_plot()

* calc x
L0326 lda   ,x+        get next pic_byte 
*                      and load it in pos_data in c source
      cmpa  #cmd_start is that equal $F0 or greater
      bcc   L02ea      yep were done so return (we use prior subs return ??)
*                      that rascal in acca changes names again to x_step
*                      but it's still the same old data
      anda  #$70       and that with $70 
*                      (where these values are derived from I haven't a clue, as of yet :-))
      lsra             divide by 2
      lsra             and again
      lsra             once more
      lsra             and finally another for a /16
      ldb   -1,x       get the original value
      bpl   L0337      if original value not negative move on
      nega             else it was so flip the sign of the computed value
L0337 adda  u009e      add pos_init_x position
      cmpa  #x_max     compare to 159
      bls   L033f      if it's less or same move on
      lda   #x_max     else cap it at 159
L033f sta   u00a0      store as pos_final_x

* calc y
*                      not quite the same as pic_render.c almost
*                      we've go the pic_byte ... er pos_data ... now called y_step
*                      in b so lets calc the y_step
      andb  #$0f       and with $0F (not in pic_render.c)
      bitb  #$08       and that with $08 but don't change  
      beq   L034a      if result = 0 move on
      andb  #$07       else and it with $07
      negb             and negate it
L034a addb  u009f      add calced value to pos_init_y
      cmpb  #y_max     compare to 167 
      bls   L0352      less or same move on
      ldb   #y_max     greater ? cap it
L0352 stb   u00a1      pos_final_y

*                      passes pos_final_x/y in d
      lbsr  L0394      call draw_line()
      
      bra   L0326      go again exit is conditinals inside loop

* Command $F8 Fill
* pic_fill()
L0359 bsr   L0364      call read_xy_pos
      bcs   L02ea      returned a 1 head for prior subs return
      std   u009e      save at pos_init_x/y position
      lbsr  L0486      call sbuff_picfill()
      bra   L0359      loop till we get a 1 back from read_xy_pos

* read_xy_pos() 
L0364 lbsr  L036f      go get x position
      lblo  L02ea      prior subs return
      lbsr  L0381      go get the y position
      rts
      

* get_x_pos()         
L036f lda   ,x+        load pic_byte
      cmpa  #cmd_start is it a command?
      bhs   L037e      if so set CC 
      cmpa  #x_max     compare to 159
      bls   L037b      is it less or same clear CC and return
      lda   #x_max     greater than load acca with 159 
L037b andcc #$fe       clear CC ad return
      rts
      
         
L037e orcc  #1         returns a "1"
      rts
      
* get_y_pos()         
L0381 ldb   ,x+        load pic_byte
      cmpb  #cmd_start is it a command
      blo   L038b      nope less than command
      lda   -1,x       was a command load x back in acca
      bra   L037e      go set CC
L038b cmpb  #y_max     compare to 167
      bls   L0391      is it less or same clear CC and return
      ldb   #y_max     greater than load accb with 167 
L0391 andcc #$fe       clear CC and return
      rts
      

* draw_line()  pic_render.c
* while this is a void function() seems pos_final_x/y are passed in d
* 
*  u00a2 = x_count
*  u00a3 = y_count
*  u00a4 = pos_x
*  u00a5 = pos_y
*  u00a6 = line_x_inc
*  u00a7 = line_y_inc
*  u00a8 = x_component
*  u00a9 = y_component
*  u00aa = largest_line
*  u00ab = counter

*  process straight lines
L0394 cmpb  u009f      compare pos_final_y with pos_init_y
      lbeq  L0421      if equal call sbuff_xline() and don't return here
      cmpa  u009e      else compare with pos_init_x position
      lbeq  L0447      if equal call sbuff_yline() and don't return here

      ldd   u009e      load pos_init_x/y positions
      std   u00a4      store at pen_final ??? not in pic_render.c version

*  process y      
      lda   #$01       line_y_inc
      
      ldb   u00a1      load pos_final_y
      subb  u009f      subtract pos_init_y
      bcc   L03ae      greater or equal zero don't negate
*                      less than zero         
      nega             flip the sign of line_y_inc
      negb             flip the sign of y_component
      
L03ae sta   u00a7      store line_y_inc
      stb   u00a9      store y_component
      
* process x      
      lda   #$01       line_x_inc
      
      ldb   u00a0      load pos_final_x
      subb  u009e      subtract pos_init_x
      bcc   L03bc      greater or equal zero don't negate
*                      less than zero      
      nega             flip the sign of line_x_inc
      negb             flip the sign of x_component
L03bc sta   u00a6      store line_x_inc
      stb   u00a8      store x_component 

* compare x/y components
      cmpb  u00a9      compare y_component to x_component
      blo   L03d0      if x_component is smaller move on


*  x >= y 
*                      x_component is in b
      stb   u00ab      counter
      stb   u00aa      largest_line 
      lsrb             divide by 2
      stb   u00a3      store y_count
      clra             make a zero
      sta   u00a2      store x_count
      bra   L03dc      move on

*  x < y      
L03d0 lda   u00a9      load y_component
      sta   u00ab      stow as counter
      sta   u00aa      stow as largest line
      lsra             divide by 2
      sta   u00a2      store x_count
      clrb             make a zero
      stb   u00a3      store as y_count
      

* loops through the line and uses sbuff_plot to do the screen write
*                      y_count is in b      
L03dc addb  u00a9      add in the y_component
      stb   u00a3      and stow back as y_count
      cmpb  u00aa      compare that with line_largest
      blo   L03ee      if y_count >= line_largest is not the case branch
      subb  u00aa      subtract line_largest
      stb   u00a3      store as y_count
      ldb   u00a5      load pos_y
      addb  u00a7      add line_y_inc
      stb   u00a5      stow as pos_y

*                      x_count is in a
L03ee adda  u00a8      add in x_component
      sta   u00a2      store as x_count
      cmpa  u00aa      compare that with line_largest
      blo   L0400      if x_count >= line_largest is not the case branch
      suba  u00aa      subtract line_longest
      sta   u00a2      store at x_count
      lda   u00a4      load pos_x
      adda  u00a6      add line_x_inc
      sta   u00a4      stow as pos_x

L0400 ldd   u00a4      load computed pos_x/y
      std   u009e      store at pos_init_x/y positions
      lbsr  L046f      head for sbuff_plot()
      ldd   u00a2      reload x/y_count
      dec   u00ab      decrement counter
      bne   L03dc      if counter not zero go again
      rts
      
***********************************************************************
* end of pic_render.c


* sbuff_fill() sbuf_util.c        
* fill color is passed in s register

L040e pshs  x          save x as we use it for an index
      ldu   #gbuffend  address to write to 
      ldx   #picb_size $6900 bytes to write (26.25K)
*                      this would be picture buffer width x height
      ldd   4,s        since we pushed x pull our color input out of the stack
L0418 std   ,--u       store them and dec dest address
      leax  -2,x       dec counter
      bne   L0418      loop till done
      puls  x          fetch the x
      rts              return
      
* no sbuff_testpattern

* sbuff_xline()  sbuff_util.c
* gets called here with pos_final_x/y in accd
*
*  u00ac = x_orig
 
L0421 sta   u00ac      stow as x_orig
      cmpa  u009e      compare with pos_init_x position
      bhs   L042d      if pos_final_x same or greater branch
      
*                      otherwise init >  final so swap init and final     
      ldb   u009e      load pos_init_x position
      stb   u00a0      save pos_final_x position
      sta   u009e      save pos_init_x position
      
L042d bsr   L046f      head for sbuff_plot() returns pointer in u

      ldb   u00a0      load pos_final_x
      subb  u009e      subtract pos_init_x position
      beq   L0442      if they are the same move on
*                      b now holds the loop counter len
*                      u is the pointer returned from sbuff_plot
      leau  1,u        bump the pointer one byte right 
L0437 lda   ,u         get the the byte
      ora   u005b      or it with sbuff_drawmmask
      anda  u005a      and it with the color
      sta   ,u+        save it back and bump u to next byte
      decb             decrememnt the loop counter
      bne   L0437      done them all? Nope loop
      
L0442 lda   u00ac      x_orig (pos_final_x)
      sta   u009e      save at pos_init_x position
      rts
      

* sbuff_yline() sbuf_util.c
* gets called here with pos_final_x/y in accd
*
*  u00ac = y_orig

L0447 stb   u00ac           stow as y_orig
      cmpb  u009f           compare with pos_init_y
      bhs   L0453           if pos_final same or greater branch

*                           otherwise init > final so swap 'em   
      lda   u009f           load pos_init_y
      sta   u00a1           stow as pos_final_y
      stb   u009f           stow as pos_init_y
      
L0453 bsr   L046f           head for sbuff_plot() returns pointer in u
      ldb   u00a1           load pos_final_y
      subb  u009f           subtract pos_init_y
      beq   L046a           if they are the same move on
*                           b now holds the loop counter len
*                           u is the pointer returned from sbuff_plot
L045b leau  PICBUFF_WIDTH,u bump ptr one line up
      lda   ,u              get the byte  
      ora   u005b           or it with sbuff_drawmmask
      anda  u005a           and it with the color
      sta   ,u              save it back out
      decb                  decrement the loop counter
      bne   L045b           done them all ? Nope loop
      
L046a ldb   u00ac           load y_orig
      stb   u009f           save it as pos_init_y
      rts
      
      
* sbuff_plot()  from sbuf_util.c         
* according to agi.h PBUF_MULT(width) ((( (width)<<2) + (width))<<5)
* which next 3 lines equate to so the $A0 is from 2 x 5  
* pointer is returned in index reg u
L046f ldb   u009f           load pos_init_y
      lda   #$A0            according to PBUF_MULT() 
      mul                   do the math
      addb  u009e           add pos_init_x position 
      adca  #0000           this adds the carry bit in to a
      addd  #gfx_picbuff    add that to the start of the screen buf $6040
      tfr   d,u             move this into u
      lda   ,u              get the byte u points to 
      ora   u005b           or it with sbuff_drawmask
      anda  u005a           and it with the color
      sta   ,u              and stow it back at the same place
      rts                   return
      



* sbuff_picfill(u8 ypos, u8 xpos) sbuf_util.c         
* u005a = color
* u005b = sbuff_drawmask
* u009e = pos_init_x
* u009f = pos_init_y
* u00a0 = left
* u00a1 = right 
* u00a2 = old_direction
* u00a3 = direction
* u00a4 = old_initx
* u00a5 = old_inity
* u00a6 = old_left
* u00a7 = old_right
* u00a8 = stack_left
* u00a9 = stack_right
* u00aa = toggle
* u00ab = old_toggle
* u00ac =  
* u00ad =  
* u00ae = color_bl
* u00af = mask_dl
* u00b0 = old_buff (word)
* u00b2 = temp (buff)
* u00b3 =
* u00e9 =


colorbl set $4F


L0486 pshs  x               save x
      ldx   #$e000          load addr to create a new stack
      sts   ,--x            store current stack pointer there and decrement x 
      tfr   x,s             make that the stack
*                           s is now stack_ptr pointing to fill_stack      
      
      ldb   u009f           pos_init_y
      lda   #$a0            set up PBUF_MULT
      mul                   do the math
      addb  u009e           add pos_init_x
      adca  #0000           add in that carry bit
      addd  #gfx_picbuff    add the start of screen buffer $6040
      tfr   d,u             move this to u
*                           u now is pointer to screen buffer b

      
      ldb   u005a           load color  
      lda   u005b           load sbuff_drawmask
      
*                          next 2 lines must have been a if (sbuff_drawmask > 0)
*                          not in the nagi source
      
      lbeq  L05f5           if sbuff_drawmask = 0 we're done
      bpl   L04b8           if not negative branch to test color 
      
      cmpa  #cmd_start      comp $F0 with sbuff_drawmask
      bne   L04b8           not = go test color for $0F
      andb  #$f0            and color with $F0
      cmpb  #$40            compare that to $40 (input was $4x)
      lbeq  L05f5           if so were done
      lda   #$f0            set up value for mask_dl           
      bra   L04c2           go save it

L04b8 andb  #$0f            and color with $0F
      cmpb  #$0f            was it already $0F
      lbeq  L05f5           if so we're done   
      lda   #$0f            set up value for mask_dl
      
L04c2 sta   u00af           stow as mask_dl
      anda  #colorbl        and that with $4F 
      sta   u00ae           stow that as color_bl
      lda   ,u              get byte at screen buffer
      anda  u00af           and with mask_dl
      cmpa  u00ae           compare to color_bl
      lbne  L05f5           not equal were done
      
      ldd   #$FFFF          push 7 $FF bytes on temp stack
      pshs  a,b             and set stack_ptr accordingly
      pshs  a,b
      pshs  a,b
      pshs  a

      lda   #$a1            load a with 161
      sta   u00a0           stow it at left
      clra                  make a zero
      sta   u00a1           stow it at right
      sta   u00aa           stow it at toggle 
      inca                  now we want a 1
      sta   u00a3           stow it at direction

* fill a new line
L04e9 ldd   u00a0           load left/right
      std   u00a6           stow at old_left/right
      lda   u00aa           load toggle
      sta   u00ab           stow at old_toggle
      ldb   u009e           load pos_init_x
      stb   u00a4           store as old_initx
      incb                  accb now becomes counter
      stu   u00b0           stow current screen byte as old_buff

L04f8 lda   ,u              get the screen byte pointed to by u
      ora   u005b           or it with sbuff_drawmmask
      anda  u005a           and that with the color
      sta   ,u              stow that back
      lda   ,-u             get the screen byte befor that one
      anda  u00af           and that with mask_dl
      cmpa  u00ae           compare result with color_bl
      bne   L050b           not equal move on
      decb                  otherwise decrement the counter
      bne   L04f8           if were not at zero go again
      
L050b leau  1,u             since cranked to zero bump the screen pointer by one
      tfr   u,d             move that into d
      subd  u00b0           subtract old_buff
      addb  u009e           add pos_init_x
      stb   u00a0           stow at left
      lda   u009e           load pos_init_x 
      stb   u009e           store left at pos_init_x
      stu   u00b2           temp buff
      ldu   u00b0           load  old_buff
      leau  1,u             bump to the next byte
      nega                  negate pos_init_x value
      adda  #x_max          add that to 159 (subtract pos_init_x)
      beq   L0537           that's the new counter and if zero move on

L0524 ldb   ,u              get that screen byte (color_old)
      andb  u00af           and it with mask_dl
      cmpb  u00ae           check against color_bl
      bne   L0537           not equal move on
      ldb   ,u              load that byte again to do something with
      orb   u005b           or it with sbuff_drawmmask
      andb  u005a           and it with color
      stb   ,u+             stow it back and bump the pointer
      deca                  decrement the counter 
      bne   L0524           if we haven't hit zero go again
      
L0537 tfr   u,d             move the screen buff ptr to d
      subd  u00b2           subtract that saved old pointer
      decb                  sunbtract a 1
      addb  u00a0           add in the left
      stb   u00a1           store as the right
      lda   u00a6           load old_left
      cmpa  #$a1            compare to 161
      beq   L0577           if it is move on
      
      cmpb  u00a7           if the new right == old right
      beq   L0552           then move on
      bhi   L0566           not equal and right > old_right
*                           otherwise    
      stb   u00a4           stow right as old_initx
      clr   u00aa           clear toggle
      bra   L056c           head for next calc
*                           they were equal      
L0552 lda   u00a0           load a with left
      cmpa  u00a6           compare that to old_left
      bne   L0566           move on          
      lda   #$01            set up a one
      cmpa  u00aa           compare toggle
      beq   L0577           is a one ? go to locnext
      sta   u00aa           not one ? set it to 1
      lda   u00a1           load right
      sta   u00a4           stow it as old_initx
      bra   L056c           head for the next calc
*                           right > old_right or left > old left      
L0566 clr   u00aa           clear toggle
      lda   u00a7           load old right
      sta   u00a4           save as old_initx

*         push a bunch on our temp stack
L056c ldy   u00a2           old_direction/direction         
      ldx   u00a4           old_initx/y
      ldu   u00a6           old_left/right
      lda   u00ab           old_toggle
      pshs  a,x,y,u         push them on the stack

locnext:
L0577 lda   u00a3           load direction
      sta   u00a2           stow as old_direction
      ldb   u009f           load pos_init_y
      stb   u00a5           stow as old_inity

L057f addb  u00a3           add direction to pos_init_y 
      stb   u009f           stow the updated pos_init_y
      cmpb  #y_max          compare that to 167 
      bhi   L05c5           greater than 167 go test direction

L0587 ldb   u009f           load pos_init_y
      lda   #$A0            according to PBUF_MULT
      mul                   do the math
      addb  u009e           add pos_init_x position
      adca  #0000           this adds the carry bit into the answer
      addd  #gfx_picbuff    add that to the screen buff start addr $6040
      tfr   d,u             move it into u
      lda   ,u              get the byte pointed to
      anda  u00af           and with mask_dl
      cmpa  u00ae           compare with color_bl
      lbeq  L04e9           if equal go fill a new line
      
      lda   u009e           load pos_init_x
      ldb   u00a3           load direction
      cmpb  u00a2           compare to old_direction
      beq   L05bc           go comapre pos_init_x and right
      tst   u00aa           test toggle
      bne   L05bc           not zero go comapre pos_init_x and right
      cmpa  u00a8           compare pos_init_x and stack_left
      blo   L05bc           less than stack_left go comapre pos_init_x and right
      cmpa  u00a9           compare it to stack_right
      bhi   L05bc           greater than go comapre pos_init_x and right
      lda   u00a9           load stack_right 
      cmpa  u00a1           compare to right
      bhs   L05c5           greater or equal go check direction
      inca                  add one to stack_right
      sta   u009e           stow as pos_init_x
      
L05bc cmpa  u00a1           compare updated value to right
      bhs   L05c5           go check directions
      inca                  less than then increment by 1
      sta   u009e           stow updated value pos_init_x
      bra   L0587           loop for next byte
      
* test direction and toggle      
L05c5 lda   u00a3           load direction
      cmpa  u00a2           compare old_direction
      bne   L05dc           not equal go pull stacked values
      tst   u00aa           test toggle
      bne   L05dc           not zero go pull stack values
      nega                  negate direction
      sta   u00a3           store back at direction
      lda   u00a0           load left
      sta   u009e           stow as pos_init_x
      ldb   u00a5           load old_inity
      stb   u009f           stow at pos_init_y
      bra   L05ef           go grab off stack and move on

* directions not equal      
L05dc puls  a,x,y,u         grab the stuff off the stack
      cmpa  #$FF            test toggle for $FF source has test of pos_init_y
      beq   L05f5           equal ? clean up stack and return
      sty   u00a2           stow old_direction/direction
      stx   u009e           stow pos_init_x/y
      stu   u00a0           stow left/right
      sta   u00aa           stow toggle
      
      ldb   u009f           load pos_init_y
      stb   u00a5           stow old_inity
L05ef ldx   5,s             gets left right  off stack
      stx   u00a8           stow stack_left/right
      bra   L057f           always loop

L05f5 lds   ,s              reset stack
      puls  x               retrieve our x
      rts                   return

* screen initialization ??
* this routine effective swaps postion of
* the two nibbles of the byte loaded 
* and returns it to the screen 

L05fb ldx   #gfx_picbuff starting low address of srceen mem
L05fe lda   ,x           get the first byte  bit order 0,1,2,3,4,5,6,7
      clrb               empty b
      lsra               shift one bit from a
      rorb               into b
      lsra               again
      rorb  
      lsra               and again
      rorb  
      lsra               and finally once more
      rorb  
      stb   ,x           were changing x anyway so use it for temp storage
      ora   ,x           or that with acca so now bit order from orig
*                        is 4,5,6,7,0,1,2,3
      sta   ,x+          put it back at x and go for the next one
      cmpx  #gbuffend    ending high address of screen mem
      bcs   L05fe
      rts   


L0615 leas  -2,s
      ldx   4,s
      ldu   2,x
L061b stu   ,s
      beq   L0637
      pshs  u
      lbsr  L09d8
      leas  2,s
      ldu   ,s
      ldu   4,u
      pshs  u
      lbsr  L07be     obj_blit()
      leas  2,s
      ldu   ,s
      ldu   2,u
      bra   L061b
L0637 leas  2,s
      rts   


L063a leas  -2,s
      ldx   4,s
      ldu   ,x
      beq   L0651
L0642 stu   ,s
      pshs  u
      lbsr  L0a0f
      leas  2,s
      ldx   ,s
      ldu   ,x
      bne   L0642
L0651 leas  2,s
      rts   

* From obj_picbuff.c the pri_table[172]
* ours is only 168
pri_table
L0654 fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00
      
      fcb $00,$00,$00,$00,$00,$00
      fcb $00,$00,$00,$00,$00,$00

* loops thru 48 bytes with a = 4
* bumps a by one load b with 12 this  
* iterates thru ten sets of twelve bytes
* bumping a by one as it goes.

* table_init()   obj_pic_buff.c
L06fc leax  L0654,pcr   point to data block
      ldb   #$30        load index 48
      lda   #4          load acca = 4
L0704 sta   ,x+         save a in buffer
      decb              dec the inner loop counter
      bne   L0704       go again if loop not finished
      cmpa  #$0e        get here when inner loop is done
      bcc   L0712       did we do 10 loops (e-4)
      inca              nope bump data byte
      ldb   #$0c        set new counter on loops 2-10
*                       to do 12 bytes and       
      bra   L0704       have at it again
L0712 rts   



* obj_chk_control(VIEW *x)  obj_picbuff.c
* our index reg x points to the view structure
* are 3 = x, 4 = y instead of 3-4 = x & 5-6 = y ???
*  u00a5 = flag_signal
*  u00a6 = flag_water
*  u005c = flag_control
*
*  X01af is loaction of state.flag
*  see agi.h for definition of state structure
L0713 pshs  y             save y

      ldx   4,s           sets up mmu info
      ldd   8,x         
      lbsr  L0074         twiddle mmu
      
      ldb   $04,x         load y ??? (obj_picbuff.c has a y ??)
      lda   $26,x         load flags
      bita  #O_PRIFIXED   and with $04 but don't change 
      bne   L072f         not zero move on
*                         it is zero then      
      leau  L0654,pcr     load buffer address
      clra                clear a since we will use d as an index
      lda   d,u           fetch the data from pri_table
      sta   $24,x         save as priority
      
L072f lda   #$A0          according to PBUF_MULT()
      mul                 do the math
      addb  $03,x         add in x ??
      adca  #0000         add in the carry bit
      addd  #gfx_picbuff  add it to the start of the screen buff addr 6040
      tfr   d,u           move the pointer pb to u
       
      ldy   $10,x         load y with cel_data ptr
      clra                make a zero
      sta   u00a6         stow it at flag_water
      sta   u00a5         stow it at flag_signal
      inca                make a 1
      sta   u005c         stow it at flag_contro1
      ldb   $24,x         load priority
      cmpb  #$0F          compare it with 15
      beq   L078b         If it equals 15 move on
*                         otherwise if not equal 15      
      sta   u00a6         stow that 1 at flag_water
      ldb   ,y            cx  first byte of cel_data  (cel_width)

*  do while cx != 0

L0752 lda   ,u+           (pri) put byte at pb in acca and bump pointer
      anda  #$F0          and that with $F0  (obstacle ??)
      beq   L077a         if it equals 0 set flag_control =0 and check_finish
      
      cmpa  #$30          compare pri to 48 (water ??)
      beq   L0766         not equal  move to end of loop
      clr   u00a6         clear the water flag
      cmpa  #$10          compare it with 16 (conditional ??)
      beq   L077e         if equal go test for observe blocks
      cmpa  #$20          compare with 32
      beq   L0787

L0766 decb                decrement cx
      bne   L0752         not zero yet loop again

      lda   $25,x         load flags in  acca
      tst   u00a6         test flag_water
      bne   L0776         not zero next test
      bita  #O_DRAWN      should be O_WATER Looks like a BUG in ours
      beq   L078b         if it equals one head for check_finish
      bra   L077a         clear that flag control first and leave
L0776 bita  #O_HRZNIGNORE should be O_LAND  Looks like a BUG in ours 
      beq   L078b
      
L077a clr   u005c         clear flag_control
      bra   L078b         head for check_finish
      
L077e lda   $26,x         load flags in acca
      bita  #O_BLKIGNORE  and with $02 but don't change 
      beq   L077a         equals zero clear flag_control and go check_finish 
      bra   L0766         then  head back in the loop

L0787 sta   u00a5         store acca at flag signal (obj_picbuff.c has =1) 
      bra   L0766        continue with loop


      
L078b lda   $02,x         load num
      bne   L07bb         if not zero were done head out

* flag signal test
      lda   u00a5         load flag_signal  
*                         operates on F03_EGOSIGNAL      
      beq   L079d         if its zero go reset the signal
*                         otherwise set the flag      
      lda   X01af         load the state.flag element
      ora   #$10          set the bits
      sta   X01af         save it back
      bra   L07a5         go test the water flag
L079d lda   X01af         load the state.flag element
      anda  #$ef          reset the bits 
      sta   X01af         save it back
      
* flag_water test      
L07a5 lda   u00a6         load flag_water     
      beq   L07b3         if zero go reset the flag
*                         otherwise set it      
      lda   X01af         load the state.flag element
      ora   #$80          set the bits
      sta   X01af         save it back
      bra   L07bb         baby we're out of here
L07b3 lda   X01af         load the state.flag element
      anda  #$7f          reset the bits
      sta   X01af         save it back

L07bb puls  y             retrieve our y and leave
      rts   


*  obj_blit(VIEW *x)   obj_blit.c
* our index reg x points to the view structure
* are 3 = x, 4 = y instead of 3-4 = x & 5-6 = y ???
*  u00a2 = cel_height
*  u00a7 = cel_trans
*  u00a8 = pb
*  u00a9
*  u00ac
*  u00ad
*  u009e = view_pri

L07be ldx   $02,s
      ldd   $08,x
      lbsr  L0074        twiddle mmu
      
      ldu   $10,x        u now is a pointer to cel_data
      lda   $02,u        cel_data[$02] loaded
      bita  #O_Block     are we testing against a block or does $80 mean something else here? 
      beq   L07d1        if zero skip next instruction
      
      lbsr  L087f        otherwise call obj_cell_mirror
      
L07d1 ldd   ,u++         load the first 2 bytes of cel_data and bump to next word
*                        cel_width is in acca we ignore 
      stb   u00a2        save as cel_height
*                        obj_blit.c has and $0F which is a divide by 16
*                        we do a multiply x 16 ???      
      lda   ,u+          cel_trans 
      asla  
      asla  
      asla  
      asla  
      sta   u00a7        save as cel_tran
      
      lda   $24,x        priority
      asla  
      asla  
      asla  
      asla  
      sta   u009e        view_pri
      
      ldb   $04,x        load the y value
      subb  u00a2        subtract the cel_height
      incb               add 1
      lda   #$a0         according to PBUF_MULT()
      mul                do the math
      addb  $03,x        add in the x value
      adca  #0000        add in the carry from multiply
      addd  #gfx_picbuff add this to the start of the screen buff addr $6040
      std   u00a8        pb pointer to the pic buffer
      ldx   u00a8        load it in an index reg
      
      lda   #$01
      sta   u00ac        set cel_invis to 1 and save
      
      bra   L0800
L07ff abx   

L0800 lda   ,u+
      beq   L082d
      ldb   -$01,u
      anda  #$f0
      andb  #$0f
      cmpa  u00a7      
      beq   L07ff
      lsra  
      lsra  
      lsra  
      lsra  
      sta   u009f      
L0814 lda   ,x
      anda  #$f0
      cmpa  #$20
      bls   L083b
      cmpa  u009e
      bhi   L085b
      lda   u009e
L0822 ora   u009f      
      sta   ,x+
      clr   u00ac
      decb  
      bne   L0814
      bra   L0800
L082d dec   u00a2
      beq   L0862
      ldx   u00a8
      leax  160,x
      stx   u00a8
      bra   L0800
L083b stx   u00ad      
      clra  
L083e cmpx  #$c8a0
      bcc   L084f
      leax  >$00A0,x
      lda   ,x
      anda  #$f0
      cmpa  #$20
      bls   L083e
L084f ldx   u00ad      
      cmpa  u009e
      bhi   L085b
      lda   ,x
      anda  #$f0
      bra   L0822
L085b leax  $01,x
      decb  
      bne   L0814
      bra   L0800
L0862 ldx   $02,s
      lda   $02,x
      bne   L087e
      lda   u00ac
      beq   L0876
      lda   X01af
      ora   #$40
      sta   X01af
      bra   L087e
L0876 lda   X01af
      anda  #$bf
      sta   X01af
L087e rts   


* obj_cel_mirror in obj_picbuff.c 
* we use different values 
L087f anda  #$30
      lsra  
      lsra  
      lsra  
      lsra  
      cmpa  $0A,x
      lbeq  L0926
      pshs  x,y,u
      lda   $0A,x
      asla  
      asla  
      asla  
      asla  
      sta   u00af
      lda   #$cf
      anda  2,u
      ora   u00af
      sta   2,u
      ldy   #gbuffend
      ldd   ,u++
      std   u00a1
      lda   ,u+
      asla  
      asla  
      asla  
      asla  
      sta   u00a7     
      stu   u00b0
L08af clrb  
      stb   u00ab
L08b2 stb   u00aa
      lda   ,u+
      beq   L08fc
      ldb   -1,u
      anda  #$f0
      andb  #$0f
      cmpa  u00a7    
      bne   L08cc
      addb  u00aa
      bra   L08b2
L08c6 ldb   ,u+
      beq   L08d4
      andb  #$0f
L08cc addb  u00aa
      stb   u00aa
      inc   u00ab
      bra   L08c6
L08d4 lda   u00aa
      nega  
      adda  u00a1
      beq   L08f1
L08db suba  #$0f
      bls   L08eb
      sta   u00aa
      lda   u00a7   
      ora   #$0f
      sta   ,y+
      lda   u00aa
      bra   L08db
L08eb adda  #$0f
      ora   u00a7  
      sta   ,y+
L08f1 leax  -1,u
      ldb   u00ab
L08f5 lda   ,-x
      sta   ,y+
      decb  
      bne   L08f5
L08fc stb   ,y+
      dec   u00a2
      bne   L08af
      tfr   y,d
      subd  #gbuffend
      stb   u00b2
      andb  #$fe
      tfr   d,x
      ldu   u00b0
      ldy   #gbuffend
L0913 ldd   ,y++
      std   ,u++
      leax  -2,x
      bne   L0913
      lda   u00b2
      lsra  
      bcc   L0924
      lda   ,y
      sta   ,u
L0924 puls  x,y,u
L0926 rts   


L0927 pshs  y
      ldx   4,s
      ldd   8,x
      lbsr  L0074        twiddle mmu
      clra  
      ldb   4,x
      leau  L0654,pcr
      lda   d,u
      std   u00a3   
      ldb   36,x
      andb  #$0f
      bne   L0948
      ora   36,x
      sta   36,x
L0948 pshs  x
      lbsr  L07be       obj_blit
      leas  2,s
      ldx   4,s
      lda   36,x
      cmpa  #$3f
      lbhi  L09d5
      leau  L0654,pcr
      ldb   u00a4
      clr   u00b3
L0962 clra  
      inc   u00b3
      tstb  
      beq   L096f
      decb  
      lda   d,u
      cmpa  u00a3   
      beq   L0962
L096f ldb   4,x
      lda   #$a0
      mul   
      addb  3,x
      adca  #0
      addd  #gfx_picbuff     $6040
      tfr   d,u
      stu   u00a8
      ldy   16,x
      ldb   1,y
      cmpb  u00b3
      bhi   L098b
      stb   u00b3
L098b lda   36,x
      anda  #$f0
      sta   u009e
      ldb   ,y
L0994 lda   ,u
      anda  #$0f
      ora   u009e
      sta   ,u+
      decb  
      bne   L0994
      dec   u00b3
      beq   L09d5
      ldu   u00a8
      ldb   ,y
      decb  
L09a8 leau  -160,u
      tfr   u,x
      lda   ,u
      anda  #$0f
      ora   u009e
      sta   ,u
      clra  
      lda   d,u
      anda  #$0f
      ora   u009e
      abx   
      sta   ,x
      dec   u00b3
      bne   L09a8
      ldb   ,y
      subb  #2
      leau  1,u
L09ca lda   ,u
      anda  #$0f
      ora   u009e
      sta   ,u+
      decb  
      bne   L09ca
L09d5 puls  y
      rts   


L09d8 ldu   2,s
      ldd   12,u
      lbsr  L0074      twiddle mmu
      ldu   2,s
      ldd   8,u
      std   u00a1
      clr   u00a0
      ldb   7,u
      lda   #$a0
      mul   
      addb  6,u
      adca  #0
      addd  #gfx_picbuff     $6040
      ldu   10,u
L09f5 std   u00a8
      addd  u00a0
      std   u00ad   
      ldx   u00a8
L09fd ldd   ,x++
      std   ,u++
      cmpx  u00ad   
      bcs   L09fd
      ldd   u00a8
      addd  #$00a0
      dec   u00a2
      bne   L09f5
      rts   


L0a0f ldu   2,s
      ldd   12,u
      lbsr  L0074     twiddle mmu
      ldu   2,s
      ldd   8,u
      std   u00a1
      clr   u00a0
      ldb   7,u
      lda   #$a0
      mul   
      addb  6,u
      adca  #0
      addd  #gfx_picbuff     $6040
      ldu   10,u
L0a2c std   u00a8
      addd  u00a0
      std   u00ad   
      ldx   u00a8
L0a34 ldd   ,u++
      std   ,x++
      cmpx  u00ad   
      bcs   L0a34
      ldd   u00a8
      addd  #$00a0
      dec   u00a2
      bne   L0a2c
      rts   
      
      fcb $00,$00,$00,$00
      fcb $00,$00,$00,$00
      fcc "shdw"
      fcb $00

      emod 

eom   equ *

      end
 