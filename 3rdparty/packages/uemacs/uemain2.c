/*
 * This program is in public domain; written by Dave G. Conroy.
 * This file contains the main driving routine, and some keyboard processing
 * code, for the MicroEMACS screen editor.
 *
 * REVISION HISTORY:
 *
 * 1.0  Steve Wilhite, 30-Nov-85
 *      - Removed the old LK201 and VT100 logic. Added code to support the
 *        DEC Rainbow keyboard (which is a LK201 layout) using the the Level
 *        1 Console In ROM INT. See "rainbow.h" for the function key definitions
.
 *
 * 2.0  George Jones, 12-Dec-85
 *      - Ported to Amiga.
 */
#include        <stdio.h>
#include        "ueed.h"
#ifdef VMS
#include        <ssdef.h>
#define GOOD    (SS$_NORMAL)
#endif

#ifndef GOOD
#define GOOD    0
#endif

#include "uemain.h"
        
/*
 * This is the general command execution routine. It handles the fake binding
 * of all the keys to "self-insert". It also clears out the "thisflag" word,
 * and arranges to move it to the "lastflag", so that the next command can
 * look at it. Return the status of command.
 */
execute(c, f, n)
int c,f,n;
{
        register KEYTAB *ktp;
        int status;

        status = TRUE;
        ktp = &keytab[0];                       /* Look in key table.   */
        while (ktp->k_code) {
                if (ktp->k_code == c) {
                        thisflag = 0;
                        status = (*ktp->k_fp)(f, n);
                        lastflag = thisflag;
                        return(status);
                }
                ++ktp;
        }

        /*
         * If a space was typed, fill column is defined, the argument is non-
         * negative, and we are now past fill column, perform word wrap.
         */
        if (c == ' ' && fillcol > 0 && n>=0 && getccol(FALSE) > fillcol)
                wrapword();

        if ((c>=0x20 && c<=0x7E)                /* Self inserting.      */
        ||  (c>=0xA0 && c<=0xFE)) {
                if (n <= 0) {                   /* Fenceposts.          */
                        lastflag = 0;
                }
                thisflag = 0;                   /* For the future.      */
                linsert(n, c);
                lastflag = thisflag;
                return(TRUE);
        } else {
                lastflag = 0;                   /* Fake last flags.     */
                return(FALSE);
        }
}

/*
 * Read in a key.
 * Do the standard keyboard preprocessing. Convert the keys to the internal
 * character set.
 */
getkey()
{
        register int    c;

        c = (*term.t_getchar)();
#ifdef DEBUG
        printf("%4X",c);
#endif

#ifdef RAINBOW

        if (c & Function_Key)
                {
                int i;

                for (i = 0; i < lk_map_size; i++)
                        if (c == lk_map[i][0])
                                return lk_map[i][1];
                }
        else if (c == Shift + 015) return CTRL | 'J';
        else if (c == Shift + 0x7F) return META | 0x7F;
#endif

        if (c == METACH) {                      /* Apply M- prefix      */
#ifdef DEBUG
                printf("META");
#endif
                c = getctl();
#ifdef DEBUG
                printf("CTL=%4X",c);
#endif
                return (META | c);
        }

        if (c>=0x00 && c<=0x1F)                 /* C0 control -> C-     */
                c = CTRL | (c+'@');
#ifdef DEBUG
        printf("CTRL=%4X",c);
#endif
        return (c);
}

/*
 * Get a key.
 * Apply control modifications to the read key.
 */
getctl()
{
        register int    c;

        c = (*term.t_getchar)();
        if (c>='a' && c<='z')                   /* Force to upper       */
                c -= 0x20;
        if (c>=0x00 && c<=0x1F)                 /* C0 control -> C-     */
                c = CTRL | (c+'@');
        return (c);
}

/*
 * Fancy quit command, as implemented by Norm. If the current buffer has
 * changed do a write current buffer and exit emacs, otherwise simply exit.
 */
quickexit(f, n)
{
        if ((curbp->b_flag&BFCHG) != 0          /* Changed.             */
        && (curbp->b_flag&BFTEMP) == 0)         /* Real.                */
                filesave(f, n);
        quit(f, n);                             /* conditionally quit   */
}

