/*
 * The functions in this file are a general set of line management utilities.
 * They are the only routines that touch the text. They also touch the buffer
 * and window structures, to make sure that the necessary updating gets done.
 * There are routines in this file that handle the kill buffer too. It isn't
 * here for any good reason.
 *
 * Note that this code only updates the dot and mark values in the window list.
 * Since all the code acts on the current window, the buffer that we are
 * editing must be being displayed, which means that "b_nwnd" is non zero,
 * which means that the dot and mark values in the buffer headers are nonsense.
 */

#include        <stdio.h>
#include        "ueed.h"

#define NBLOCK  16                      /* Line block chunk size        */
#define KBLOCK  256                     /* Kill buffer block size       */

char    *kbufp  = NULL;                 /* Kill buffer data             */
int     kused   = 0;                    /* # of bytes used in KB        */
int     ksize   = 0;                    /* # of bytes allocated in KB   */

/*
 * This routine allocates a block of memory large enough to hold a LINE
 * containing "used" characters. The block is always rounded up a bit. Return
 * a pointer to the new block, or NULL if there isn't any memory left. Print a
 * message in the message line if no space.
 */
LINE    *lalloc(used)
register int    used;
{
        register LINE   *lp;
        register int    size;

        size = (used+NBLOCK-1) & ~(NBLOCK-1);
        if (size == 0)                          /* Assume that an empty */
                size = NBLOCK;                  /* line is for type-in. */
        if ((lp = (LINE *) malloc(sizeof(LINE)+size)) == NULL) {
                mlwrite("Cannot allocate %d bytes", size);
                return (NULL);
        }
        lp->l_size = size;
        lp->l_used = used;
        return (lp);
}

/*
 * Delete line "lp". Fix all of the links that might point at it (they are
 * moved to offset 0 of the next line. Unlink the line from whatever buffer it
 * might be in. Release the memory. The buffers are updated too; the magic
 * conditions described in the above comments don't hold here.
 */
lfree(lp)
register LINE   *lp;
{
        register BUFFER *bp;
        register WINDOW *wp;

        wp = wheadp;
        while (wp != NULL) {
                if (wp->w_linep == lp)
                        wp->w_linep = lp->l_fp;
                if (wp->w_dotp  == lp) {
                        wp->w_dotp  = lp->l_fp;
                        wp->w_doto  = 0;
                }
                if (wp->w_markp == lp) {
                        wp->w_markp = lp->l_fp;
                        wp->w_marko = 0;
                }
                wp = wp->w_wndp;
        }
        bp = bheadp;
        while (bp != NULL) {
                if (bp->b_nwnd == 0) {
                        if (bp->b_dotp  == lp) {
                                bp->b_dotp = lp->l_fp;
                                bp->b_doto = 0;
                        }
                        if (bp->b_markp == lp) {
                                bp->b_markp = lp->l_fp;
                                bp->b_marko = 0;
                        }
                }
                bp = bp->b_bufp;
        }
        lp->l_bp->l_fp = lp->l_fp;
        lp->l_fp->l_bp = lp->l_bp;
        free((char *) lp);
}

/*
 * This routine gets called when a character is changed in place in the current
 * buffer. It updates all of the required flags in the buffer and window
 * system. The flag used is passed as an argument; if the buffer is being
 * displayed in more than 1 window we change EDIT t HARD. Set MODE if the
 * mode line needs to be updated (the "*" has to be set).
 */
lchange(flag)
register int    flag;
{
        register WINDOW *wp;
        if (curbp->b_nwnd != 1)                 /* Ensure hard.         */
                flag = WFHARD;
        if ((curbp->b_flag&BFCHG) == 0) {       /* First change, so     */
                flag |= WFMODE;                 /* update mode lines.   */
                curbp->b_flag |= BFCHG;
        }
        wp = wheadp;
        while (wp != NULL) {
                if (wp->w_bufp == curbp)
                        wp->w_flag |= flag;
                wp = wp->w_wndp;
        }
}

/*
 * Insert "n" copies of the character "c" at the current location of dot. In
 * the easy case all that happens is the text is stored in the line. In the
 * hard case, the line has to be reallocated. When the window list is updated,
 * take special care; I screwed it up once. You always update dot in the
 * current window. You update mark, and a dot in another window, if it is
 * greater than the place where you did the insert. Return TRUE if all is
 * well, and FALSE on errors.
 */
linsert(n, c)
{
        register char   *cp1;
        register char   *cp2;
        register LINE   *lp1;
        register LINE   *lp2;
        register LINE   *lp3;
        register int    doto;
        register int    i;
        register WINDOW *wp;

        lchange(WFEDIT);
        lp1 = curwp->w_dotp;                    /* Current line         */
        if (lp1 == curbp->b_linep) {            /* At the end: special  */
                if (curwp->w_doto != 0) {
                        mlwrite("bug: linsert");
                        return (FALSE);
                }
                if ((lp2=lalloc(n)) == NULL)    /* Allocate new line    */
                        return (FALSE);
                lp3 = lp1->l_bp;                /* Previous line        */
                lp3->l_fp = lp2;                /* Link in              */
                lp2->l_fp = lp1;
                lp1->l_bp = lp2;
                lp2->l_bp = lp3;
                for (i=0; i<n; ++i)
                        lp2->l_text[i] = c;
                curwp->w_dotp = lp2;
                curwp->w_doto = n;
                return (TRUE);
        }
        doto = curwp->w_doto;                   /* Save for later.      */
        if (lp1->l_used+n > lp1->l_size) {      /* Hard: reallocate     */
                if ((lp2=lalloc(lp1->l_used+n)) == NULL)
                        return (FALSE);
                cp1 = &lp1->l_text[0];
                cp2 = &lp2->l_text[0];
                while (cp1 != &lp1->l_text[doto])
                        *cp2++ = *cp1++;
                cp2 += n;
                while (cp1 != &lp1->l_text[lp1->l_used])
                        *cp2++ = *cp1++;
                lp1->l_bp->l_fp = lp2;
                lp2->l_fp = lp1->l_fp;
                lp1->l_fp->l_bp = lp2;
                lp2->l_bp = lp1->l_bp;
                free((char *) lp1);
        } else {                                /* Easy: in place       */
                lp2 = lp1;                      /* Pretend new line     */
                lp2->l_used += n;
                cp2 = &lp1->l_text[lp1->l_used];
                cp1 = cp2-n;
                while (cp1 != &lp1->l_text[doto])
                        *--cp2 = *--cp1;
        }
        for (i=0; i<n; ++i)                     /* Add the characters   */
                lp2->l_text[doto+i] = c;
        wp = wheadp;                            /* Update windows       */
        while (wp != NULL) {
                if (wp->w_linep == lp1)
                        wp->w_linep = lp2;
                if (wp->w_dotp == lp1) {
                        wp->w_dotp = lp2;
                        if (wp==curwp || wp->w_doto>doto)
                                wp->w_doto += n;
                }
                if (wp->w_markp == lp1) {
                        wp->w_markp = lp2;
                        if (wp->w_marko > doto)
                                wp->w_marko += n;
                }
                wp = wp->w_wndp;
        }
        return (TRUE);
}
