/*
 * The functions in this file handle redisplay. There are two halves, the
 * ones that update the virtual display screen, and the ones that make the
 * physical display screen the same as the virtual display screen. These
 * functions use hints that are left in the windows by the commands.
 *
 * REVISION HISTORY:
 *
 * ?    Steve Wilhite, 1-Dec-85
 *      - massive cleanup on code.
 */

#include        <stdio.h>
#include        "ueed.h"
#include        "uedisplay.h"

/*
 * Write a message into the message line. Keep track of the physical cursor
 * position. A small class of printf like format items is handled. 
 * This routine is probably one of the lease portable.
 * Assumes all arguments (with the possible exception of the first) are passed
 * in the order expected on a downward growing stack without addtional
 * padding; this assumption is made by the "++" in the 
 * argument scan loop.  It works for the two or less argument case
 * on OSK despite the fact the first two arguments are passed in registers.
 * Set the "message line" flag TRUE.
 */
mlwrite(fmt, arg)
    char *fmt;
    {
    register int c;
    register char *ap;

    movecursor(term.t_nrow, 0);
    ap = (char *) &arg;
    while ((c = *fmt++) != 0) {
        if (c != '%') {
            (*term.t_putchar)(c);
            ++ttcol;
            }
        else
            {
            c = *fmt++;
            switch (c) {
                case 'd':
                    mlputi(*(int *)ap, 10);
                    ap += sizeof(int);
                    break;

                case 'o':
                    mlputi(*(int *)ap,  8);
                    ap += sizeof(int);
                    break;

                case 'x':
                    mlputi(*(int *)ap, 16);
                    ap += sizeof(int);
                    break;

                case 'D':  /* this is %ld on many printf impleminations */
                    mlputli(*(long *)ap, 10);
                    ap += sizeof(long);
                    break;

                case 's':
                    mlputs(*(char **)ap);
                    ap += sizeof(char *);
                    break;

                default:
                    (*term.t_putchar)(c);
                    ++ttcol;
                }
            }
        }
    (*term.t_eeol)();
    (*term.t_flush)();
    mpresf = TRUE;
    }

/*
 * Write out a string. Update the physical cursor position. This assumes that
 * the characters in the string all have width "1"; if this is not the case
 * things will get screwed up a little.
 */
mlputs(s)
    char *s;
    {
    register int c;

    while ((c = *s++) != 0)
        {
        (*term.t_putchar)(c);
        ++ttcol;
        }
    }

/*
 * Write out an integer, in the specified radix. Update the physical cursor
 * position. This will not handle any negative numbers; maybe it should.
 */
mlputi(i, r)
    {
    register int q;
    static char hexdigits[] = "0123456789ABCDEF";

    if (i < 0)
        {
        i = -i;
        (*term.t_putchar)('-');
        }

    q = i/r;

    if (q != 0)
        mlputi(q, r);

    (*term.t_putchar)(hexdigits[i%r]);
    ++ttcol;
    }

/*
 * do the same except as a long integer.
 */
mlputli(l, r)
    long l;
    {
    register long q;

    if (l < 0)
        {
        l = -l;
        (*term.t_putchar)('-');
        }

    q = l/r;

    if (q != 0)
        mlputli(q, r);

    (*term.t_putchar)((int)(l%r)+'0');
    ++ttcol;
    }

#ifdef RAINBOW

putline(row, col, buf)
    int row, col;
    char buf[];
    {
    int n;

    n = strlen(buf);
    if (col + n - 1 > term.t_ncol)
        n = term.t_ncol - col + 1;
    Put_Data(row, col, n, buf);
    }
#endif


