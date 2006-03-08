**************************************************
* System Call: F$AProc
*
* Function: Insert process into active process queue
*
* Input:  X = Address of process descriptor
*
* Output: None (U and Y are preserved)
*
* Error:  CC = C bit set; B = error code
*
*              "An Ode to Dr. Lee"
*             (1:27PM, Feb 23, 2006)
*
*   Sitting in CMPS 455, I listen to Dr. Lee,
*   His teaching style is as awful as any can be.
*   Operating System Principles I have seen many times before,
*   And as a result, this class is a major bore.
*   As he talks about file systems, I work on NitrOS-9,
*   even though I pay no attention, I do not fall behind.
*
*                                  - Anonymous Student who returned
*                                    to university to complete his
*                                    computer science degree while working
*                                    on The NitrOS-9 Project.
*
FAProc   ldx   R$X,u				get ptr to process to activate
L021A    pshs  u,y					save U/Y on stack
         ldu   #(D.AProcQ-P$Queue)
         bra   L0228
L0221    ldb   P$Age,u				get process age
         incb						update it
         beq   L0228				branch if wrap
         stb   P$Age,u				save it back to proc desc
L0228    ldu   P$Queue,u			get pointer to queue this process queue
         bne   L0221				branch if process is in active queue
         ldu   #(D.AProcQ-P$Queue)
         lda   P$Prior,x			get process priority
         sta   P$Age,x				save it as age (How long its been around)
         orcc  #IntMasks			mask interrupts
L0235    leay  ,u					point Y to current process
         ldu   P$Queue,u			get pointer to queue
         beq   L023F
         cmpa  P$Age,u				match process ages?
         bls   L0235				no, skip update
L023F    stu   P$Queue,x
         stx   P$Queue,y
         clrb
         puls  pc,u,y				restore U/Y and return

