/*  findent.c   This routine tries to match a line in the passed file.
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
 
/* Find the first occurrence of a line in the passed file which matches 'key'.
   TRUE is returned on success.  The matched line is put in the buffer pointed
   by *line.  FALSE is returned if there is no match and the buffer contents
   are undefined.  Lines beginning with a #, <space>, <tab> or <cr> character
   are considered comment lines and ignored. */

#include "uucp.h"


int findent (key, filename, line, length)
char *key, *filename, *line;
int length;
{
     char *p1, srchkey[80];
     register char *p;
     FILE *file;
     int result = FALSE;

     if ((file = fopen (filename, "r")) == NULL)
       {
          printf ("findent: no file: %s\n", filename);          /* DEBUG */
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
