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

#include "uemain.h"

/*
 * Quit command. If an argument, always quit. Otherwise confirm if a buffer
 * has been changed and not written out. Normally bound to "C-X C-C".
 */
quit(f, n)
{
        register int    s;

        if (f != FALSE                          /* Argument forces it.  */
        || anycb() == FALSE                     /* All buffers clean.   */
        || (s=mlyesno("Quit")) == TRUE) {       /* User says it's OK.   */
                vttidy();
                exit(GOOD);
        }
}

/*
 * Begin a keyboard macro.
 * Error if not at the top level in keyboard processing. Set up variables and
 * return.
 */
ctlxlp(f, n)
int f,n;
{
        if (kbdmip!=NULL || kbdmop!=NULL) {
                mlwrite("Not now");
                return(FALSE);
        }
        mlwrite("[Start macro]");
        kbdmip = &kbdm[0];
        return(TRUE);
}

/*
 * End keyboard macro. Check for the same limit conditions as the above
 * routine. Set up the variables and return to the caller.
 */
ctlxrp(f, n)
int f,n;
{
        if (kbdmip == NULL) {
                mlwrite("Not now");
                return(FALSE);
        }
        mlwrite("[End macro]");
        kbdmip = NULL;
        return(TRUE);
}

/*
 * Execute a macro.
 * The command argument is the number of times to loop. Quit as soon as a
 * command gets an error. Return TRUE if all ok, else FALSE.
 */
ctlxe(f, n)
int f,n;
{
        register int    c;
        register int    af;
        register int    an;
        register int    s;

        if (kbdmip!=NULL || kbdmop!=NULL) {
                mlwrite("Not now");
                return(FALSE);
        }
        if (n <= 0) 
                return(FALSE);
        do {
                kbdmop = &kbdm[0];
                do {
                        af = FALSE;
                        an = 1;
                        if ((c = *kbdmop++) == (CTRL|'U')) {
                                af = TRUE;
                                an = *kbdmop++;
                                c  = *kbdmop++;
                        }
                        s = TRUE;
                } while (c!=(CTLX|')')&&(s=execute(c, af, an))==TRUE);
                kbdmop = NULL;
        } while (s==TRUE && --n);
        return(s);
}

/*
 * Abort.
 * Beep the beeper. Kill off any keyboard macro, etc., that is in progress.
 * Sometimes called as a routine, to do general aborting of stuff.
 */
ctrlg(f, n)
{
        (*term.t_beep)();
        if (kbdmip != NULL) {
                kbdm[0] = (CTLX|')');
                kbdmip  = NULL;
        }
        return(TRUE);
}


