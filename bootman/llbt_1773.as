         NAM    llbt_1773
         TTL    WD1773 low-level booter

         SECTION code

llbt_1773:
         lbsr   llinit
         lbsr   llread
         lbsr   llwrite
         lbsr   llterm
         lbsr   llinfo

llinit
llread
llwrite
llterm
         rts

llinfo   leax   info,pcr
         rts

info     fcc    "Floppy disk drive"
         fcb    0

         ENDSECT
