/*  finddev.c   This routine matches a device with one in the Devices file.
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

/* Lines beginning with a #, <space>, <tab> or <cr> character are considered
   comment lines and ignored. */

#include "uucp.h"

#define WORDSIZE  20


int finddev (key1, key2, filename, line, length)
char *key1, *key2, *filename, line[];
int length;
{
     register char *p;
     FILE *file;
     char *words[WORDSIZE];
     int result = FALSE;

     if ((file = fopen (filename, "r")) == NULL)
       {
          printf ("finddev(): can't open: %s\n", filename);    /* DEBUG */
          return (result);
       }

     p = line;
     while (mfgets (p, length, file) != NULL)
          if (ISCOMMENT (*p) == FALSE)
               if ((getargs (words, p, WORDSIZE) == 5)
                    && (strcmp (*words, key1) == 0)
                    && (strcmp (*(words+3), key2) == 0))
                 {
                    result = TRUE;
                    break;
                 }
     fclose (file);
     return (result);
}
