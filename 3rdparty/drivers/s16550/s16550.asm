00001                            nam   s16550
00002                            ttl   os9 device driver    
00003                   
00004        * Disassembled 96/09/20 17:17:26 by Disasm v1.5 (C) 1988 by RML
00005                   
00006                            ifp1
00007                            use   /dd/defs/os9defs
00008                            endc
00009   00E1            tylg     set   Drivr+Objct   
00010   0081            atrv     set   ReEnt+rev
00011   0001            rev      set   $01
00012   0000 87CD0799            mod   eom,name,tylg,atrv,start,size

00013 D 0000            u0000    rmb   1     V.PAGE
00014 D 0001            u0001    rmb   2     V.PORT
00015 D 0003            u0003    rmb   1     V.LPRC
00016 D 0004            u0004    rmb   1     V.BUSY
00017 D 0005            u0005    rmb   1     V.WAKE
00018 D 0006            u0006    rmb   1     V.TYPE 
                        u0007    rmb   1     V.LINE
00019 D 0008            u0008    rmb   1     V.PAUS
00020 D 0009            u0009    rmb   2     V.DEV2
00022 D 000B            u000B    rmb   1     V.INTR
00023 D 000C            u000C    rmb   1     V.QUIT
00024 D 000D            u000D    rmb   1     V.PCHR
00025 D 000E            u000E    rmb   1     V.ERR
00026 D 000F            u000F    rmb   1     V.XON
00027 D 0010            u0010    rmb   4     V.XOFF
                        u0011    rmb   1     V.KANJI
                        u0012    rmb   2     V.KBUF
00028 D 0014            u0014    rmb   2     V.MODADR
00029 D 0016            u0016    rmb   2     V.PDLHD
                        u0018    rmb   5     V.RSV
00030 D 001D            u001D    rmb   1    
00031 D 001E            u001E    rmb   1     
00032 D 001F            u001F    rmb   1
00033 D 0020            u0020    rmb   1
00034 D 0021            u0021    rmb   1
00035 D 0022            u0022    rmb   1
00036 D 0023            u0023    rmb   2
00037 D 0025            u0025    rmb   2
00038 D 0027            u0027    rmb   1     * signal code (for send)
00039 D 0028            u0028    rmb   1
00040 D 0029            u0029    rmb   1
00041 D 002A            u002A    rmb   2
00042 D 002C            u002C    rmb   2
00043 D 002E            u002E    rmb   2
00044 D 0030            u0030    rmb   2
00045 D 0032            u0032    rmb   2     V.BUFADDR
00046 D 0034            u0034    rmb   1
00047 D 0035            u0035    rmb   1
00048 D 0036            u0036    rmb   2     V.BUFSIZ
00049 D 0038            u0038    rmb   2     xmit buff addr?
00050 D 003A            u003A    rmb   1
00051 D 003B            u003B    rmb   1
00052 D 003C            u003C    rmb   2
00053 D 003E            u003E    rmb   2
00054 D 0040            u0040    rmb   1
00055 D 0041            u0041    rmb   2
00056 D 0043            u0043    rmb   1
00057 D 0044            u0044    rmb   52
00058 D 0078            u0078    rmb   8
00059 D 0080            u0080    rmb   128   * ???baud table???

00060 D 0100            size     equ   .
00061   000D 03                  fcb   $03 
00062   000E            name     equ   *
00063   000E 73313635            fcs   /s16550/
00064   0014 10                  fcb   $10 
00065   0015 03         L0015    fcb   $03 

00066   0016            start    equ   *
00067   0016 16005A              lbra  Iniz       |SCF jump table
00068   0019 160160              lbra  Read       |
00069   001C 160114              lbra  Write      |
00070   001F 1601EC              lbra  GetSta     |
00071   0022 160324              lbra  SetSta     |
*                                      Term       |

00072   0025 5F                  clrb  
00073   0026 340D                pshs  dp,b,cc
00074   0028 1704FB              lbsr  UtoDP

00075   002B 1A50                orcc  #$50
00076   002D 4F                  clra  
00077   002E DD34                std   <u0034
00078   0030 9E32                ldx   <u0032
00079   0032 9F2C                stx   <u002C
00080   0034 9F2E                stx   <u002E
00081   0036 3416                pshs  x,b,a
00082   0038 E664                ldb   $04,s
00083   003A 1F9A                tfr   b,cc
00084   003C BE0050              ldx   >$0050
00085   003F A684                lda   ,x
00086   0041 9704                sta   <V.BUSY
00087   0043 9703                sta   <V.LPRC
00088   0045 0D40       L0045    tst   <u0040
00089   0047 2608                bne   L0051

00090   0049 9E01                ldx   <V.PORT
00091   004B E605                ldb   $05,x
00092   004D C420                andb  #$20
00093   004F 260D                bne   exit       *exit routine

00094   0051 1704BA     L0051    lbsr  L050E
00095   0054 EC62                ldd   $02,s
00096   0056 DD2C                std   <u002C
00097   0058 ECE4                ldd   ,s
00098   005A DD34                std   <u0034
00099   005C 20E7                bra   L0045

00100   005E 3264       exit     leas  $04,s      * EXIT-----------------------
00101   0060 6F01                clr   $01,x
00102   0062 6F04                clr   $04,x
00103   0064 DC36                ldd   <V.BUFSIZ   |num bytes to return
00104   0066 DE32                ldu   <V.BUFADDR  |st addr ram to return
00105   0068 103F29              os9   F$SRtMem    |return system memory
00106   006B 8E0000              ldx   #$0000      |
00107   006E 103F2A              os9   F$IRQ       |remove from poll
00108   0071 358D                puls  pc,dp,b,cc

*** crash into init from exit? ***

00109   0073 5F         Iniz     clrb             
00110   0074 340D                pshs  dp,b,cc
00111   0076 1704AD              lbsr  UtoDP

