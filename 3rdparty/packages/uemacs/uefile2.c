/*
 * The routines in this file
 * handle the reading and writing of
 * disk files. All of details about the
 * reading and writing of the disk are
 * in "fileio.c".
 */
#include        <stdio.h>
#include        "ueed.h"

/*
 * Save the contents of the current
 * buffer in its associatd file. No nothing
 * if nothing has changed (this may be a bug, not a
 * feature). Error if there is no remembered file
 * name for the buffer. Bound to "C-X C-S". May
 * get called by "C-Z".
 */
filesave(f, n)
{
        register WINDOW *wp;
        register int    s;

        if ((curbp->b_flag&BFCHG) == 0)         /* Return, no changes.  */
                return (TRUE);
        if (curbp->b_fname[0] == 0) {           /* Must have a name.    */
                mlwrite("No file name");
                return (FALSE);
        }
        if ((s=writeout(curbp->b_fname)) == TRUE) {
                curbp->b_flag &= ~BFCHG;
                wp = wheadp;                    /* Update mode lines.   */
                while (wp != NULL) {
                        if (wp->w_bufp == curbp)
                                wp->w_flag |= WFMODE;
                        wp = wp->w_wndp;
                }
        }
        return (s);
}

/*
 * This function performs the details of file
 * writing. Uses the file management routines in the
 * "fileio.c" package. The number of lines written is
 * displayed. Sadly, it looks inside a LINE; provide
 * a macro for this. Most of the grief is error
 * checking of some sort.
 */
writeout(fn)
char    *fn;
{
        register int    s;
        register LINE   *lp;
        register int    nline;

        if ((s=ffwopen(fn)) != FIOSUC)          /* Open writes message. */
                return (FALSE);
        lp = lforw(curbp->b_linep);             /* First line.          */
        nline = 0;                              /* Number of lines.     */
        while (lp != curbp->b_linep) {
                if ((s=ffputline(&lp->l_text[0], llength(lp))) != FIOSUC)
                        break;
                ++nline;
                lp = lforw(lp);
        }
        if (s == FIOSUC) {                      /* No write error.      */
                s = ffclose();
                if (s == FIOSUC) {              /* No close error.      */
                        if (nline == 1)
                                mlwrite("[Wrote 1 line]");
                        else
                                mlwrite("[Wrote %d lines]", nline);
                }
        } else                                  /* Ignore close error   */
                ffclose();                      /* if a write error.    */
        if (s != FIOSUC)                        /* Some sort of error.  */
                return (FALSE);
        return (TRUE);
}

/*
 * The command allows the user
 * to modify the file name associated with
 * the current buffer. It is like the "f" command
 * in UNIX "ed". The operation is simple; just zap
 * the name in the BUFFER structure, and mark the windows
 * as needing an update. You can type a blank line at the
 * prompt if you wish.
 */
filename(f, n)
{
        register WINDOW *wp;
        register int    s;
        char            fname[NFILEN];

        if ((s=mlreply("Name: ", fname, NFILEN)) == ABORT)
                return (s);
        if (s == FALSE)
                strcpy(curbp->b_fname, "");
        else
                strcpy(curbp->b_fname, fname);
        wp = wheadp;                            /* Update mode lines.   */
        while (wp != NULL) {
                if (wp->w_bufp == curbp)
                        wp->w_flag |= WFMODE;
                wp = wp->w_wndp;
        }
        return (TRUE);
}


