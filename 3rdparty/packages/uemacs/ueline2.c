/*
 * The functions in this file are a general set of line management utilities.
 * They are the only routines that touch the text. They also touch the buffer
 * and window structures, to make sure that the necessary updating gets done.
 * There are routines in this file that handle the kill buffer too. It i
sn't
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

extern char    *kbufp;                 /* Kill buffer data             */
extern int     kused;                    /* # of bytes used in KB        */
extern int     ksize;                    /* # of bytes allocated in KB   */

/*
 * Insert a newline into the buffer at the current location of dot in the
 * current window. The funny ass-backwards way it does things is not a botch;
 * it just makes the last line in the file not a special case. Return TRUE if
 * everything works out and FALSE on error (memory allocation failure). The
 * update of dot and mark is a bit easier then in the above case, because the
 * split forces more updating.
 */
lnewline()
{
        register char   *cp1;
        register char   *cp2;
        register LINE   *lp1;
        register LINE   *lp2;
        register int    doto;
        register WINDOW *wp;

        lchange(WFHARD);
        lp1  = curwp->w_dotp;                   /* Get the address and  */
        doto = curwp->w_doto;                   /* offset of "."        */
        if ((lp2=lalloc(doto)) == NULL)         /* New first half line  */
                return (FALSE);
        cp1 = &lp1->l_text[0];                  /* Shuffle text around  */
        cp2 = &lp2->l_text[0];
        while (cp1 != &lp1->l_text[doto])
                *cp2++ = *cp1++;
        cp2 = &lp1->l_text[0];
        while (cp1 != &lp1->l_text[lp1->l_used])
                *cp2++ = *cp1++;
        lp1->l_used -= doto;
        lp2->l_bp = lp1->l_bp;
        lp1->l_bp = lp2;
        lp2->l_bp->l_fp = lp2;
        lp2->l_fp = lp1;
        wp = wheadp;                            /* Windows              */
        while (wp != NULL) {
                if (wp->w_linep == lp1)
                        wp->w_linep = lp2;
                if (wp->w_dotp == lp1) {
                        if (wp->w_doto < doto)
                                wp->w_dotp = lp2;
                        else
                                wp->w_doto -= doto;
                }
                if (wp->w_markp == lp1) {
                        if (wp->w_marko < doto)
                                wp->w_markp = lp2;
                        else
                                wp->w_marko -= doto;
                }
                wp = wp->w_wndp;
        }       
        return (TRUE);
}

/*
 * This function deletes "n" bytes, starting at dot. It understands how do deal
 * with end of lines, etc. It returns TRUE if all of the characters were
 * deleted, and FALSE if they were not (because dot ran into the end of the
 * buffer. The "kflag" is TRUE if the text should be put in the kill buffer.
 */
ldelete(n, kflag)
{
        register char   *cp1;
        register char   *cp2;
        register LINE   *dotp;
        register int    doto;
        register int    chunk;
        register WINDOW *wp;

        while (n != 0) {
                dotp = curwp->w_dotp;
                doto = curwp->w_doto;
                if (dotp == curbp->b_linep)     /* Hit end of buffer.   */
                        return (FALSE);
                chunk = dotp->l_used-doto;      /* Size of chunk.       */
                if (chunk > n)
                        chunk = n;
                if (chunk == 0) {               /* End of line, merge.  */
                        lchange(WFHARD);
                        if (ldelnewline() == FALSE
                        || (kflag!=FALSE && kinsert('\n')==FALSE))
                                return (FALSE);
                        --n;
                        continue;
                }
                lchange(WFEDIT);
                cp1 = &dotp->l_text[doto];      /* Scrunch text.        */
                cp2 = cp1 + chunk;
                if (kflag != FALSE) {           /* Kill?                */
                        while (cp1 != cp2) {
                                if (kinsert(*cp1) == FALSE)
                                        return (FALSE);
                                ++cp1;
                        }
                        cp1 = &dotp->l_text[doto];
                }
                while (cp2 != &dotp->l_text[dotp->l_used])
                        *cp1++ = *cp2++;
                dotp->l_used -= chunk;
                wp = wheadp;                    /* Fix windows          */
                while (wp != NULL) {
                        if (wp->w_dotp==dotp && wp->w_doto>=doto) {
                                wp->w_doto -= chunk;
                                if (wp->w_doto < doto)
                                        wp->w_doto = doto;
                        }       
                        if (wp->w_markp==dotp && wp->w_marko>=doto) {
                                wp->w_marko -= chunk;
                                if (wp->w_marko < doto)
                                        wp->w_marko = doto;
                        }
                        wp = wp->w_wndp;
                }
                n -= chunk;
        }
        return (TRUE);
}