00112   0079 DC01                ldd   <u0001      |dev. base addr
00113   007B C30002              addd  #$0002      |status register=base+2
00114   007E 3420                pshs  y           dev.desc. addr>stack
00115   0080 308D06CF            leax  >Data,pcr   |addr packet
00116   0084 318D04B3            leay  >IRQser,pcr |addr irq service routine
00117   0088 103F2A              os9   F$IRQ       |add to poll
00118   008B 3520                puls  y           dev.desc. addr
00119   008D 2406                bcc   checkdesc

00120   008F 3503                puls  a,cc
00121   0091 1A01                orcc  #$01
00122   0093 3588                puls  pc,dp
00123   0095 A6A811    checkdesc lda   <$11,y     bytes in init table
00124   0098 811C                cmpa  #$1C       
00125   009A 230E                bls   L00AA

00126   009C A6A82E              lda   <$2E,y
00127   009F 8410                anda  #$10
00128   00A1 971F                sta   <u001F
00129   00A3 A6A82E              lda   <$2E,y
00130   00A6 840F                anda  #$0F
00131   00A8 2602                bne   L00AC

00132   00AA 8601       L00AA    lda   #$01
00133   00AC 5F         L00AC    clrb  
00134   00AD 3440                pshs  u          save U
00135   00AF 103F28              os9   F$SRqMem    |Request System RAM
                                                    |(D=byte cnt)
00136   00B2 1F31                tfr   u,x         |start addr to x
00137   00B4 3540                puls  u          restore U
00138   00B6 240D                bcc   L00C5       |error?

00139   00B8 E761                stb   $01,s
00140   00BA 8E0000              ldx   #$0000      set remove
00141   00BD 103F2A              os9   F$IRQ       Set IRQ (remove from poll)
00142   00C0 350D                puls  dp,b,cc
00143   00C2 1A01                orcc  #$01
00144   00C4 39                  rts              

00145   00C5 9F32       L00C5    stx   <u0032
00146   00C7 9F2C                stx   <u002C
00147   00C9 9F2E                stx   <u002E
00148   00CB DD36                std   <u0036
00149   00CD 308B                leax  d,x
00150   00CF 9F30                stx   <u0030
00151   00D1 1F89                tfr   a,b
00152   00D3 4F                  clra  
00153   00D4 CB03                addb  #$03
00154   00D6 C40C                andb  #$0C
00155   00D8 58                  lslb  
00156   00D9 58                  lslb  
00157   00DA 58                  lslb  
00158   00DB 3406                pshs  b,a
00159   00DD DC36                ldd   <u0036
00160   00DF A3E1                subd  ,s++
00161   00E1 DD2A                std   <u002A
00162   00E3 30C844              leax  <u0044,u
00163   00E6 9F3E                stx   <u003E
00164   00E8 9F38                stx   <u0038
00165   00EA 9F3A                stx   <u003A
00166   00EC 30C90100            leax  >u0100,u
00167   00F0 9F3C                stx   <u003C
00168   00F2 CC00BC              ldd   #$00BC
00169   00F5 DD41                std   <u0041
00170   00F7 0F34                clr   <u0034
00171   00F9 0F35                clr   <u0035
00172   00FB 0F40                clr   <u0040
00173   00FD ECA826              ldd   <$26,y
00174   0100 DD1D                std   <u001D
00175   0102 170203              lbsr  L0308

00176   0105 9E01                ldx   <V.PORT
00177   0107 C610                ldb   #$10
00178   0109 A605       L0109    lda   $05,x
00179   010B A684                lda   ,x
00180   010D 5A                  decb  
00181   010E 26F9                bne   L0109

00182   0110 1A50                orcc  #$50
00183   0112 A68DFEFF            lda   >L0015,pcr
00184   0116 2B03                bmi   L011B

00185   0118 B7FF7F              sta   >$FF7F     * set mpi slot
00186   011B B6FF23     L011B    lda   >$FF23     * CART IRQ flag
00187   011E 84FC                anda  #$FC
00188   0120 B7FF23              sta   >$FF23     * CART IRQ ctrl
00189   0123 B6FF22              lda   >$FF22     * ???ram size???
00190   0126 B60092              lda   >$0092
00191   0129 8A01                ora   #$01
00192   012B B70092              sta   >$0092
00193   012E B7FF92              sta   >$FF92     * IRQENR irq enable 
00194   0131 358D                puls  pc,dp,b,cc
00195   0133 5F         Write    clrb  
00196   0134 340D                pshs  dp,b,cc
00197   0136 1703ED              lbsr  UtoDP      u=dev mem area

00198   0139 9E38                ldx   <u0038
00199   013B A780                sta   ,x+        character to write
00200   013D 9C3C                cmpx  <u003C
00201   013F 2502                bcs   L0143

00202   0141 9E3E                ldx   <u003E
00203   0143 9C3A       L0143    cmpx  <u003A
00204   0145 260A                bne   L0151

00205   0147 3410                pshs  x
00206   0149 8D19                bsr   L0164

00207   014B 3510                puls  x
00208   014D 24F4                bcc   L0143
00209   014F 2006                bra   L0157

00210   0151 9F38       L0151    stx   <u0038
00211   0153 0C40                inc   <u0040
00212   0155 8D02                bsr   L0159

00213   0157 358D       L0157    puls  pc,dp,b,cc
00214   0159 860F       L0159    lda   #$0F
00215   015B 2002                bra   L015F

00216   015D 860D                lda   #$0D
00217   015F 9E01       L015F    ldx   <V.PORT
00218   0161 A701                sta   $01,x
00219   0163 39                  rts   

00220   0164 1703A7     L0164    lbsr  L050E

00221   0167 BE0050              ldx   >$0050
00222   016A E68819              ldb   <$19,x
00223   016D 2704                beq   L0173

00224   016F C103                cmpb  #$03
00225   0171 2306                bls   L0179

00226   0173 E60C       L0173    ldb   $0C,x
00227   0175 C402                andb  #$02
00228   0177 2702                beq   L017B

00229   0179 1A01       L0179    orcc  #$01
00230   017B 39         L017B    rts   
00231   017C 5F         Read     clrb  
00232   017D 340D                pshs  dp,b,cc
00233   017F 1703A4              lbsr  UtoDP      dev.mem. to dp

