/*  makepath.c   Routines to create directories to reach passed pathname.
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
#include <modes.h>

#define WORDSIZE  20

EXTERN QQ unsigned myuid;


int makepath (path)
char *path;
{
     char filepath[200], *words[WORDSIZE];
     char *p, delim;
     register int i;
     int n;

     /* newsgroup path or uucp path? */
     delim = (strchr (path, '/') == NULL)  ?  '.'  :  '/';

     /* parse out the components of path */
     strcpy (filepath, path);

     for (p = filepath; *p != '\0'; p++)
          if (*p == delim)
               *p = ' ';

     n = getargs (words, filepath, WORDSIZE);

     /* if uucp path, last component is not directory */
     if (delim == '/')
          n--;

     /* Create intermediate directories.  Make directory names uppercase. */
     asetuid (0);
     for (i = 0; i < n; i++)
          if (chdir (*(words + i)) != 0)
            {
               mknod (strupr (*(words + i)), S_IREAD|S_IWRITE|S_IOREAD);
               chdir (*(words + i));
            }
     asetuid (myuid);
}



/* Fix names with - or + in them since OS-9 does not normally support these as
   directory names. */

char *fixgroupname (groupname)
char *groupname;
{
     register char *ptr;
     char *gp, *gptr;
     int plus = 0;

     ptr = groupname;

     while (*ptr)
          if (*ptr++ == '+')
               ++plus;

     gp = (char *) malloc ((strlen (groupname)+plus+1) * sizeof (char *));

     if (gp == NULL)
       {
          fputs ("fixgroupname(): can't make copy of newsgroup name", stderr);
          return ((char *) NULL);
       }

     ptr = groupname;
     gptr = gp;

     while (*ptr)
       {
          if (*ptr == '+')                 /* replace + with __ */
            {
               *gptr++ = '_';
               *gptr++ = '_';
            }
#ifndef _OSK
#  ifndef DASHOK
          else if (*ptr == '-')            /* replace - with _ */
               *gptr++ = '_';
#  endif
#endif
          else
               *gptr++ = *ptr;

          *gptr = '\0';
          ++ptr;
       }
     return (gp);
}
