/*  fixline.c   This routine expands tabs and removes escape characters.
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

/* Expand tabs to 8 spaces.  Removes ESC chars.  Returns a copy of the new
   line in the buffer originally passed.  Buffer must be large enough for
   expanded line.  Does not check for overflow.  Rewritten by REB. */

#include "uucp.h"
#include <ctype.h>

#define TABSIZE   8


int fixline (line)
char *line;
{
     register char *p;
     char *nptr, *strdetab();
     char newline[256];
     flag escflag = FALSE;

     nptr = newline;
     *nptr = '\0';

     if ((p = strchr (line, '\x0A')) != NULL)        /* LF -> CR */
          *p = '\n';

     p = line;

     if (strchr (p, '\t') == NULL  &&  strchr (p, '\x1b') == NULL)
          return (0);

     if (strchr (p, '\t') != NULL)                   /* zap tabs */
          p = strdetab (p, TABSIZE);

     while (*p)
          switch (*p)
            {
               case '\x1b':                          /* strip escape */
                    escflag = TRUE;
                    ++p;

                    while (*p && (isdigit (*p) || *p == '[' || *p == ';'))
                         ++p;
                    break;

               default:
                    *nptr++ = *p++;
                    *nptr = '\0';
                    break;
            }

     if (escflag)
          strcpy (line, newline);

     return (0);
}