00234   0182 D60E                ldb   <V.ERR
00235   0184 262C                bne   ReadErr

00236   0186 1A50       L0186    orcc  #$50       FIRQ,IRQ mask
00237   0188 DC34                ldd   <u0034
00238   018A 271B                beq   L01A7

00239   018C 10830010            cmpd  #$0010
00240   0190 2602                bne   L0194

00241   0192 8D33                bsr   L01C7

00242   0194 830001     L0194    subd  #$0001
00243   0197 DD34                std   <u0034
00244   0199 9E2E                ldx   <u002E
00245   019B A680                lda   ,x+
00246   019D 9C30                cmpx  <u0030
00247   019F 2602                bne   L01A3

00248   01A1 9E32                ldx   <u0032
00249   01A3 9F2E       L01A3    stx   <u002E
00250   01A5 358D                puls  pc,dp,b,cc

00251   01A7 8DBB       L01A7    bsr   L0164

00252   01A9 2502                bcs   L01AD

00253   01AB 20D9                bra   L0186

00254   01AD 350B       L01AD    puls  dp,a,cc
00255   01AF 1A01                orcc  #$01
00256   01B1 39                  rts   

00257   01B2 E7A83A     ReadErr  stb   <$3A,y     b=V.ERR
00258   01B5 0F0E                clr   <V.ERR
00259   01B7 350B                puls  dp,a,cc
00260   01B9 C520                bitb  #$20       $20=bit 5
00261   01BB 2705                beq   L01C2

00262   01BD C6F4                ldb   #$F4
00263   01BF 1A01                orcc  #$01
00264   01C1 39                  rts   

00265   01C2 C6DC       L01C2    ldb   #$DC
00266   01C4 1A01                orcc  #$01
00267   01C6 39                  rts   

00268   01C7 3407       L01C7    pshs  b,a,cc
00269   01C9 9E01                ldx   <V.PORT
00270   01CB D628                ldb   <u0028
00271   01CD C570                bitb  #$70
00272   01CF 2712                beq   L01E3

00273   01D1 C520                bitb  #$20
00274   01D3 2710                beq   L01E5

00275   01D5 1A50                orcc  #$50
00276   01D7 D628                ldb   <u0028
00277   01D9 C4DF                andb  #$DF
00278   01DB D728                stb   <u0028
00279   01DD A604                lda   $04,x
00280   01DF 8A0A                ora   #$0A
00281   01E1 A704                sta   $04,x
00282   01E3 3587       L01E3    puls  pc,b,a,cc
00283   01E5 C510       L01E5    bitb  #$10
00284   01E7 2710                beq   L01F9

00285   01E9 1A50                orcc  #$50
00286   01EB D628                ldb   <u0028
00287   01ED C4EF                andb  #$EF
00288   01EF D728                stb   <u0028
00289   01F1 A604                lda   $04,x
00290   01F3 8A05                ora   #$05
00291   01F5 A704                sta   $04,x
00292   01F7 20EA                bra   L01E3

00293   01F9 C540       L01F9    bitb  #$40
00294   01FB 27E6                beq   L01E3

00295   01FD D60F                ldb   <V.XON
00296   01FF 1A50                orcc  #$50
00297   0201 D743                stb   <u0043
00298   0203 17FF53              lbsr  L0159
00299   0206 D628                ldb   <u0028
00300   0208 C4BF                andb  #$BF
00301   020A D728                stb   <u0028
00302   020C 20D5                bra   L01E3

00303   020E 5F         GetSta   clrb  
00304   020F 340D                pshs  dp,b,cc
00305   0211 170312              lbsr  UtoDP
00306   0214 8101                cmpa  #$01
00307   0216 2618                bne   L0230

00308   0218 DC34                ldd   <u0034
00309   021A 270C                beq   L0228

00310   021C 4D                  tsta  
00311   021D 2702                beq   L0221

00312   021F C6FF                ldb   #$FF
00313   0221 AE26       L0221    ldx   $06,y
00314   0223 E702                stb   $02,x
00315   0225 1600DE              lbra  L0306

00316   0228 3505       L0228    puls  b,cc
00317   022A 1A01                orcc  #$01
00318   022C C6F6                ldb   #$F6
00319   022E 3588                puls  pc,dp
00320   0230 8128       L0230    cmpa  #$28
00321   0232 2624                bne   L0258

00322   0234 DC1D                ldd   <u001D
00323   0236 0D1F                tst   <u001F
00324   0238 2706                beq   L0240

00325   023A C504                bitb  #$04
00326   023C 2602                bne   L0240

00327   023E C4F7                andb  #$F7
00328   0240 AE26       L0240    ldx   $06,y
00329   0242 ED06                std   $06,x
00330   0244 5F                  clrb  
00331   0245 9620                lda   <u0020
00332   0247 8580                bita  #$80
00333   0249 2602                bne   L024D

00334   024B CA10                orb   #$10
00335   024D 8520       L024D    bita  #$20
00336   024F 2602                bne   L0253

00337   0251 CA40                orb   #$40
00338   0253 E702       L0253    stb   $02,x
00339   0255 1600AE              lbra  L0306
00340   0258 8106       L0258    cmpa  #$06
00341   025A 2604                bne   L0260

00342   025C 5F                  clrb  
00343   025D 1600A6              lbra  L0306
00344   0260 81D0       L0260    cmpa  #$D0
00345   0262 266A                bne   L02CE

00346   0264 D60E                ldb   <V.ERR
00347   0266 1026FF48            lbne  L01B2
00348   026A 1A50                orcc  #$50
00349   026C DC30                ldd   <u0030
00350   026E 932E                subd  <u002E
00351   0270 109334              cmpd  <u0034
00352   0273 2504                bcs   L0279

00353   0275 DC34                ldd   <u0034
00354   0277 27AF                beq   L0228

