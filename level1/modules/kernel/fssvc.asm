FSSvc    ldy   R$Y,u                   get caller's Y
         bra   InstSSvc                install the service
SSvcLoop tfr   b,a                     put syscall code in A
         anda  #$7F                    kill hi bit
         cmpa  #$7F                    is code $7F?
         beq   SSvcOK
         cmpa  #$37                    compare against highest call allowed
         bcs   SSvcOK                  branch if A less than highest call
         comb
         ldb   #E$ISWI
         rts
SSvcOK   lslb
         ldu   <D.SysDis
         leau  b,u                     U points to entry in table
         ldd   ,y++                    get addr of func
         leax  d,y                     get absolute addr
         stx   ,u                      store in system table
         bcs   InstSSvc                branch if system only
         stx   <$70,u                  else store in user table too
InstSSvc ldb   ,y+                     get system call code in B
         cmpb  #$80                    end of table?
         bne   SSvcLoop                branch if not
         rts
