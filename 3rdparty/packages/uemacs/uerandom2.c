/*
 * This file contains the command processing functions for a number of random
 * commands. There is no functional grouping here, for sure.
 */

#include        <stdio.h>
#include        "ueed.h"

/*
 * Insert a newline, then enough tabs and spaces to duplicate the indentation
 * of the previous line. Assumes tabs are every eight characters. Quite simple.
 * Figure out the indentation of the current line. Insert a newline by calling
 * the standard routine. Insert the indentation by inserting the right number
 * of tabs and spaces. Return TRUE if all ok. Return FALSE if one of the
 * subcomands failed. Normally bound to "C-J".
 */
indent(f, n)
{
        register int    nicol;
        register int    c;
        register int    i;

        if (n < 0)
                return (FALSE);
        while (n--) {
                nicol = 0;
                for (i=0; i<llength(curwp->w_dotp); ++i) {
                        c = lgetc(curwp->w_dotp, i);
                        if (c!=' ' && c!='\t')
                                break;
                        if (c == '\t')
                                nicol |= 0x07;
                        ++nicol;
                }
                if (lnewline() == FALSE
                || ((i=nicol/8)!=0 && linsert(i, '\t')==FALSE)
                || ((i=nicol%8)!=0 && linsert(i,  ' ')==FALSE))
                        return (FALSE);
        }
        return (TRUE);
}

/*
 * Delete forward. This is real easy, because the basic delete routine does
 * all of the work. Watches for negative arguments, and does the right thing.
 * If any argument is present, it kills rather than deletes, to prevent loss
 * of text if typed with a big arg
ument. Normally bound to "C-D".
 */
forwdel(f, n)
{
        if (n < 0)
                return (backdel(f, -n));

        if (f != FALSE) {                       /* Really a kill.       */
                if ((lastflag&CFKILL) == 0)
                        kdelete();
                thisflag |= CFKILL;
        }
        return (ldelete(n, f));
}

/*
 * Delete backwards. This is quite easy too, because it's all done with other
 * functions. Just move the cursor back, and delete forwards. Like delete
 * forward, this actually does a kill if presented with an argument. Bound to
 * both "RUBOUT" and "C-H".
 */
backdel(f, n)
{
        register int    s;

        if (n < 0)
                return (forwdel(f, -n));
        if (f != FALSE) {                       /* Really a kill.       */
                if ((lastflag&CFKILL) == 0)
                        kdelete();
                thisflag |= CFKILL;
        }
        if ((s=backchar(f, n)) == TRUE)
                s = ldelete(n, f);
        return (s);
}

/*
 * Kill text. If called without an argument, it kills from dot to the end of
 * the line, unless it is at the end of the line, when it kills the newline.
 * If called with an argument of 0, it kills from the start of the line to dot.
 * If called with a positive argument, it kills from dot forward over that
 * number of newlines. If called with a negative argument it kills backwards
 * that number of newlines. Normally bound to "C-K".
 */
killer(f, n)
int f,n;
{
        register int    chunk;
        register LINE   *nextp;

        if ((lastflag&CFKILL) == 0)             /* Clear kill buffer if */
                kdelete();                      /* last wasn't a kill.  */
        thisflag |= CFKILL;
        if (f == FALSE) {
                chunk = llength(curwp->w_dotp)-curwp->w_doto;
                if (chunk == 0)
                        chunk = 1;
        } else if (n == 0) {
                chunk = curwp->w_doto;
                curwp->w_doto = 0;
        } else if (n > 0) {
                chunk = llength(curwp->w_dotp)-curwp->w_doto+1;
                nextp = lforw(curwp->w_dotp);
                while (--n) {
                        if (nextp == curbp->b_linep)
                                return (FALSE);
                        chunk += llength(nextp)+1;
                        nextp = lforw(nextp);
                }
        } else {
                mlwrite("neg kill");
                return (FALSE);
        }
        return (ldelete(chunk, TRUE));
}

/*
 * Yank text back from the kill buffer. This is really easy. All of the work
 * is done by the standard insert routines. All you do is run the loop, and
 * check for errors. Bound to "C-Y". The blank lines are inserted with a call
 * to "newline" instead of a call to "lnewline" so that the magic stuff that
 * happens when you type a carriage return also happens when a carriage return
 * is yanked back from the kill buffer.
 */
yank(f, n)
{
        register int    c;
        register int    i;
        extern   int    kused;

        if (n < 0)
                return (FALSE);
        while (n--) {
                i = 0;
                while ((c=kremove(i)) >= 0) {
                        if (c == '\n') {
                                if (newline(FALSE, 1) == FALSE)
                                        return (FALSE);
                        } else {
                                if (linsert(1, c) == FALSE)
                                        return (FALSE);
                        }
                        ++i;
                }
        }
        return (TRUE);
}

