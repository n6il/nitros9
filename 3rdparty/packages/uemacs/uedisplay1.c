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
#define DISPLAY1 1
#include        "uedisplay.h"

VIDEO   **vscreen;                      /* Virtual screen. */
VIDEO   **pscreen;                      /* Physical screen. */

/*
 * Initialize the data structures used by the display code. The edge vectors
 * used to access the screens are set up. The operating system's terminal I/O
 * channel is set up. All the other things get initialized at compile time.
 * The original window has "WFCHG" set, so that it will get completely
 * redrawn on the first call to "update".
 */
vtinit()
{
    register int i;
    register VIDEO *vp;

    (*term.t_open)();
    vscreen = (VIDEO **) malloc(term.t_nrow*sizeof(VIDEO *));

    if (vscreen == NULL)
        exit(1);

    pscreen = (VIDEO **) malloc(term.t_nrow*sizeof(VIDEO *));

    if (pscreen == NULL)
        exit(1);

    for (i = 0; i < term.t_nrow; ++i)
        {
        vp = (VIDEO *) malloc(sizeof(VIDEO)+term.t_ncol);

        if (vp == NULL)
            exit(1);

        vscreen[i] = vp;
        vp = (VIDEO *) malloc(sizeof(VIDEO)+term.t_ncol);

        if (vp == NULL)
            exit(1);

        pscreen[i] = vp;
        }
}

/*
 * Clean up the virtual terminal system, in anticipation for a return to the
 * operating system. Move down to the last line and clear it out (the next
 * system prompt will be written in the line). Shut down the channel to the
 * terminal.
 */
vttidy()
{
    movecursor(term.t_nrow, 0);
    (*term.t_eeol)();
    (*term.t_close)();
}

/*
 * Set the virtual cursor to the specified row and column on the virtual
 * screen. There is no checking for nonsense values; this might be a good
 * idea during the early stages.
 */
vtmove(row, col)
{
    vtrow = row;
    vtcol = col;
}

/*
 * Write a character to the virtual screen. The virtual row and column are
 * updated. If the line is too long put a "$" in the last column. This routine
 * only puts printing characters into the virtual terminal buffers. Only
 * column overflow is checked.
 */
vtputc(c)
    int c;

{
    register VIDEO      *vp;

    vp = vscreen[vtrow];

    if (vtcol >= term.t_ncol)
        vp->v_text[term.t_ncol - 1] = '$';
    else if (c == '\t')
        {
        do
            {
            vtputc(' ');
            }
        while ((vtcol&0x07) != 0);
        }
    else if (c < 0x20 || c == 0x7F)
        {
        vtputc('^');
        vtputc(c ^ 0x40);
        }
    else
        vp->v_text[vtcol++] = c;                
}

/*
 * Erase from the end of the software cursor to the end of the line on which
 * the software cursor is located.
 */
vteeol()
{
    register VIDEO      *vp;

    vp = vscreen[vtrow];
    while (vtcol < term.t_ncol)
        vp->v_text[vtcol++] = ' ';
}

/*
 * Make sure that the display is right. This is a three part process. First,
 * scan through all of the windows looking for dirty ones. Check the framing,
 * and refresh the screen. Second, make sure that "currow" and "curcol" are
 * correct for the current window. Third, make the virtual and physical
 * screens the same.
 */
