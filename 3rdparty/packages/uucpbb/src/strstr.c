/* Copyright (C) 1991, 1992 Free Software Foundation, Inc.
This file is part of the GNU C Library.

The GNU C Library is free software; you can redistribute it and/or
modify it under the terms of the GNU Library General Public License as
published by the Free Software Foundation; either version 2 of the
License, or (at your option) any later version.

The GNU C Library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Library General Public License for more details.

You should have received a copy of the GNU Library General Public
License along with the GNU C Library; see the file COPYING.LIB.  If
not, write to the Free Software Foundation, Inc., 675 Mass Ave,
Cambridge, MA 02139, USA.

This file was modified by Bob Billson, March, 1994 for the OS-9 UUCP package
UUCPbb. */

#ifndef _UCC                              /* Ultra C already has strstr() */
#include "uucp.h"

/* Return the first ocurrence of NEEDLE in HAYSTACK.  */

char *strstr (haystack, needle)
char *haystack, *needle;
{
     register char *begin;
     char *end_needle = strend (needle);
     char *end_haystack = strend (haystack);
     int len_needle = end_needle - needle;
     int last_needle = len_needle - 1;

     if (len_needle == 0)
          return ((char *) end_haystack);

     if ((end_haystack - haystack) < len_needle)
          return (NULL);

     for (begin = &haystack[last_needle];  begin < end_haystack;  ++begin)
       {
          char *n = &needle[last_needle];
          char *h = begin;

          do
               if (*h != *n)
                    goto loop;
          while (--n >= needle  &&  --h >= haystack);

          return ((char *) h);
loop:     ;
       }
     return (NULL);
}
#endif
