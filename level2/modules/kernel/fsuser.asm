* F$User entry point
FSUser   ldx   <D.Proc      get current process dsc ptr
         ldd   R$Y,u        get requested user number
         std   P$User,x     save new user # in process descriptor
         clrb               no error
         rts                and return
