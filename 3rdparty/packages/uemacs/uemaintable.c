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
 *
 * 3.0  Bob Santy, 28-Dec-85
 *      -  Ported to OS9 Level I
 */
/* #include        <stdio.h> */
#include        "ueed.h"
#ifdef VMS
#include        <ssdef.h>
#define GOOD    (SS$_NORMAL)
#endif

#ifndef GOOD
#define GOOD    0
#endif

#define MAINTABLE 1
#include "uemain.h"

