/*  findline.c   This routine tries to match indexed line in a passed file.
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

/* Find occurrence of a line in passed file.  'index' points to the first,
   second, etc. occurance of 'key', the desired match.  TRUE is returned
   on successful match.  The match line is put in the buffer pointed to by
   line.  FALSE is returned if no match and buffer contents are undefined.
   Lines starting with a #, <space>, <tab> or <cr> character are considered
   comment lines and ignored. */

#include "uucp.h"

int findline (kindex, key, filename, line, length)
int kindex, length;
char *key, *filename, *line;
{
     char *p1, srchkey[80];
     register char *p;
     FILE *file;
     int result = FALSE;

     if ((file = fopen (filename, "r")) == NULL)
       {
          printf ("findline: no file: %s\n", filename);         /* DEBUG */
          return (FALSE);
       }

     strcpy (srchkey, key);
     p = line;
     while (mfgets (p, length, file) != NULL)
          if (ISCOMMENT (*p) == FALSE)
            {
               if ((p1 = strchr (p, ' ')) != NULL)
                    *p1 = '\0';

               if (strcmp (p, srchkey) == 0)
                    if (kindex-- == 0)
                      {
                         if (p1 != NULL)
                              *p1 = ' ';

                         result = TRUE;
                         break;
                      }
            }
     fclose (file);
     return (result);
}
