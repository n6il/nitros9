/*
 * This file contains the command processing functions for a number of random
 * commands. There is no functional grouping here, for sure.
 */

#include        <stdio.h>
#include        "ueed.h"

int     tabsize;                        /* Tab size (0: use real tabs)  */

/*
 * Set fill column to n. 
 */
setfillcol(f, n)
{
        fillcol = n;
        return(TRUE);
}

/*
 * Display the current position of the cursor, in origin 1 X-Y coordinates,
 * the character that is under the cursor (in hex), and the fraction of the
 * text that is before the cursor. The displayed column is not the current
 * column, but the column that would be used on an infinite width display.
 * Normally this is bound to "C-X =".
 */
showcpos(f, n)
{
        register LINE   *clp;
        register long   nch;
        register long   nbc;
        register int    cac;
        register int    ratio;
        register int    col;
        register int    i;
        register int    c;
        register int    nl;
        register int    cl;
#ifdef OSK
        char mline[80];
#endif

        clp = lforw(curbp->b_linep);            /* Grovel the data.     */
        nch = 0;
        nl  = 0;
        while (clp != curbp->b_linep) {
                if (clp == curwp->w_dotp) {
                        nbc = nch + curwp->w_doto;
                        cac = (curwp->w_doto < llength(clp)) 
                                ? lgetc(clp, curwp->w_doto)
                                : '\n';
                        cl = nl;
                }
                nch += llength(clp)+1;

                clp = lforw(clp);
                nl++;
        }
        if (clp == curwp->w_dotp) { /* special case for end of buffer */
                nbc = nch;
                cac = '\n';
                cl = nl;
        }
        col = getccol(FALSE);                   /* Get real column.     */
        ratio = 0;                              /* Ratio before dot.    */
        if (nch != 0)
                ratio = (100L*nbc) / nch;
#ifdef OSK
        /* osk objects to this varargs technique with more than 2 arguments */
        /* while I was changing things I made it display more info */
        sprintf(mline, 
"X=%d Y=%d CH=0x%02X (%s%c) Line %d of %d; Char %ld of %ld (%d%%%%)",
                col+1, currow+1, cac, (cac<' ')?"^":"", (cac<' ')?cac+'@':cac,
                cl, nl, nbc, nch, ratio);
        mlwrite(mline);
#else
        /* note nl (number of lines) and cl (current line) arn't yet displayed */
        mlwrite("X=%d Y=%d CH=0x%x .=%D (%d%% of %D)",
                col+1, currow+1, cac, nbc, ratio, nch);
#endif
        return (TRUE);
}

/*
 * Return current column.  Stop at first non-blank given TRUE argument.
 */
getccol(bflg)
int bflg;
{
        register int c, i, col;
        col = 0;
        for (i=0; i<curwp->w_doto; ++i) {
                c = lgetc(curwp->w_dotp, i);
                if (c!=' ' && c!='\t' && bflg)
                        break;
                if (c == '\t')
                        col |= 0x07;
                else if (c<0x20 || c==0x7F)
                        ++col;
                ++col;
        }
        return(col);
}

/*
 * Twiddle the two characters on either side of dot. If dot is at the end of
 * the line twiddle the two characters before it. Return with an error if dot
 * is at the beginning of line; it seems to be a bit pointless to make this
 * work. This fixes up a very common typo with a single stroke. Normally bound
 * to "C-T". This always works within a line, so "WFEDIT" is good enough.
 */
twiddle(f, n)
{
        register LINE   *dotp;
        register int    doto;
        register int    cl;
        register int    cr;

        dotp = curwp->w_dotp;
        doto = curwp->w_doto;
        if (doto==llength(dotp) && --doto<0)
                return (FALSE);
        cr = lgetc(dotp, doto);
        if (--doto < 0)
                return (FALSE);
        cl = lgetc(dotp, doto);
        lputc(dotp, doto+0, cr);
        lputc(dotp, doto+1, cl);
        lchange(WFEDIT);
        return (TRUE);
}

