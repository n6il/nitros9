/* ************************************************************************ *
 * pffinit.c - Source for COCO print routines for floats                    *
 * ************************************************************************ */

#include <ctype.h>
#include <stdio.h>

extern double scale ();

static direct char D0000;

static char B0000;
static char B0001[29];

/* Initialize G0000 */
static char G0000[] = {
    0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x81,
    0x4c, 0xcc, 0xcc, 0xcc,
    0xcc, 0xcc, 0xcd, 0x7d,
    0x23, 0xd7, 0x0a, 0x3d,
    0x70, 0xa3, 0xd7, 0x7a,
    0x03, 0x12, 0x6e, 0x97,
    0x8d, 0x4f, 0xdf, 0x77,
    0x51, 0xb7, 0x17, 0x58,
    0xe2, 0x19, 0x65, 0x73,
    0x27, 0xc5, 0xac, 0x47,
    0x1b, 0x47, 0x84, 0x70,
    0x06, 0x37, 0xbd, 0x05,
    0xaf, 0x6c, 0x6a, 0x6d,
    0x56, 0xbf, 0x94, 0xd5,
    0xe5, 0x7a, 0x43, 0x69,
    0x2b, 0xcc, 0x77, 0x11,
    0x84, 0x61, 0xcf, 0x66,
    0x09, 0x70, 0x5f, 0x41,
    0x36, 0xb4, 0xa6, 0x63,
    0x5b, 0xe6, 0xfe, 0xce,
    0xbd, 0xed, 0xd6, 0x5f,
    0x2f, 0xeb, 0xff, 0x0b,
    0xcb, 0x24, 0xab, 0x5c,
    0x0c, 0xbc, 0xcc, 0x09,
    0x6f, 0x50, 0x89, 0x59,
    0x61, 0x2e, 0x13, 0x42,
    0x4b, 0xb4, 0x0e, 0x55,
    0x34, 0x24, 0xdc, 0x35,
    0x09, 0x5c, 0xd8, 0x52,
    0x10, 0x1d, 0x7c, 0xf7,
    0x3a, 0xb0, 0xad, 0x4f,
    0x66, 0x95, 0x94, 0xbe,
    0xc4, 0x4d, 0xe1, 0x4b,
    0x38, 0x77, 0xaa, 0x32,
    0x36, 0xa4, 0xb4, 0x48
};

/* dummy function to include this ROF */

pffinit ()
{
    return;
}

pffloat (parm1, parm2, parm3, parm4)
    int parm1;
    int parm2;
    double **parm3;
    int parm4;
{
    int pfv0;

    switch (parm1)
    {
        case 'f':       /* L000a */
            pfv0 = 1;
            break;
        case 'e':       /* L000f */
        case 'E':       /* L000f */
            pfv0 = -1;
            break;
        case 'g':       /* L0014 */
        case 'G':       /* L0014 */
            pfv0 = 0;
            break;
    }

    L0064 ((*parm3)++, parm2, pfv0, _chcodes [parm1] & 2);
}

