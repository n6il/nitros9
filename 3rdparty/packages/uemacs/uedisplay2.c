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

extern VIDEO   **vscreen;                      /* Virtual screen. */

/*
 * Redisplay the mode line for the window pointed to by the "wp". This is the
 * only routine that has any idea of how the modeline is formatted. You can
 * change the modeline format by hacking at this routine. Called by "update"
 * any time there is a dirty window.
 */
modeline(wp)
    WINDOW *wp;
{
    register char *cp;
    register int c;
    register int n;
    register BUFFER *bp;

    n = wp->w_toprow+wp->w_ntrows;              /* Location. */
    vscreen[n]->v_flag |= VFCHG;                /* Redraw next time. */
    vtmove(n, 0);                               /* Seek to right line. */
    vtputc('-');
    bp = wp->w_bufp;

    if ((bp->b_flag&BFCHG) != 0)                /* "*" if changed. */
        vtputc('*');
    else
        vtputc('-');

    n  = 2;
    cp = " MicroEMACS -";                     /* Buffer name. */

    while ((c = *cp++) != 0)
        {
        vtputc(c);
        ++n;
        }

#ifndef OS9
    cp = &bp->b_bname[0];

    while ((c = *cp++) != 0)
        {
        vtputc(c);
        ++n;
        }

    vtputc(' ');
    ++n;
#endif

    if (bp->b_fname[0] != 0)            /* File name. */
        {
        cp = " File: ";

        while ((c = *cp++) != 0)
            {
            vtputc(c);
            ++n;
            }

        cp = &bp->b_fname[0];

        while ((c = *cp++) != 0)
            {
            vtputc(c);
            ++n;
            }

        vtputc(' ');
        ++n;
        }

#ifdef WFDEBUG
    vtputc('-');
    vtputc((wp->w_flag&WFMODE)!=0  ? 'M' : '-');
    vtputc((wp->w_flag&WFHARD)!=0  ? 'H' : '-');
    vtputc((wp->w_flag&WFEDIT)!=0  ? 'E' : '-');
    vtputc((wp->w_flag&WFMOVE)!=0  ? 'V' : '-');
    vtputc((wp->w_flag&WFFORCE)!=0 ? 'F' : '-');
    n += 6;
#endif

    while (n < term.t_ncol)             /* Pad to full width. */
        {
        vtputc('-');
        ++n;
        }
}

/*
 * Send a command to the terminal to move the hardware cursor to row "row"
 * and column "col". The row and column arguments are origin 0. Optimize out
 * random calls. Update "ttrow" and "ttcol".
 */
movecursor(row, col)
    {
    if (row!=ttrow || col!=ttcol)
        {
        ttrow = row;
        ttcol = col;
        (*term.t_move)(row, col);
        }
    }

/*
 * Erase the message line. This is a special routine because the message line
 * is not considered to be part of the virtual screen. It always works
 * immediately; the terminal buffer is flushed via a call to the flusher.
 */
mlerase()
    {
    movecursor(term.t_nrow, 0);
    (*term.t_eeol)();
    (*term.t_flush)();
    mpresf = FALSE;
    }

/*
 * Ask a yes or no question in the message line. Return either TRUE, FALSE, or
 * ABORT. The ABORT status is returned if the user bumps out of the question
 * with a ^G. Used any time a confirmation is required.
 */
mlyesno(prompt)
    char *prompt;
    {
    register int s;
    char buf[64];

    for (;;)
        {
        strcpy(buf, prompt);
        strcat(buf, " [y/n]? ");
        s = mlreply(buf, buf, sizeof(buf));

        if (s == ABORT)
            return (ABORT);

        if (s != FALSE)
            {
            if (buf[0]=='y' || buf[0]=='Y')
                return (TRUE);

            if (buf[0]=='n' || buf[0]=='N')
                return (FALSE);
            }
        }
    }

/*
 * Write a prompt into the message line, then read back a response. Keep
 * track of the physical position of the cursor. If we are in a keyboard
 * macro throw the prompt away, and return the remembered response. This
 * lets macros run at full speed. The reply is always terminated by a carriage
 * return. Handle erase, kill, and abort keys.
 */
mlreply(prompt, buf, nbuf)
    char *prompt;
    char *buf;
    {
    register int cpos;
    register int i;
    register int c;

    cpos = 0;

    if (kbdmop != NULL)
        {
        while ((c = *kbdmop++) != '\0')
            buf[cpos++] = c;

        buf[cpos] = 0;

        if (buf[0] == 0)
            return (FALSE);

        return (TRUE);
        }

    mlwrite(prompt);

    for (;;)
        {
        c = (*term.t_getchar)();

        switch (c)
            {
            case 0x0D:                  /* Return, end of line */
                buf[cpos++] = 0;

                if (kbdmip != NULL)
                    {
                    if (kbdmip+cpos > &kbdm[NKBDM-3])
                        {
                        ctrlg(FALSE, 0);
                        (*term.t_flush)();
                        return (ABORT);
                        }

                    for (i=0; i<cpos; ++i)
                        *kbdmip++ = buf[i];
                    }

                (*term.t_putchar)('\r');
                ttcol = 0;
                (*term.t_flush)();

                if (buf[0] == 0)
                    return (FALSE);

                return (TRUE);

            case 0x07:                  /* Bell, abort */
                (*term.t_putchar)('^');
                (*term.t_putchar)('G');
                ttcol += 2;
                ctrlg(FALSE, 0);
                (*term.t_flush)();
                return (ABORT);

            case 0x7F:                  /* Rubout, erase */
            case 0x08:                  /* Backspace, erase */
                if (cpos != 0)
                    {
                    (*term.t_putchar)('\b');
                    (*term.t_putchar)(' ');
                    (*term.t_putchar)('\b');
                    --ttcol;

                    if (buf[--cpos] < 0x20)
                        {
                        (*term.t_putchar)('\b');
                        (*term.t_putchar)(' ');
                        (*term.t_putchar)('\b');
                        --ttcol;
                        }

                    (*term.t_flush)();
                    }

                break;

            case 0x15:                  /* C-U, kill */
                while (cpos != 0)
                    {
                    (*term.t_putchar)('\b');
                    (*term.t_putchar)(' ');
                    (*term.t_putchar)('\b');
                    --ttcol;

                    if (buf[--cpos] < 0x20)
                        {
                        (*term.t_putchar)('\b');
                        (*term.t_putchar)(' ');
                        (*term.t_putchar)('\b');
                        --ttcol;
                        }
                    }

                (*term.t_flush)();
                break;

            default:
                if (cpos < nbuf-1)
                    {
                    buf[cpos++] = c;

                    if (c < ' ')
                        {
                        (*term.t_putchar)('^');
                        ++ttcol;
                        c ^= 0x40;
                        }

                    (*term.t_putchar)(c);
                    ++ttcol;
                    (*term.t_flush)();
                    }
            }
        }
    }


