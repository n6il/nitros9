/*  getdirs.c    Routine to get pathname for specified directory.
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

/* Function to get directory name from the /dd/sys/uucp/Parameters file.  A
   pointer to a malloc()'ed string containing the name is returned.  It is the
   responsibility of the calling function to free() the memory when it is no
   longer needed.  If the Parameters file can't be read or no matching
   directory is found, a NULL is returned.  */

#include "uucp.h"

#define WORDSIZE 3

EXTERN char fname[];
EXTERN QQ unsigned myuid;


char *getdirs (directory)
char *directory;
{
     char line[100];
     register char *p;
     FILE *fp;
     char *p2, *words[WORDSIZE];
     int n, linecount, dirlen = strlen (directory);

     p = line;
     sprintf (fname, "%s/Parameters", UUCPSYS);
     asetuid (0);

     if ((fp = fopen (fname, "r")) == NULL)
       {
          sprintf (p, "getdirs: can't open %s", fname);
          asetuid (myuid);
          return (p2);
       }

     asetuid (myuid);
     p2 = (char *)NULL;
     linecount = 0;
     while (mfgets (p, sizeof (line), fp) != NULL)
       {
          ++linecount;

          if (strnucmp (directory, p, dirlen) == 0)
            {
               n = getargs (words, p, WORDSIZE);

               if (n != 3  ||  words[1][0] != '=')
                 {
                    fprintf (stderr,
                             "getdirs: bad line in Parameters at line %d\n",
                             linecount);
                 }
               else
                    p2 = strdup (words[2]);
               break;
            }
       }
     fclose (fp);
     return (p2);
}
