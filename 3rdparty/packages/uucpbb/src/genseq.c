/*  genseq.c   Routine to create a unique ID for UUCP spool files.
    Copyright (C) 1990, 1993  Rick Adams and Bob Billson

    This file is part of the OS-9 UUCP package, UUCPbb.

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

    The author of UUCPbb, Bob Billson, can be contacted at:
    bob@kc2wz.bubble.org  or  uunet!kc2wz!bob  or  by snail mail:
    21 Bates Way, Westfield, NJ 07090
*/

/* Generate a unique sequence id for spool files.  The last value used is
   stored in the file GENSEQ (defined in uucp.h).  The values run from '0000'
   to '0zzz'.  Three places gives us 46,656 unique combinations. (26 letters
   plus 10 digits. -- 36^3)  '0zzz' wraps around to '0000'.  This should be
   plenty for everyday use <grin>.  Of course, if you wish, you can change the
   value of MSB below to '0'.  This will use all four places.  You will then
   have 1,679,616 unique combinations.  To use them all in one year, you will
   need to send about 4,600 messages/day.  If you do that, you need  more than
   a CoCo!  8-)   --REB */

#include "uucp.h"
#include <modes.h>

#define MSB     1        /* leftmost place of string before wrapping around */

EXTERN QQ unsigned myuid;

static char sequence[5];


char *genseq()
{
    char seq[5], nextseq();
    FILE *sfp;
    register int i;
    flag carry;

    /* must be superuser to get at the sequence file */
    asetuid (0);

    if ((sfp = fopen (GENSEQ, "r")) == NULL)
         strcpy  (seq, "0000");
    else
      {
         if ((fgets (seq, sizeof (seq), sfp) == NULL) || seq[0] == '\0')
              /* file exists but empty?  Start sequence over again */
                   strcpy (seq, "0000");

         fclose (sfp);

         /* Create next sequence id.  As long as we have a carry, keep moving
            one place to the left, up to place define by MSB.  */

         for (i = 3, carry = TRUE;   carry  &&  i >= MSB;   --i)
              seq[i] = nextseq (seq[i], &carry);
      }

    if ((sfp = fopen (GENSEQ, "w")) == NULL)
         fatal ("genseq() can't open spool sequence file for writing");

    strcpy (sequence, seq);
    fprintf (sfp, "%s", seq);

    /* protect the sequence file from prying eyes/hands */
    fixperms (sfp);

    fclose (sfp);
    asetuid (myuid);
    return (sequence);
}



/* Get the next value in the sequence which runs from 0 - 9 and a - z.  Skip
   any non-letters/numbers.  If the value is > 'Z', we wrap around to '0' and
   bump the next left place up one on our next pass.  */

char nextseq (place_val, carry)
char place_val;
flag *carry;
{
    ++place_val;

    if (place_val > 'z')
      {
         place_val = '0';
         *carry = TRUE; 
      }
    else
      {
         if (place_val == ':')  
              place_val = 'a';

         *carry = FALSE;
      }
    return (place_val);
}
