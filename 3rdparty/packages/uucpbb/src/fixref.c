/*  fixref.c  -- Remove tabs from Reference: line news article.
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

/* Riped out of the original rnews.c */

int fixref (line)
char *line;
{
     register char *p;
     char *tptr, lastchar = '\0';

     p = tptr = line;
     while (*p)
       {
          switch (*p)
            {
               case '\t':                  /* tab */
                    if (lastchar != ' ')
                      {
                         *tptr = lastchar = ' ';
                         ++tptr;
                      }
                    break;

               default:                   /* anything else */
                    *tptr = lastchar = *p;
                    ++tptr;
                    break;
            }
          ++p;
       }
     *tptr = '\0';
}
