/*  strdetab.c   Function to convert tabs in string to spaces
    Copyright (C) 1993  Bob Billson

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


/* ENTRY: s        points to string to convert
          spaces   number of spaces tab char is replaced with

   EXIT: s         points to start of converted string
                   returns NULL on error

   This function assumes that the string pointed to by s on entry is large 
   enough to fit the expanded string.  No check is made for overflow.  --REB
*/

#include "uucp.h"

/* #undef this if your C library doesn't have memset() */
#define _MEMSET_


char *strdetab (s, spaces)
register char *s;
int spaces;
{
#ifndef _MEMSET_
     int i;
#endif
     char *sptr, *tptr;

     tptr = s;

     while (*s)
          if (*s == '\t')
            {
               sptr = (char *) calloc (strlen (s), sizeof (char));

               if (sptr == NULL)
                    return (NULL);

               strcpy (sptr, s+1);
#ifdef _MEMSET_
               memset (s, ' ', spaces);
               s += spaces;
#else
               for (i = 0; i < spaces; ++i)
                    *s++ = ' ';
#endif
               strcpy (s, sptr);
               free (sptr);
            }
          else
               s++;

     return (tptr);
}