00355   0279 1CAF       L0279    andcc #$AF
00356   027B EE26                ldu   $06,y
00357   027D 10A346              cmpd  V.TYPE,u
00358   0280 2302                bls   L0284

00359   0282 EC46                ldd   V.TYPE,u
00360   0284 ED46       L0284    std   V.TYPE,u
00361   0286 2744                beq   L02CC

00362   0288 3406                pshs  b,a
00363   028A 3470                pshs  u,y,x
00364   028C ED62                std   $02,s
00365   028E DC2E                ldd   <u002E
00366   0290 EDE4                std   ,s
00367   0292 EC44                ldd   V.BUSY,u
00368   0294 ED64                std   $04,s
00369   0296 BE0050              ldx   >$0050
00370   0299 E606                ldb   $06,x      * |dest task num
00371   029B B600D0              lda   >$00D0     * |source task num
00372   029E 3570                puls  u,y,x      * |dest pt, bytes, srce pt
00373   02A0 103F38              os9   F$Move     * |move data
00374   02A3 1A50                orcc  #$50
00375   02A5 DC34                ldd   <u0034
00376   02A7 A3E4                subd  ,s
00377   02A9 DD34                std   <u0034
00378   02AB 1CAF                andcc #$AF
00379   02AD 10830010            cmpd  #$0010
00380   02B1 240B                bcc   L02BE

00381   02B3 E3E4                addd  ,s
00382   02B5 10830010            cmpd  #$0010
00383   02B9 2503                bcs   L02BE

00384   02BB 17FF09              lbsr  L01C7

00385   02BE 3506       L02BE    puls  b,a
00386   02C0 9E2E                ldx   <u002E
00387   02C2 308B                leax  d,x
00388   02C4 9C30                cmpx  <u0030
00389   02C6 2602                bne   L02CA

00390   02C8 9E32                ldx   <u0032
00391   02CA 9F2E       L02CA    stx   <u002E
00392   02CC 2038       L02CC    bra   L0306

00393   02CE 81D2       L02CE    cmpa  #$D2
00394   02D0 2613                bne   L02E5

00395   02D2 CC0B04              ldd   #$0B04
00396   02D5 AE26                ldx   $06,y
00397   02D7 ED01                std   $01,x
00398   02D9 CC0707              ldd   #$0707
00399   02DC ED04                std   $04,x
00400   02DE CC0001              ldd   #$0001
00401   02E1 ED06                std   $06,x
00402   02E3 2021                bra   L0306

00403   02E5 8126       L02E5    cmpa  #$26
00404   02E7 2615                bne   L02FE

00405   02E9 AE26                ldx   $06,y
00406   02EB 10AE23              ldy   $03,y
00407   02EE 10AE24              ldy   $04,y
00408   02F1 4F                  clra  
00409   02F2 E6A82C              ldb   <$2C,y
00410   02F5 ED04                std   $04,x
00411   02F7 E6A82D              ldb   <$2D,y
00412   02FA ED06                std   $06,x
00413   02FC 2008                bra   L0306

00414   02FE 3505       L02FE    puls  b,cc
00415   0300 1A01                orcc  #$01
00416   0302 C6D0                ldb   #$D0
00417   0304 3588                puls  pc,dp
00418   0306 358D       L0306    puls  pc,dp,b,cc
00419   0308 3440       L0308    pshs  u
00420   030A 1F98                tfr   b,a
00421   030C 338D0446            leau  >L0756,pcr
00422   0310 9E01                ldx   <V.PORT
00423   0312 C40F                andb  #$0F
00424   0314 58                  lslb  
00425   0315 58                  lslb  
00426   0316 33C5                leau  b,u
00427   0318 44                  lsra  
00428   0319 44                  lsra  
00429   031A 44                  lsra  
00430   031B 44                  lsra  
00431   031C 44                  lsra  
00432   031D 8803                eora  #$03
00433   031F 8403                anda  #$03
00434   0321 3403                pshs  a,cc
00435   0323 961D                lda   <u001D
00436   0325 44                  lsra  
00437   0326 44                  lsra  
00438   0327 8438                anda  #$38
00439   0329 AA61                ora   $01,s
00440   032B A761                sta   $01,s
00441   032D 8A80                ora   #$80
00442   032F 1A50                orcc  #$50
00443   0331 A703                sta   $03,x
00444   0333 ECC1                ldd   ,u++
00445   0335 1E89                exg   a,b
00446   0337 ED84                std   ,x
00447   0339 A661                lda   $01,s
00448   033B A703                sta   $03,x
00449   033D ECC4                ldd   ,u
00450   033F 9721                sta   <u0021
00451   0341 8A06                ora   #$06
00452   0343 A702                sta   $02,x
00453   0345 D729                stb   <u0029
00454   0347 35C3                puls  pc,u,a,cc
00455   0349 5F         SetSta   clrb  
00456   034A 340D                pshs  dp,b,cc
00457   034C 1701D7              lbsr  UtoDP

00458   034F 81D1                cmpa  #$D1
00459   0351 267F                bne   L03D2

00460   0353 EE26                ldu   $06,y
00461   0355 AE44                ldx   V.BUSY,u
00462   0357 EC46                ldd   V.TYPE,u
00463   0359 3416                pshs  x,b,a
00464   035B 2764                beq   L03C1

00465   035D DC3A       L035D    ldd   <u003A
00466   035F 10933E              cmpd  <u003E
00467   0362 2607                bne   L036B

00468   0364 DC3C                ldd   <u003C
00469   0366 830001              subd  #$0001
00470   0369 200A                bra   L0375

00471   036B 830001     L036B    subd  #$0001
00472   036E 109338              cmpd  <u0038
00473   0371 2402                bcc   L0375

00474   0373 DC3C                ldd   <u003C
00475   0375 9338       L0375    subd  <u0038
00476   0377 274D                beq   L03C6

00477   0379 10A3E4              cmpd  ,s
00478   037C 2302                bls   L0380

