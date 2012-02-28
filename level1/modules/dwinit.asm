*******************************************************
*
* DWInit
*    Initialize DriveWire for CoCo Bit Banger

DWInit
			pshs		a,x
               ldx       #PIA1Base           $FF20
               clr       1,x                 clear CD
               lda       #%11111110
               sta       ,x
               lda       #%00110100
               sta       1,x
               lda       ,x
               puls		a,x,pc
