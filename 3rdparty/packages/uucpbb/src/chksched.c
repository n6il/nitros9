/*  chksched.c   This routine check to see if it is okay to call the remote.
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

/* Check to see if it is okay to call remote.by looking at the schedule
   (second) field of the Systems file entry.  The schedule field has two
   subfields, DAY and TIME.  The DAY and TIME subfields have no spaces between
   them.  The DAY subfield is specified using the following keywords (case is
   ingored):

       Any           -we can call at any time
       Never         -we never should never call but wait to be called
       Wk            -call any weekday (Monday-Friday)
       Su,Mo,Tu,We,  -call on individual days
       Th,Fr,Sa

   The TIME subfield is specified by two 24-hour clock times separated by
   a dash (-), e.g. 0930-1100, call only between 9:30 and 11:00 in the
   morning.  More than one schedule field can be included by separating
   them with commas.  For example:
 
       Wk1230-1545,Su,Sa  -call Monday-Friday from 12:30 to 3:45 in the
                             afternoon and any time on Saturday and Sunday.
       Any1800-2000       -call any day from 6:00 to 8:00 at night
       Any                -call any day, any time
       Th                 -call any time on Thursday
*/

#include "uucp.h"
#include "uucico.h"


int chksched (sched)
char *sched;
{
     static char *days[]={"Su","Mo","Tu","We","Th","Fr","Sa"};
     struct tm *local_time;
     register char *p; 
     char *com, *dash;
     int day, miltime, after, before;
#ifdef _OSK
     time_t t;
#else
     long t;
#endif

     time(&t);
     local_time = localtime(&t);
     day = local_time->tm_wday;
     miltime = local_time->tm_hour * 100 + local_time->tm_min;
     strcpy (temp, sched);

     for (p = com = temp; com != NULL; p = com + 1)
       {
          if ((com = strchr (p, ',')) != NULL)
               *com = '\0';

          if ((dash = strchr (p, '-')) != NULL)
               *dash = '\0';

          /* Is today OK? */
          if (strnucmp (p, "Never", 5) == 0)
               return (FALSE);

          /* 'Any' matches any day */
          if (strnucmp (p, "Any", 3) == 0)
               p += 3;

          /* Correct day of week? */
          else if (strnucmp (p, *(days + day), 2) == 0)
               p += 2;

          /* Is it a weekday? */
          else if (day > 0  &&  day < 6  &&  strnucmp (p, "Wk", 2) == 0)
               p += 2;

          /* No match, try next one */
          else
               continue;

          /* Is time OK? */

          /* No time specified, thus, it matches */
          if (*p == '\0')
               return (TRUE);

          /* Else, check military time, assume correct format */
          after = atoi (p);
          before = atoi (dash+1);

          /* 1800-2000 (not wrapping around 0000) */
          if (after <= before)
            {
               if (miltime >= after && miltime <= before)
                    return (TRUE);
            }
          /* 2310-0750 (wrapping around 0000) */
          else
            {
               if (miltime >= after || miltime <= before)
                    return (TRUE);
            }
       }

     /* No times matched, return FALSE */
     return (FALSE);
}