00479   037E ECE4                ldd   ,s
00480   0380 3406       L0380    pshs  b,a
00481   0382 BE0050              ldx   >$0050
00482   0385 A606                lda   $06,x
00483   0387 F600D0              ldb   >$00D0
00484   038A DE38                ldu   <u0038
00485   038C AE64                ldx   $04,s
00486   038E 10AEE4              ldy   ,s
00487   0391 1A50                orcc  #$50
00488   0393 103F38              os9   F$Move   
00489   0396 ECE4                ldd   ,s
00490   0398 DE38                ldu   <u0038
00491   039A 33CB                leau  d,u
00492   039C 11933C              cmpu  <u003C
00493   039F 2502                bcs   L03A3

00494   03A1 DE3E                ldu   <u003E
00495   03A3 DF38       L03A3    stu   <u0038
00496   03A5 4F                  clra  
00497   03A6 D640                ldb   <u0040
00498   03A8 E3E4                addd  ,s
00499   03AA D740                stb   <u0040
00500   03AC 1CAF                andcc #$AF
00501   03AE ECE4                ldd   ,s
00502   03B0 AE64                ldx   $04,s
00503   03B2 308B                leax  d,x
00504   03B4 AF64                stx   $04,s
00505   03B6 EC62                ldd   $02,s
00506   03B8 A3E1                subd  ,s++
00507   03BA EDE4                std   ,s
00508   03BC 269F                bne   L035D

00509   03BE 17FD98              lbsr  L0159
00510   03C1 3264       L03C1    leas  $04,s
00511   03C3 160146              lbra  L050C
00512   03C6 1A50       L03C6    orcc  #$50
00513   03C8 17FD8E              lbsr  L0159
00514   03CB 17FD96              lbsr  L0164
00515   03CE 248D                bcc   L035D

00516   03D0 20EF                bra   L03C1

00517   03D2 8128       L03D2    cmpa  #$28
00518   03D4 262C                bne   L0402

00519   03D6 AE26                ldx   $06,y
00520   03D8 EC06                ldd   $06,x
00521   03DA 0D1F                tst   <u001F
00522   03DC 2706                beq   L03E4

00523   03DE C504                bitb  #$04
00524   03E0 2602                bne   L03E4

00525   03E2 CA08                orb   #$08
00526   03E4 DD1D       L03E4    std   <u001D
00527   03E6 17FF1F              lbsr  L0308
00528   03E9 0F22                clr   <u0022
00529   03EB 0D0C                tst   <V.QUIT
00530   03ED 2610                bne   L03FF

00531   03EF 0D0B                tst   <V.INTR
00532   03F1 260C                bne   L03FF

00533   03F3 0D0D                tst   <V.PCHR
00534   03F5 2608                bne   L03FF

00535   03F7 D61D                ldb   <u001D
00536   03F9 C504                bitb  #$04
00537   03FB 2602                bne   L03FF

00538   03FD 0C22                inc   <u0022
00539   03FF 16010A     L03FF    lbra  L050C
00540   0402 812B       L0402    cmpa  #$2B
00541   0404 2617                bne   L041D

00542   0406 9E01                ldx   <V.PORT
00543   0408 A604                lda   $04,x
00544   040A 3412                pshs  x,a
00545   040C 84FA                anda  #$FA
00546   040E A704                sta   $04,x
00547   0410 8E001E              ldx   #$001E
00548   0413 103F0A              os9   F$Sleep  
00549   0416 3512                puls  x,a
00550   0418 A704                sta   $04,x
00551   041A 1600EF              lbra  L050C
00552   041D 811D       L041D    cmpa  #$1D
00553   041F 2640                bne   L0461

00554   0421 1A50                orcc  #$50
00555   0423 9E01                ldx   <V.PORT
00556   0425 9628                lda   <u0028
00557   0427 8A08                ora   #$08
00558   0429 9728                sta   <u0028
00559   042B 8D50                bsr   L047D

00560   042D 4F                  clra  
00561   042E A784                sta   ,x
00562   0430 1A50       L0430    orcc  #$50
00563   0432 A605                lda   $05,x
00564   0434 8540                bita  #$40
00565   0436 260C                bne   L0444

00566   0438 1CAF                andcc #$AF
00567   043A 8E0001              ldx   #$0001
00568   043D 103F0A              os9   F$Sleep  
00569   0440 9E01                ldx   <V.PORT
00570   0442 20EC                bra   L0430

00571   0444 8A40       L0444    ora   #$40
00572   0446 A703                sta   $03,x
00573   0448 8E001E              ldx   #$001E
00574   044B 103F0A              os9   F$Sleep  
00575   044E 9E01                ldx   <V.PORT
00576   0450 1A50                orcc  #$50
00577   0452 A603                lda   $03,x
00578   0454 84BF                anda  #$BF
00579   0456 A703                sta   $03,x
00580   0458 9628                lda   <u0028
00581   045A 84F7                anda  #$F7
00582   045C 9728                sta   <u0028
00583   045E 1600AB              lbra  L050C
00584   0461 811A       L0461    cmpa  #$1A
00585   0463 262B                bne   L0490

00586   0465 A625                lda   $05,y
00587   0467 AE26                ldx   $06,y
00588   0469 E605                ldb   $05,x
00589   046B 1A50                orcc  #$50
00590   046D 9E34                ldx   <u0034
00591   046F 2605                bne   L0476

00592   0471 DD25                std   <u0025
00593   0473 160096              lbra  L050C
00594   0476 3501       L0476    puls  cc
00595   0478 103F08              os9   F$Send   
00596   047B 358C                puls  pc,dp,b
00597   047D 860D       L047D    lda   #$0D
00598   047F A701                sta   $01,x
00599   0481 0F40                clr   <u0040
00600   0483 DC3E                ldd   <u003E
00601   0485 DD3A                std   <u003A
00602   0487 DD38                std   <u0038
00603   0489 9621                lda   <u0021
00604   048B 8A04                ora   #$04
00605   048D A702                sta   $02,x
00606   048F 39                  rts   
00607   0490 811B       L0490    cmpa  #$1B
00608   0492 260C                bne   L04A0