/*
 * Delete a newline. Join the current line with the next line. If the next line
 * is the magic header line always return TRUE; merging the last line with the
 * header line can be thought of as always being a successful operation, even
 * if nothing is done, and this makes the kill buffer work "right". Easy cases
 * can be done by shuffling data around. Hard cases require that lines be moved
 * about in memory. Return FALSE on error and TRUE if all looks ok. Called by
 * "ldelete" only.
 */
ldelnewline()
{
        register char   *cp1;
        register char   *cp2;
        register LINE   *lp1;
        register LINE   *lp2;
        register LINE   *lp3;
        register WINDOW *wp;

        lp1 = curwp->w_dotp;
        lp2 = lp1->l_fp;
        if (lp2 == curbp->b_linep) {            /* At the buffer end.   */
                if (lp1->l_used == 0)           /* Blank line.          */
                        lfree(lp1);
                return (TRUE);
        }
        if (lp2->l_used <= lp1->l_size-lp1->l_used) {
                cp1 = &lp1->l_text[lp1->l_used];
                cp2 = &lp2->l_text[0];
                while (cp2 != &lp2->l_text[lp2->l_used])
                        *cp1++ = *cp2++;
                wp = wheadp;
                while (wp != NULL) {
                        if (wp->w_linep == lp2)
                                wp->w_linep = lp1;
                        if (wp->w_dotp == lp2) {
                                wp->w_dotp  = lp1;
                                wp->w_doto += lp1->l_used;
                        }
                        if (wp->w_markp == lp2) {
                                wp->w_markp  = lp1;
                                wp->w_marko += lp1->l_used;
                        }
                        wp = wp->w_wndp;
                }               
                lp1->l_used += lp2->l_used;
                lp1->l_fp = lp2->l_fp;
                lp2->l_fp->l_bp = lp1;
                free((char *) lp2);
                return (TRUE);
        }
        if ((lp3=lalloc(lp1->l_used+lp2->l_used)) == NULL)
                return (FALSE);
        cp1 = &lp1->l_text[0];
        cp2 = &lp3->l_text[0];
        while (cp1 != &lp1->l_text[lp1->l_used])
                *cp2++ = *cp1++;
        cp1 = &lp2->l_text[0];
        while (cp1 != &lp2->l_text[lp2->l_used])
                *cp2++ = *cp1++;
        lp1->l_bp->l_fp = lp3;
        lp3->l_fp = lp2->l_fp;
        lp2->l_fp->l_bp = lp3;
        lp3->l_bp = lp1->l_bp;
        wp = wheadp;
        while (wp != NULL) {
                if (wp->w_linep==lp1 || wp->w_linep==lp2)
                        wp->w_linep = lp3;
                if (wp->w_dotp == lp1)
                        wp->w_dotp  = lp3;
                else if (wp->w_dotp == lp2) {
                        wp->w_dotp  = lp3;
                        wp->w_doto += lp1->l_used;
                }
                if (wp->w_markp == lp1)
                        wp->w_markp  = lp3;
                else if (wp->w_markp == lp2) {
                        wp->w_markp  = lp3;
                        wp->w_marko += lp1->l_used;
                }
                wp = wp->w_wndp;
        }
        free((char *) lp1);
        free((char *) lp2);
        return (TRUE);
}

/*
 * Delete all of the text saved in the kill buffer. Called by commands when a
 * new kill context is being created. The kill buffer array is released, just
 * in case the buffer has grown to immense size. No errors.
 */
kdelete()
{
        if (kbufp != NULL) {
                free((char *) kbufp);
                kbufp = NULL;
                kused = 0;
                ksize = 0;
        }
}

/*
 * Insert a character to the kill buffer, enlarging the buffer if there isn't
 * any room. Always grow the buffer in chunks, on the assumption that if you
 * put something in the kill buffer you are going to put more stuff there too
 * later. Return TRUE if all is well, and FALSE on errors.
 */
kinsert(c)
{
        register char   *nbufp;
        register int    i;

        if (kused == ksize) {
                if ((nbufp=malloc(ksize+KBLOCK)) == NULL)
                        return (FALSE);
                for (i=0; i<ksize; ++i)
                        nbufp[i] = kbufp[i];
                if (kbufp != NULL)
                        free((char *) kbufp);
                kbufp  = nbufp;
                ksize += KBLOCK;
        }
        kbufp[kused++] = c;
        return (TRUE);
}

/*
 * This function gets characters from the kill buffer. If the character index
 * "n" is off the end, it returns "-1". This lets the caller just scan along
 * until it gets a "-1" back.
 */
kremove(n)
{
        if (n >= kused)
                return (-1);
        else
                return (kbufp[n] & 0xFF);
}



