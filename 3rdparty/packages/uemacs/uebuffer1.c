/*
 * Buffer management.
 * Some of the functions are internal,
 * and some are actually attached to user
 * keys. Like everyone else, they set hints
 * for the display system.
 */
#include        <stdio.h>
#include        "ueed.h"

#ifndef OS9
/*
 * Attach a buffer to a window. The
 * values of dot and mark come from the buffer
 * if the use count is 0. Otherwise, they come
 * from some other window.
 */
usebuffer(f, n)
{
        register BUFFER *bp;
        register WINDOW *wp;
        register int    s;
        char            bufn[NBUFN];

        if ((s=mlreply("Use buffer: ", bufn, NBUFN)) != TRUE)
                return (s);
        if ((bp=bfind(bufn, TRUE, 0)) == NULL)
                return (FALSE);
        if (--curbp->b_nwnd == 0) {             /* Last use.            */
                curbp->b_dotp  = curwp->w_dotp;
                curbp->b_doto  = curwp->w_doto;
                curbp->b_markp = curwp->w_markp;
                curbp->b_marko = curwp->w_marko;
        }
        curbp = bp;                             /* Switch.              */
        curwp->w_bufp  = bp;
        curwp->w_linep = bp->b_linep;           /* For macros, ignored. */
        curwp->w_flag |= WFMODE|WFFORCE|WFHARD; /* Quite nasty.         */
        if (bp->b_nwnd++ == 0) {                /* First use.           */
                curwp->w_dotp  = bp->b_dotp;
                curwp->w_doto  = bp->b_doto;
                curwp->w_markp = bp->b_markp;
                curwp->w_marko = bp->b_marko;
                return (TRUE);
        }
        wp = wheadp;                            /* Look for old.        */
        while (wp != NULL) {
                if (wp!=curwp && wp->w_bufp==bp) {
                        curwp->w_dotp  = wp->w_dotp;
                        curwp->w_doto  = wp->w_doto;
                        curwp->w_markp = wp->w_markp;
                        curwp->w_marko = wp->w_marko;
                        break;
                }
                wp = wp->w_wndp;
        }
        return (TRUE);
}

/*
 * Dispose of a buffer, by name.
 * Ask for the name. Look it up (don't get too
 * upset if it isn't there at all!). Get quite upset
 * if the buffer is being displayed. Clear the buffer (ask
 * if the buffer has been changed). Then free the header
 * line and the buffer header. Bound to "C-X K".
 */
killbuffer(f, n)
{
        register BUFFER *bp;
        register BUFFER *bp1;
        register BUFFER *bp2;
        register int    s;
        char            bufn[NBUFN];

        if ((s=mlreply("Kill buffer: ", bufn, NBUFN)) != TRUE)
                return (s);
        if ((bp=bfind(bufn, FALSE, 0)) == NULL) /* Easy if unknown.     */
                return (TRUE);
        if (bp->b_nwnd != 0) {                  /* Error if on screen.  */
                mlwrite("Buffer is being displayed");
                return (FALSE);
        }
        if ((s=bclear(bp)) != TRUE)             /* Blow text away.      */
                return (s);
        free((char *) bp->b_linep);             /* Release header line. */
        bp1 = NULL;                             /* Find the header.     */
        bp2 = bheadp;
        while (bp2 != bp) {
                bp1 = bp2;
                bp2 = bp2->b_bufp;
        }
        bp2 = bp2->b_bufp;                      /* Next one in chain.   */
        if (bp1 == NULL)                        /* Unlink it.           */
                bheadp = bp2;
        else
                bp1->b_bufp = bp2;
        free((char *) bp);                      /* Release buffer block */
        return (TRUE);
}

/*
 * List all of the active
 * buffers. First update the special
 * buffer that holds the list. Next make
 * sure at least 1 window is displaying the
 * buffer list, splitting the screen if this
 * is what it takes. Lastly, repaint all of
 * the windows that are displaying the
 * list. Bound to "C-X C-B".
 */
listbuffers(f, n)
{
        register WINDOW *wp;
        register BUFFER *bp;
        register int    s;

        if ((s=makelist()) != TRUE)
                return (s);
        if (blistp->b_nwnd == 0) {              /* Not on screen yet.   */
                if ((wp=wpopup()) == NULL)
                        return (FALSE);
                bp = wp->w_bufp;
                if (--bp->b_nwnd == 0) {
                        bp->b_dotp  = wp->w_dotp;
                        bp->b_doto  = wp->w_doto;
                        bp->b_markp = wp->w_markp;
                        bp->b_marko = wp->w_marko;
                }
                wp->w_bufp  = blistp;
                ++blistp->b_nwnd;
        }
        wp = wheadp;
        while (wp != NULL) {
                if (wp->w_bufp == blistp) {
                        wp->w_linep = lforw(blistp->b_linep);
                        wp->w_dotp  = lforw(blistp->b_linep);
                        wp->w_doto  = 0;
                        wp->w_markp = NULL;
                        wp->w_marko = 0;
                        wp->w_flag |= WFMODE|WFHARD;
                }
                wp = wp->w_wndp;
        }
        return (TRUE);
}

/*
 * This routine rebuilds the
 * text in the special secret buffer
 * that holds the buffer list. It is called
 * by the list buffers command. Return TRUE
 * if everything works. Return FALSE if there
 * is an error (if there is no memory).
 */
makelist()
{
        register char   *cp1;
        register char   *cp2;
        register int    c;
        register BUFFER *bp;
        register LINE   *lp;
        register int    nbytes;
        register int    s;
        register int    type;
        char            b[6+1];
        char            line[128];

        blistp->b_flag &= ~BFCHG;               /* Don't complain!      */
        if ((s=bclear(blistp)) != TRUE)         /* Blow old text away   */
                return (s);
        strcpy(blistp->b_fname, "");
        if (addline("C   Size Buffer           File") == FALSE
        ||  addline("-   ---- ------           ----") == FALSE)
                return (FALSE);
        bp = bheadp;                            /* For all buffers      */
        while (bp != NULL) {
                if ((bp->b_flag&BFTEMP) != 0) { /* Skip magic ones.     */
                        bp = bp->b_bufp;
                        continue;
                }
                cp1 = &line[0];                 /* Start at left edge   */
                if ((bp->b_flag&BFCHG) != 0)    /* "*" if changed       */
                        *cp1++ = '*';
                else
                        *cp1++ = ' ';
                *cp1++ = ' ';                   /* Gap.                 */
                nbytes = 0;                     /* Count bytes in buf.  */
                lp = lforw(bp->b_linep);
                while (lp != bp->b_linep) {
                        nbytes += llength(lp)+1;
                        lp = lforw(lp);
                }
                itoa(b, 6, nbytes);             /* 6 digit buffer size. */
                cp2 = &b[0];
                while ((c = *cp2++) != 0)
                        *cp1++ = c;
                *cp1++ = ' ';                   /* Gap.                 */
                cp2 = &bp->b_bname[0];          /* Buffer name          */
                while ((c = *cp2++) != 0)
                        *cp1++ = c;
                cp2 = &bp->b_fname[0];          /* File name            */
                if (*cp2 != 0) {
                        while (cp1 < &line[1+1+6+1+NBUFN+1])
                                *cp1++ = ' ';           
                        while ((c = *cp2++) != 0) {
                                if (cp1 < &line[128-1])
                                        *cp1++ = c;
                        }
                }
                *cp1 = 0;                       /* Add to the buffer.   */
                if (addline(line) == FALSE)
                        return (FALSE);
                bp = bp->b_bufp;
        }
        return (TRUE);                          /* All done             */
}
#endif