00609   0494 A625                lda   $05,y
00610   0496 9125                cmpa  <u0025
00611   0498 2604                bne   L049E

00612   049A 4F                  clra  
00613   049B 5F                  clrb  
00614   049C DD25                std   <u0025
00615   049E 206C       L049E    bra   L050C

00616   04A0 819A       L04A0    cmpa  #$9A
00617   04A2 260A                bne   L04AE

00618   04A4 A625                lda   $05,y
00619   04A6 AE26                ldx   $06,y
00620   04A8 E605                ldb   $05,x
00621   04AA DD23                std   <u0023
00622   04AC 205E                bra   L050C

00623   04AE 819B       L04AE    cmpa  #$9B
00624   04B0 260E                bne   L04C0

00625   04B2 1A50                orcc  #$50
00626   04B4 A625                lda   $05,y
00627   04B6 9123                cmpa  <u0023
00628   04B8 2604                bne   L04BE

00629   04BA 4F                  clra  
00630   04BB 5F                  clrb  
00631   04BC DD23                std   <u0023
00632   04BE 204C       L04BE    bra   L050C

00633   04C0 812A       L04C0    cmpa  #$2A
00634   04C2 2615                bne   L04D9

00635   04C4 1A50                orcc  #$50
00636   04C6 A625                lda   $05,y
00637   04C8 8E0000              ldx   #$0000
00638   04CB 9125                cmpa  <u0025
00639   04CD 2602                bne   L04D1

00640   04CF 9F25                stx   <u0025
00641   04D1 9123       L04D1    cmpa  <u0023
00642   04D3 2602                bne   L04D7

00643   04D5 9F23                stx   <u0023
00644   04D7 2033       L04D7    bra   L050C

00645   04D9 8129       L04D9    cmpa  #$29
00646   04DB 2627                bne   L0504

00647   04DD 9E01                ldx   <V.PORT
00648   04DF 1A50                orcc  #$50
00649   04E1 0D28                tst   <u0028
00650   04E3 2619                bne   L04FE

00651   04E5 A606                lda   $06,x
00652   04E7 84B0                anda  #$B0
00653   04E9 9720                sta   <u0020
00654   04EB 5F                  clrb  
00655   04EC 8510                bita  #$10
00656   04EE 2602                bne   L04F2

00657   04F0 CA02                orb   #$02
00658   04F2 8520       L04F2    bita  #$20
00659   04F4 2602                bne   L04F8

00660   04F6 CA01                orb   #$01
00661   04F8 D728       L04F8    stb   <u0028
00662   04FA 860F                lda   #$0F
00663   04FC A704                sta   $04,x
00664   04FE C60F       L04FE    ldb   #$0F
00665   0500 E701                stb   $01,x
00666   0502 2008                bra   L050C

00667   0504 3505       L0504    puls  b,cc
00668   0506 1A01                orcc  #$01
00669   0508 C6D0                ldb   #$D0
00670   050A 3588                puls  pc,dp
00671   050C 358D       L050C    puls  pc,dp,b,cc
00672   050E 1A50       L050E    orcc  #$50
00673   0510 FC0050              ldd   >$0050
00674   0513 9705                sta   <V.WAKE
00675   0515 1F01                tfr   d,x
00676   0517 A60C                lda   $0C,x
00677   0519 8A08                ora   #$08
00678   051B A70C                sta   $0C,x
00679   051D 8E0001              ldx   #$0001     * |remainer of slice
00680   0520 103F0A              os9   F$Sleep    * |sleep
00681   0523 1CAF                andcc #$AF       * |carry set on error
00682   0525 39                  rts   

00683   0526 3440       UtoDP    pshs  u     U to DP, clean stack
00684   0528 3508                puls  dp    |
00685   052A 3261                leas  $01,s |
00686   052C 39                  rts         |

00687   052D 01         L052D    fcb   $01 
00688   052E 6F01                clr   $01,x
00689   0530 1C00                andcc #$00
00690   0532 1D                  sex   
00691   0533 01                  fcb   $01 
00692   0534 C8FF                eorb  #$FF
00693   0536 F3FFF3              addd  >$FFF3
00694   0539 002C                neg   <u002C
00695   053B 3408       IRQser   pshs  dp
00696   053D 8DE7                bsr   UtoDP

00697   053F 0F27                clr   <u0027
00698   0541 109E01              ldy   <V.PORT
00699   0544 E622                ldb   $02,y
00700   0546 C501                bitb  #$01
00701   0548 2710                beq   L055A

00702   054A 0D40                tst   <u0040
00703   054C 2708                beq   L0556

00704   054E E625                ldb   $05,y
00705   0550 C520                bitb  #$20
00706   0552 10260131            lbne  L0687
00707   0556 1A01       L0556    orcc  #$01
00708   0558 3588                puls  pc,dp
00709   055A 308DFFCF   L055A    leax  >L052D,pcr
00710   055E C40E                andb  #$0E
00711   0560 3A                  abx   
00712   0561 1F50                tfr   pc,d
00713   0563 E384                addd  ,x
00714   0565 1F05                tfr   d,pc
00715   0567 E622       L0567    ldb   $02,y
00716   0569 C501                bitb  #$01
00717   056B 27ED                beq   L055A

00718   056D 9605                lda   <V.WAKE
00719   056F 270B                beq   L057C

00720   0571 5F                  clrb  
00721   0572 D705                stb   <V.WAKE
00722   0574 1F01                tfr   d,x
00723   0576 A60C                lda   $0C,x
00724   0578 84F7                anda  #$F7
00725   057A A70C                sta   $0C,x
00726   057C 1CFE       L057C    andcc #$FE
00727   057E 3588                puls  pc,dp
00728   0580 9E2C                ldx   <u002C
00729   0582 A625                lda   $05,y
00730   0584 2B0D                bmi   L0593

00731   0586 D629                ldb   <u0029
00732   0588 8D2F       L0588    bsr   L05B9

00733   058A 5A                  decb  
00734   058B 26FB                bne   L0588

00735   058D 2002                bra   L0591

