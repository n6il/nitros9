/*  getline.c    Read an input line until we get EOL, return char count read.
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

/* Reads a line until LF or CR is reach.  Returns number of characters read
   or -1 on EOF or error. 

   It does not currently check for overflowing of passed buffer.  It is the
   caller's responsibility to ensure the buffer is large enough for any
   expected string. */

#include <stdio.h>

int getline (file, line)
FILE *file;
char *line;
{
     int c, count = 0;
     register char *p;

     p = line;
     while ((c = getc (file)) != EOF)
       {
          *p++ = c;
          ++count;

          if (c == '\x0A' || c == '\x0D')
            {
              --p;
              break;
            }
       }

     if (count == 0)
          return (-1);

     *p = '\0';
     return (count);
}