L0064 (parm1, parm2, parm3, parm4, parm5)
    double *parm1;
    int parm2;
    int parm3;
    int parm4;
    int parm5;
{
    char *var30;
    int var28;
    int var26;
    int var24;
    int var22;
    int var20;
    int var18;
    int var16;
    int var14;
    int var12;
    int var10;   /* temporarily ? */
    int var8;
    double var0;

    register char * regptr;

    var8 = 1;
    var0 = *parm1;
    regptr = (char *)(&var0);

    if (regptr[7] == 0)         /* else L008f */
    {
        var18 = var26 = var24 = 0;
        goto L0181;
    }

    var22 = (regptr[7] & 0xff) - 0x80;

    /* L008f */
    if (var22 < 0)      /* else L00a9 */
    {
        var22 = -var22;
        var24 = 1;
    }
    else
    {
        var24 = 0;
    }

    var20 = (var22 * 78) >> 8;

    if (var24)
    {
        var18 = -var20 + 1;
    }
    else
    {
        var18 = var20 + 1;
    }

    if (regptr[0] < 0)     /* else L00eb */
    {
        regptr[0] &= 0x7f;
        var26 = 1;
    }
    else
    {
        var26 = 0;
    }

    var0 = scale (var0, var20, var24);  /* go to L012f */

    while (var0 < 1)
    {
        var0 *= 10;
        --var18;
    }

    while (var0 >= 10)      /* L0169 */
    {
        var0 /= 10;
        ++var18;
    }

L0181:
    var30 = &B0000;
    *(var30++) = '0';

    if (var26)  /* else L01aa */
    {
        *(var30++) = '-';
    }

    if (parm2 > 16)     /* else L01aa */
    {
        parm2 = 16;
    }
    else
    {
        if (parm2 < 0)
        {
            parm2 = 0;
        }
    }

    var10 = 0;          /* L01c2 */

    if ( ! parm3)       /* else L01e0 */
    {
        var10 = 1;

        if (var18 > 5)
        {
            goto L01e7;
        }

        goto L0213;
    }
    else
    {
        if (parm3 < 0)
        {
L01e7:
            var16 = 1;
            var12 = 1;

            if (var0 == 0)      /* else L0258 */
            {
                var18 = 1;
            }
        }
        else
        {
L0213:
            var16 = 0;
            
            if ((var12 = var18) < 0)        /* else L0247 */
            {
                if ((var12 + parm2) >= 0)    /* else L0233 */
                {
                    parm2 += var12;
                    /* go to L0258 */
                }
                else
                {
                    var12 = -parm2;
                    parm2 = 0;
                    var8 = 0;
                }
            }
            else
            {           /* L0247 */
                if ((var12 + parm2) > 25)
                {
                    goto L01e7;
                }
            }
        }
    }

    /* L0258 */
    var14 = G0000;
    L0464 (&var0);

    if (var12 < 0)  /* else L029e */
    {
        *(var30++) = '0';
        var28 = var30;
        *(var30++) = '.';
        
        while (var12++)
        {
            *(var30++) = '0';
        }
        /* go to L02f1 */
    }
    else
    {    /* L029e */
        if ( ! var12)       /* else L02be */
        {
            *(var30++) = '0';
        }

        while (var12--)
        {
            *(var30++) = L049c (&var0, &var14);
        }

        var28 = var30;

        if (parm2)
        {
            *(var30++) = '.';
        }
    }

    while (((parm2--) > 0))         /* @ L02f1 */
    {
        *(var30++) = L049c (&var0, &var14);
    }

    if (var8)       /* else L037b */
    {
        int loc02;
        char *loc00;

        *(loc00 = var30) = L049c (&var0, &var14);
        loc02 = 5;

        for (;;)
        {
            switch (*loc00)
            {
                case '.':           /* L032c */
                    --loc00;
                    break;
                case '-':           /* L0335 */
                    loc00[-1] = '-';
                    *loc00 = '0';
                    break;
            }
            
                    /* L034d */
            /**loc00 += loc02;*/
            
            if ( (loc02 = ((*loc00 += loc02) > '9')))      /* else L0379 */
            {
                *loc00 -= 10;
                -- loc00;
                continue;
            }
            else
            {
                break;
            }

        }
    }

    /* L037b */
    if (var16)      /* else L03f2 */
    {
        *(var30++) = (parm4 ? 'E' : 'e');
        
        if ((--var18 < 0))  /* else L03b3 */
        {
            var18 = -var18;
            *(var30++) = '-';
        }
        else
        {
            *(var30++) = '+';
        }

        *(var30++) = (var18/10) + '0';
        *(var30++) = (var18 % 10) + '0';
        /* go to L0422 */
    }
    else
    {           /* L03f2 */
        if ((var10) && (var30 != var28))    /* else L0422 */
        {
            while ((--var30) != var28)
            {
                if ((*var30 != '0'))
                {
                    ++var30;
                    break;
                }
            }
        }
    }

    *var30 = '\0';          /* L0422 */

    if ((&B0001[sizeof (B0001)]) <= var30)
    {
        fprintf (stderr, "pffinit buffer overflow\n");
        exit (1);
    }

    return (B0000 == '0' ? B0001 : &B0000);
}

/* The following routine is strictly asm for the COCO
 */

#ifdef COCO
#asm
L0464 pshs  u 
 ldx   4,s 
 lda   7,x 
 suba  #$80 
 bcs   L0496 
 ldb   ,x 
 orb   #$80 
 stb   ,x 
 clr   7,x 
 suba  #4 
 beq   L048d 
L047a lsr   ,x 
 ror   1,x 
 ror   2,x 
 ror   3,x 
 ror   4,x 
 ror   5,x 
 ror   6,x 
 ror   7,x 
 inca   
 bne   L047a 
L048d lda   #8 
L048f deca   
 bmi   L0496 
 ldb   a,x 
 beq   L048f 
L0496 sta   D0000 
 clra   
 clrb   
 puls  u,pc 
L049c ldx   2,s 
 clra   
 ldb   ,x 
 lsrb   
 lsrb   
 lsrb   
 lsrb   
 addb  #'0 
 pshs  d,u 
 ldb   ,x 
 andb  #$0f 
 stb   ,x 
 bsr   L04dd 
 lda   D0000 
 bmi   L04db 
L04b5 ldb   a,x 
 bne   L04bc 
 deca   
 bpl   L04b5 
L04bc sta   D0000 
 bmi   L04db 
 leas  -8,s 
L04c2 ldb   a,x 
 stb   a,s 
 deca   
 bpl   L04c2 
 bsr   L04dd 
 bsr   L04dd 
 lda   D0000 
 clrb   
L04d0 ldb   a,x 
 adcb  a,s 
 stb   a,x 
 deca   
 bpl   L04d0 
 leas  8,s 
L04db puls  d,u,pc 
L04dd lda   D0000 
 bmi   L04ea 
 asl   a,x 
 bra   L04e7 
L04e5 rol   a,x 
L04e7 deca   
 bpl   L04e5 
L04ea rts    
#endasm
#endif