00736   058F 9E2C                ldx   <u002C
00737   0591 A625       L0591    lda   $05,y
00738   0593 851E       L0593    bita  #$1E
00739   0595 2705                beq   L059C

00740   0597 170198              lbsr  L0732

00741   059A 20F5                bra   L0591

00742   059C 8501       L059C    bita  #$01
00743   059E 2704                beq   L05A4

00744   05A0 8D17                bsr   L05B9

00745   05A2 20ED                bra   L0591

00746   05A4 0D27       L05A4    tst   <u0027
00747   05A6 260D                bne   L05B5

00748   05A8 DC25                ldd   <u0025
00749   05AA 2709                beq   L05B5

00750   05AC D727                stb   <u0027     * |signal code
00751   05AE 103F08              os9   F$Send     * |send signal
00752   05B1 4F                  clra  
00753   05B2 5F                  clrb  
00754   05B3 DD25                std   <u0025
00755   05B5 9F2C       L05B5    stx   <u002C
00756   05B7 20AE                bra   L0567

00757   05B9 3404       L05B9    pshs  b
00758   05BB A6A4                lda   ,y
00759   05BD 2736                beq   L05F5

00760   05BF 0D22                tst   <u0022
00761   05C1 2632                bne   L05F5

00762   05C3 910C                cmpa  <V.QUIT
00763   05C5 2604                bne   L05CB

00764   05C7 C602                ldb   #$02
00765   05C9 2006                bra   L05D1

00766   05CB 910B       L05CB    cmpa  <V.INTR
00767   05CD 2611                bne   L05E0

00768   05CF C603                ldb   #$03
00769   05D1 3402       L05D1    pshs  a
00770   05D3 0D27                tst   <u0027
00771   05D5 2607                bne   L05DE

00772   05D7 9603                lda   <V.LPRC    * | dest proc id
00773   05D9 D727                stb   <u0027     * | signal code
00774   05DB 103F08              os9   F$Send     * | send signal
00775   05DE 3502       L05DE    puls  a
00776   05E0 910F       L05E0    cmpa  <V.XON
00777   05E2 2773                beq   L0657

00778   05E4 9110                cmpa  <V.XOFF
00779   05E6 10270081            lbeq  L066B

00780   05EA 910D                cmpa  <V.PCHR
00781   05EC 2607                bne   L05F5

00782   05EE DE09                ldu   <V.DEV2
00783   05F0 2703                beq   L05F5

00784   05F2 A7C808              sta   <V.PAUS,u
00785   05F5 A780       L05F5    sta   ,x+
00786   05F7 9C30                cmpx  <u0030
00787   05F9 2602                bne   L05FD

00788   05FB 9E32                ldx   <u0032
00789   05FD 9C2E       L05FD    cmpx  <u002E
00790   05FF 2610                bne   L0611

00791   0601 C602                ldb   #$02
00792   0603 DA0E                orb   <V.ERR
00793   0605 D70E                stb   <V.ERR
00794   0607 9C32                cmpx  <u0032
00795   0609 2602                bne   L060D

00796   060B 9E30                ldx   <u0030
00797   060D 301F       L060D    leax  -$01,x
00798   060F 200C                bra   L061D

00799   0611 DC34       L0611    ldd   <u0034
00800   0613 C30001              addd  #$0001
00801   0616 DD34                std   <u0034
00802   0618 10932A              cmpd  <u002A
00803   061B 2702                beq   L061F

00804   061D 3584       L061D    puls  pc,b
00805   061F D628       L061F    ldb   <u0028
00806   0621 C570                bitb  #$70
00807   0623 26F8                bne   L061D

00808   0625 961D                lda   <u001D
00809   0627 8502                bita  #$02
00810   0629 270C                beq   L0637

00811   062B CA20                orb   #$20
00812   062D D728                stb   <u0028
00813   062F A624                lda   $04,y
00814   0631 84F5                anda  #$F5
00815   0633 A724                sta   $04,y
00816   0635 20E6                bra   L061D

00817   0637 8501       L0637    bita  #$01
00818   0639 270C                beq   L0647

00819   063B CA10                orb   #$10
00820   063D D728                stb   <u0028
00821   063F A624                lda   $04,y
00822   0641 84FA                anda  #$FA
00823   0643 A724                sta   $04,y
00824   0645 20D6                bra   L061D

00825   0647 9610       L0647    lda   <V.XOFF
00826   0649 27D2                beq   L061D

00827   064B CA40                orb   #$40
00828   064D D728                stb   <u0028
00829   064F 9743                sta   <u0043
00830   0651 C60F                ldb   #$0F
00831   0653 E721                stb   $01,y
00832   0655 20C6                bra   L061D

00833   0657 D61D       L0657    ldb   <u001D
00834   0659 C504                bitb  #$04
00835   065B 1027FF96            lbeq  L05F5

00836   065F 9628                lda   <u0028
00837   0661 84FB                anda  #$FB
00838   0663 9728                sta   <u0028
00839   0665 860F                lda   #$0F
00840   0667 A721                sta   $01,y
00841   0669 20B2                bra   L061D

00842   066B D61D       L066B    ldb   <u001D
00843   066D C504                bitb  #$04
00844   066F 1027FF82            lbeq  L05F5

00845   0673 9628                lda   <u0028
00846   0675 8A04                ora   #$04
00847   0677 9728                sta   <u0028
00848   0679 860D                lda   #$0D
00849   067B A721                sta   $01,y
00850   067D 209E                bra   L061D

00851   067F A625                lda   $05,y
00852   0681 8520                bita  #$20
00853   0683 1027FEE0            lbeq  L0567

00854   0687 9E3A       L0687    ldx   <u003A
00855   0689 9643                lda   <u0043
00856   068B 2F06                ble   L0693

00857   068D A7A4                sta   ,y
00858   068F 8A80                ora   #$80
00859   0691 9743                sta   <u0043
00860   0693 0D40       L0693    tst   <u0040
00861   0695 2734                beq   L06CB

00862   0697 D628                ldb   <u0028
00863   0699 C508                bitb  #$08
00864   069B 262E                bne   L06CB

