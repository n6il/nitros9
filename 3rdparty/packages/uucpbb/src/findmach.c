/*  findmach.c   This routine gets the information for a specific remote.
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

#define WORDSIZE  30

/* Keep track of whether or not we've actually dialed */
static flag found_one = FALSE;


int findmach (entryline)
int *entryline;
{
     char line[SYSLINE];
     register char *words[WORDSIZE];
     short i, n;

     if (debuglvl > 0)
          fprintf (log, "findmach: checking Systems for %s...", sysname);

     do
       {
          /* find system entry */
          if (findline (*entryline, sysname, SYSTEMS, line, sizeof (line))
                        == FALSE)
            {
               if (*entryline == 0)
                 {
                    char tmp[45];

                    if (debuglvl == 0)
                      {
                         sprintf (tmp, "'%s' not in Systems file", sysname);
                         logerror (tmp);
                         return (FATAL);
                      }
                    else
                         fputs ("NOT FOUND\n", log);

                    return (ABORT);
                 }
               else if (found_one)
                 {
                    if (debuglvl > 0)
                         fputs ("no other entry\n", log);

                    return (NOANSWER);
                 }
               else
                 {
                    char tmp[45];

                    fprintf (log, "Wrong time to call (%s)", sysname);
                    logerror (tmp);
                    return (ABORT);
                 }
            }

          if ((n = getargs (words, line, WORDSIZE)) < 5)
            {
               char tmp[65];

               sprintf (tmp, "bad Systems entry for: %s", sysname);
               logerror (tmp);
               return (ABORT);
            }
          (*entryline)++;               /* set up index for next entry */
       }
     while (!chksched (*(words+1)));    /* check schedule to make sure we */
                                        /* can use this entry now */
     found_one = TRUE;

     if (debuglvl > 0)
          fprintf (log, "got it\n");

     /* retrieve baud rate and phone number */
     strcpy (baud, *(words+3));
     strcpy (phone, *(words+4));

     if (strucmp (phone, "none") == 0)
          strcpy (phone, "-");

     /* retrieve chat script for system */
     for (*chatscript = '\0', i = 5;  i < n;  i++)
       {
          strcat (chatscript, words[i][0] != '\0' ? *(words+i) : "|");

          if (i != (n - 1))
               strcat (chatscript, " ");
       }

     /* Look in the Devices file for a matching "device" entry.  This
        "device" does not have to be an actual OS-9 device name (/t2, /t3,
        etc.).  It is merely a unique label to identify the entry in the
        Devices file. */

     if (findent (*(words+2), DEVICES, line, sizeof (line)) == FALSE)
       {
          char tmp[65];

          sprintf (tmp, "entry not in Devices: %s", *(words+2));
          logerror (tmp);
          return (ABORT);
       }

     if ((n = getargs (words, line, WORDSIZE)) != 5)
       {
          char tmp[65];

          sprintf (tmp, "bad Devices entry: %s", *words);
          logerror (tmp);
          return (ABORT);
       }

     /* Retrieve the actual OS-9 device we will use, e.g. /t2, /t3, etc. */
     strcpy (device, *(words+1));

     /* Find the entry in the Dialers file */
     if (findent (*(words+4), DIALERS, line, sizeof (line)) == FALSE)
       {
          char tmp[65];

          sprintf (tmp, "device not in Dialers: %s", *(words+4));
          logerror (tmp);
          return (ABORT); 
       }

     if ((n = getargs (words, line, WORDSIZE)) < 2)
       {
          char tmp[65];

          sprintf (tmp, "bad Dialers entry: %s", *words);
          logerror (tmp);
          return (ABORT);
       }

     /* get modem reset string */
     strcat (strcpy (modemreset, *(words+2)), "\n");

     /* retrieve dial script */
     for (*dialscript = '\0', i = 1;  i < n;  i++)
       {
          if (words[i][0] == '-'  ||  words[i][0] == '\0')
               strcat (dialscript, "|");
          else
               strcat (dialscript, *(words+i));
 
          if (i != (n - 1))
               strcat (dialscript, " ");
       }

     return (OPENPORT);
}