/*
 * Quote the next character, and insert it into the buffer. All the characters
 * are taken literally, with the exception of the newline, which always has
 * its line splitting meaning. The character is always read, even if it is
 * inserted 0 times, for regularity. Bound to "M-Q" (for me) and "C-Q" (for
 * Rich, and only on terminals that don't need XON-XOFF).
 */
quote(f, n)
{
        register int    s;
        register int    c;

        c = (*term.t_getchar)();
        if (n < 0)
                return (FALSE);
        if (n == 0)
                return (TRUE);
        if (c == '\n') {
                do {
                        s = lnewline();
                } while (s==TRUE && --n);
                return (s);
        }
        return (linsert(n, c));
}

/*
 * Set tab size if given non-default argument (n <> 1).  Otherwise, insert a
 * tab into file.  If given argument, n, of zero, change to true tabs.
 * If n > 1, simulate tab stop every n-characters using spaces. This has to be
 * done in this slightly funny way because the tab (in ASCII) has been turned
 * into "C-I" (in 10 bit code) already. Bound to "C-I".
 */
tab(f, n)
{
        if (n < 0)
                return (FALSE);
        if (n == 0 || n > 1) {
                tabsize = n;
                return(TRUE);
        }
        if (! tabsize)
                return(linsert(1, '\t'));
        return(linsert(tabsize - (getccol(FALSE) % tabsize), ' '));
}

/*
 * Open up some blank space. The basic plan is to insert a bunch of newlines,
 * and then back up over them. Everything is done by the subcommand
 * procerssors. They even handle the looping. Normally this is bound to "C-O".
 */
openline(f, n)
{
        register int    i;
        register int    s;

        if (n < 0)
                return (FALSE);
        if (n == 0)
                return (TRUE);
        i = n;                                  /* Insert newlines.     */
        do {
                s = lnewline();
        } while (s==TRUE && --i);
        if (s == TRUE)                          /* Then back up overtop */
                s = backchar(f, n);             /* of them all.         */
        return (s);
}

/*
 * Insert a newline. Bound to "C-M". If you are at the end of the line and the
 * next line is a blank line, just move into the blank line. This makes "C-O"
 * and "C-X C-O" work nicely, and reduces the ammount of screen update that
 * has to be done. This would not be as critical if screen update were a lot
 * more efficient.
 */
newline(f, n)
{
        int nicol;
        register LINE   *lp;
        register int    s;

        if (n < 0)

                return (FALSE);
        while (n--) {
                lp = curwp->w_dotp;
                if (llength(lp) == curwp->w_doto
                && lp != curbp->b_linep
                && llength(lforw(lp)) == 0) {
                        if ((s=forwchar(FALSE, 1)) != TRUE)
                                return (s);
                } else if ((s=lnewline()) != TRUE)
                        return (s);
        }
        return (TRUE);
}

/*
 * Delete blank lines around dot. What this command does depends if dot is
 * sitting on a blank line. If dot is sitting on a blank line, this command
 * deletes all the blank lines above and below the current line. If it is
 * sitting on a non blank line then it deletes all of the blank lines after
 * the line. Normally this command is bound to "C-X C-O". Any argument is
 * ignored.
 */
deblank(f, n)
{
        register LINE   *lp1;
        register LINE   *lp2;
        register int    nld;

        lp1 = curwp->w_dotp;
        while (llength(lp1)==0 && (lp2=lback(lp1))!=curbp->b_linep)
                lp1 = lp2;
        lp2 = lp1;
        nld = 0;
        while ((lp2=lforw(lp2))!=curbp->b_linep && llength(lp2)==0)
                ++nld;
        if (nld == 0)
                return (TRUE);
        curwp->w_dotp = lforw(lp1);
        curwp->w_doto = 0;
        return (ldelete(nld));
}


