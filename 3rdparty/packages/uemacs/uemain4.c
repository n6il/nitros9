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

#define MAIN1 1
#include "uemain.h"

/*
 * Initialize all of the buffers and windows. The buffer name is passed down
 * as an argument, because the main routine may have been told to read in a
 * file by default, and we want the buffer name to be right.
 */
edinit(bname)
char    bname[];
{
        register BUFFER *bp;
        register WINDOW *wp;

        bp = bfind(bname, TRUE, 0);             /* First buffer         */
        blistp = bfind("[List]", TRUE, BFTEMP); /* Buffer list buffer   */
        wp = (WINDOW *) malloc(sizeof(WINDOW)); /* First window         */
        if (bp==NULL || wp==NULL || blistp==NULL)
                exit(1);
        curbp  = bp;                            /* Make this current    */
        wheadp = wp;
        curwp  = wp;
        wp->w_bufp  = bp;
        bp->b_nwnd  = 1;                        /* Displayed.           */
        wp->w_linep = bp->b_linep;
        wp->w_dotp  = bp->b_linep;
        wp->w_wndp  =                      /* Initialize window    */
        wp->w_doto  = 
        wp->w_markp = 
        wp->w_marko = 
        wp->w_toprow = 
        wp->w_force = 0;
        wp->w_ntrows = term.t_nrow-1;           /* "-1" for mode line.  */
        wp->w_flag  = WFMODE|WFHARD;            /* Full.                */
}