00865   069D C407                andb  #$07
00866   069F D41D                andb  <u001D
00867   06A1 2628                bne   L06CB

00868   06A3 D63B                ldb   <u003B
00869   06A5 50                  negb  
00870   06A6 C10F                cmpb  #$0F
00871   06A8 2302                bls   L06AC
00872   06AA C60F                ldb   #$0F

00873   06AC D140       L06AC    cmpb  <u0040
00874   06AE 2302                bls   L06B2

00875   06B0 D640                ldb   <u0040
00876   06B2 3404       L06B2    pshs  b
00877   06B4 A680       L06B4    lda   ,x+
00878   06B6 A7A4                sta   ,y
00879   06B8 5A                  decb  
00880   06B9 26F9                bne   L06B4

00881   06BB 9C3C                cmpx  <u003C
00882   06BD 2502                bcs   L06C1

00883   06BF 9E3E                ldx   <u003E
00884   06C1 9F3A       L06C1    stx   <u003A
00885   06C3 D640                ldb   <u0040
00886   06C5 E0E0                subb  ,s+
00887   06C7 D740                stb   <u0040
00888   06C9 2604                bne   L06CF

00889   06CB 860D       L06CB    lda   #$0D
00890   06CD A721                sta   $01,y

00891   06CF 16FE95     L06CF    lbra  L0567
00892   06D2 A626                lda   $06,y
00893   06D4 1F89                tfr   a,b
00894   06D6 C4B0                andb  #$B0
00895   06D8 D720                stb   <u0020
00896   06DA D628                ldb   <u0028
00897   06DC C4FC                andb  #$FC
00898   06DE 8510                bita  #$10
00899   06E0 2602                bne   L06E4

00900   06E2 CA02                orb   #$02
00901   06E4 8520       L06E4    bita  #$20
00902   06E6 2602                bne   L06EA

00903   06E8 CA01                orb   #$01
00904   06EA D728       L06EA    stb   <u0028
00905   06EC 8508                bita  #$08
00906   06EE 2734                beq   L0724

00907   06F0 8580                bita  #$80
00908   06F2 261E                bne   L0712

00909   06F4 961D                lda   <u001D
00910   06F6 8510                bita  #$10
00911   06F8 270E                beq   L0708

00912   06FA 9E16                ldx   <V.PDLHD
00913   06FC 270A                beq   L0708

00914   06FE 8601                lda   #$01
00915   0700 A7883F     L0700    sta   <$3F,x
00916   0703 AE883D              ldx   <$3D,x
00917   0706 26F8                bne   L0700

00918   0708 8620       L0708    lda   #$20
00919   070A 9A0E                ora   <V.ERR
00920   070C 970E                sta   <V.ERR
00921   070E C4FB                andb  #$FB
00922   0710 D728                stb   <u0028
00923   0712 0D27       L0712    tst   <u0027
00924   0714 260E                bne   L0724

00925   0716 DC23                ldd   <u0023
00926   0718 5D                  tstb  
00927   0719 2709                beq   L0724

00928   071B 103F08              os9   F$Send     * |send signal
00929   071E D727                stb   <u0027
00930   0720 4F                  clra  
00931   0721 5F                  clrb  
00932   0722 DD23                std   <u0023
00933   0724 860F       L0724    lda   #$0F
00934   0726 A721                sta   $01,y
00935   0728 16FE3C              lbra  L0567
00936   072B A625                lda   $05,y

00937   072D 8D03                bsr   L0732

00938   072F 16FE35              lbra  L0567

00939   0732 3404       L0732    pshs  b
00940   0734 5F                  clrb  
00941   0735 8502                bita  #$02
00942   0737 2702                beq   L073B

00943   0739 CA04                orb   #$04
00944   073B 8504       L073B    bita  #$04
00945   073D 2702                beq   L0741

00946   073F CA01                orb   #$01
00947   0741 8508       L0741    bita  #$08
00948   0743 2702                beq   L0747

00949   0745 CA02                orb   #$02
00950   0747 8510       L0747    bita  #$10
00951   0749 2606                bne   L0751

00952   074B CA08                orb   #$08
00953   074D DA0E                orb   <V.ERR
00954   074F D70E                stb   <V.ERR
00955   0751 3584       L0751    puls  pc,b

*[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[

00956   0753 01         Data     fcb   $01 
00957   0754 01                  fcb   $01 
00958   0755 0A28                dec   <u0028
00959   0757 E901                adcb  $01,x
00960   0759 01                  fcb   $01 
00961   075A 0F00                clr   <V.PAGE
00962   075C 01                  fcb   $01 
00963   075D 01                  fcb   $01 
00964   075E 0780                asr   <u0080
00965   0760 41                  fcb   $41 A
00966   0761 0403                lsr   <V.LPRC
00967   0763 C081                subb  #$81

00968   0765 0801                lsl   <V.PORT
00969   0767 E0C1                subb  ,u++
00970   0769 0E00                jmp   <V.PAGE
00971   076B F0C10E              subb  >$C10E
00972   076E 0078                neg   <u0078
00973   0770 C10E                cmpb  #$0E
00974   0772 003C                neg   <u003C
00975   0774 8108                cmpa  #$08
00976   0776 001E                neg   <u001E
00977   0778 8108                cmpa  #$08
00978   077A 0014                neg   <V.MODADR
00979   077C 8108                cmpa  #$08
00980   077E 000F                neg   <V.XON
00981   0780 8108                cmpa  #$08
00982   0782 000A                neg   <u000A
00983   0784 8108                cmpa  #$08
00984   0786 000A                neg   <u000A
00985   0788 8108                cmpa  #$08
00986   078A 000A                neg   <u000A
00987   078C 8108                cmpa  #$08
00988   078E 000A                neg   <u000A
00989   0790 8108                cmpa  #$08
00990   0792 0025                neg   <u0025
00991   0794 8108                cmpa  #$08
00992   0796 85C9D1              emod
00993   0799            eom      equ   *
