/*  closeuucp.c     Close uucp connection
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

#include "uucp.h"
#include "uucico.h"

static char *o6 = "OOOOOO",
            *o7 = "OOOOOOO",
            *o_o = "sending \"over and out\" to remote",
            *no_oo = "timed out waiting for \"over and out\", closed anyway",
            *got_oo = "got remote's \"over and out\"";


/* As the master, we send six O's and expect seven.  We send them twice to
   help the remote.  We ignore any errors. */

int mcloseuucp()
{
     char string[80];
     register int i;

     if (debuglvl > 0)
          fprintf (log, "mcloseuucp: %s\n", o_o);

     if (send0 (o6)  &&  send0 (o6))
       {
          /* Look for remote's hangup string.  We want to make sure our
             modem sent our string.  This is only necessary because some
             versions of UUCP complain if they don't get the hangup string.
             The remote should send us seven O's, but some versions of
             UUCP only send 6.  We look for the string several times because
             some versions supposedly send garbage after the last packet but
             before the hangup string. */

          for (i = 0; i < 25; ++i)
            {
               if (recv0 (string) == TIMEDOUT)
                 {
                    if (debuglvl > 0)
                         fprintf (log, "mcloseuucp: %s\n", no_oo);

                    break;
                 }

               if (strstr (string, o6) != NULL)
                 {
                    if (debuglvl > 0)
                         fprintf (log, "mcloseuucp: %s\n", got_oo);

                    break;
                 }
            }
       }
     normal_end = TRUE;
     return (ABORT);
}



/* As the slave, we send seven O' and expect six.  Send them twice to help the
   other side.  We ignore any errors. */

int scloseuucp()
{
     char string[80];
     register int i;

     if (debuglvl > 0)
          fprintf (log, "scloseuucp: %s\n", o_o);

     if (send0 (o7)  &&  send0 (o7))
       {
          /* Look for remote's hangup string.  We want to make sure our
             modem sent our string.  This is only necessary because some
             version of UUCP complain if they don't get the hangup string.
             We look for the string several times because some versions
             supposedly send garbage after the last packet but before
             the hangup string. */

          for (i = 0; i < 25; ++i)
            {
               if (recv0 (string) == TIMEDOUT)
                 {
                    if (debuglvl > 0)
                         fprintf (log, "scloseuucp: %s\n", no_oo);

                    break;
                 }

               if (strstr (string, o6) != NULL)
                 {
                    if (debuglvl > 0)
                         fprintf (log, "scloseuucp: %s\n", got_oo);

                    break;
                 }
            }
       }
     normal_end = TRUE;
     return (ABORT);
}