update()
{
    register LINE *lp;
    register WINDOW *wp;
    register VIDEO *vp1;
    register VIDEO *vp2;
    register int i;
    register int j;
    register int c;

    wp = wheadp;

    while (wp != NULL)
        {
        /* Look at any window with update flags set on. */

        if (wp->w_flag != 0)
            {
            /* If not force reframe, check the framing. */

            if ((wp->w_flag & WFFORCE) == 0)
                {
                lp = wp->w_linep;

                for (i = 0; i < wp->w_ntrows; ++i)
                    {
                    if (lp == wp->w_dotp)
                        goto out;

                    if (lp == wp->w_bufp->b_linep)
                        break;

                    lp = lforw(lp);
                    }
                }

            /* Not acceptable, better compute a new value for the line at the
             * top of the window. Then set the "WFHARD" flag to force full
             * redraw.
             */
            i = wp->w_force;

            if (i > 0)
                {
                --i;

                if (i >= wp->w_ntrows)
                  i = wp->w_ntrows-1;
                }
            else if (i < 0)
                {
                i += wp->w_ntrows;

                if (i < 0)
                    i = 0;
                }
            else
                i = wp->w_ntrows/2;

            lp = wp->w_dotp;

            while (i != 0 && lback(lp) != wp->w_bufp->b_linep)
                {
                --i;
                lp = lback(lp);
                }

            wp->w_linep = lp;
            wp->w_flag |= WFHARD;       /* Force full. */

out:
            /* Try to use reduced update. Mode line update has its own special
             * flag. The fast update is used if the only thing to do is within
             * the line editing.
             */
            lp = wp->w_linep;
            i = wp->w_toprow;

            if ((wp->w_flag & ~WFMODE) == WFEDIT)
                {
                while (lp != wp->w_dotp)
                    {
                    ++i;
                    lp = lforw(lp);
                    }

                vscreen[i]->v_flag |= VFCHG;
                vtmove(i, 0);

                for (j = 0; j < llength(lp); ++j)
                    vtputc(lgetc(lp, j));

                vteeol();
                }
             else if ((wp->w_flag & (WFEDIT | WFHARD)) != 0)
                {
                while (i < wp->w_toprow+wp->w_ntrows)
                    {
                    vscreen[i]->v_flag |= VFCHG;
                    vtmove(i, 0);

                    if (lp != wp->w_bufp->b_linep)
                        {
                        for (j = 0; j < llength(lp); ++j)
                            vtputc(lgetc(lp, j));

                        lp = lforw(lp);
                        }

                    vteeol();
                    ++i;
                    }
                }
#ifndef WFDEBUG
            if ((wp->w_flag&WFMODE) != 0)
                modeline(wp);

            wp->w_flag  = 
            wp->w_force = 0;
#endif
            }           
#ifdef WFDEBUG
        modeline(wp);
        wp->w_flag =  
        wp->w_force = 0;
#endif
        wp = wp->w_wndp;
        }

    /* Always recompute the row and column number of the hardware cursor. This
     * is the only update for simple moves.
     */
    lp = curwp->w_linep;
    currow = curwp->w_toprow;

    while (lp != curwp->w_dotp)
        {
        ++currow;
        lp = lforw(lp);
        }

    curcol = 
    i = 0;

    while (i < curwp->w_doto)
        {
        c = lgetc(lp, i++);

        if (c == '\t')
            curcol |= 0x07;
        else if (c < 0x20 || c == 0x7F)
            ++curcol;

        ++curcol;
        }

    if (curcol >= term.t_ncol)          /* Long line. */
        curcol = term.t_ncol-1;

    /* Special hacking if the screen is garbage. Clear the hardware screen,
     * and update your copy to agree with it. Set all the virtual screen
     * change bits, to force a full update.
     */
    if (sgarbf != FALSE)
        {
        for (i = 0; i < term.t_nrow; ++i)
            {
            vscreen[i]->v_flag |= VFCHG;
            vp1 = pscreen[i];
            for (j = 0; j < term.t_ncol; ++j)
                vp1->v_text[j] = ' ';
            }

        movecursor(0, 0);               /* Erase the screen. */
        (*term.t_eeop)();
        sgarbf = FALSE;                 /* Erase-page clears */
        mpresf = FALSE;                 /* the message area. */
        }

    /* Make sure that the physical and virtual displays agree. Unlike before,
     * the "updateline" code is only called with a line that has been updated
     * for sure.
     */
    for (i = 0; i < term.t_nrow; ++i)
        {
        vp1 = vscreen[i];

        if ((vp1->v_flag&VFCHG) != 0)
            {
            vp1->v_flag &= ~VFCHG;
            vp2 = pscreen[i];
            updateline(i, &vp1->v_text[0], &vp2->v_text[0]);
            }
        }

    /* Finally, update the hardware cursor and flush out buffers. */

    movecursor(currow, curcol);
    (*term.t_flush)();
}

/*
 * Update a single line. This does not know how to use insert or delete
 * character sequences; we are using VT52 functionality. Update the physical
 * row and column variables. It does try an exploit erase to end of line. The
 * RAINBOW version of this routine uses fast video.
 */
updateline(row, vline, pline)
    char vline[];
    char pline[];
{
#ifdef RAINBOW
    register char *cp1;
    register char *cp2;
    register int nch;

    cp1 = &vline[0];                    /* Use fast video. */
    cp2 = &pline[0];
    putline(row+1, 1, cp1);
    nch = term.t_ncol;

    do
        {
        *cp2 = *cp1;
        ++cp2;
        ++cp1;
        }
    while (--nch);
#else
    register char *cp1;
    register char *cp2;
    register char *cp3;
    register char *cp4;
    register char *cp5;
    register int nbflag;

    cp1 = &vline[0];                    /* Compute left match.  */
    cp2 = &pline[0];

    while (cp1!=&vline[term.t_ncol] && cp1[0]==cp2[0])
        {
        ++cp1;
        ++cp2;
        }

    /* This can still happen, even though we only call this routine on changed
     * lines. A hard update is always done when a line splits, a massive
     * change is done, or a buffer is displayed twice. This optimizes out most
     * of the excess updating. A lot of computes are used, but these tend to
     * be hard operations that do a lot of update, so I don't really care.
     */
    if (cp1 == &vline[term.t_ncol])             /* All equal. */
        return;

    nbflag = FALSE;
    cp3 = &vline[term.t_ncol];          /* Compute right match. */
    cp4 = &pline[term.t_ncol];

    while (cp3[-1] == cp4[-1])
        {
        --cp3;
        --cp4;
        if (cp3[0] != ' ')              /* Note if any nonblank */
            nbflag = TRUE;              /* in right match. */
        }

    cp5 = cp3;

    if (nbflag == FALSE)                /* Erase to EOL ? */
        {
        while (cp5!=cp1 && cp5[-1]==' ')
            --cp5;

        if (cp3-cp5 <= 3)               /* Use only if erase is */
            cp5 = cp3;                  /* fewer characters. */
        }

    movecursor(row, cp1-&vline[0]);     /* Go to start of line. */

    while (cp1 != cp5)                  /* Ordinary. */
        {
        (*term.t_putchar)(*cp1);
        ++ttcol;
        *cp2++ = *cp1++;
        }

    if (cp5 != cp3)                     /* Erase. */
        {
        (*term.t_eeol)();
        while (cp1 != cp3)
            *cp2++ = *cp1++;
        }
#endif
}

