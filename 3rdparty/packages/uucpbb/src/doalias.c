/*  doalias.c    Routine to substitute an alias with the actual mail address.
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

/* Search aliases (.aliases under OSK) file in the user's home directory
   alias.  Any line starting with #, * or CR  is are considered comment lines
   and ignored.  Returns TRUE if an alias was found and put in 'address'.
   FALSE if no alias was found.  'address' remains unchanged.

   An entry may be in the form:
      <alias> <address>
   or
      <alias> <username> <address>

   <username> may be either quoted as in:

      "Rick Adams"

   or separate as in:

      Rick Adams

   Any number of spaces can separate the fields.  Right now the <username>
   field is ignored.  This is for compatibility with Jeff Shepler's Palm. */


#include "uucp.h"

#define WORDSIZE   30

EXTERN QQ int debug;


int doalias (address)
char address[];
{
     static char aliasfile[128];
     static int firstpass = TRUE;
     char line[SYSLINE];
     register char *p;
     char *words[WORDSIZE], *aptr;
     FILE *file;
     int foundalias, n;

     foundalias = FALSE;
     p = line;

     if (firstpass)
       {
#ifdef _OSK
          sprintf (aliasfile, "%s/.aliases", homedir);
#else
          sprintf (aliasfile, "%s/%s/aliases", homedir, uudir);
#endif
          firstpass = FALSE;
       }

     if ((file = fopen (aliasfile, "r")) != NULL)
       {
          while (mfgets (p, sizeof (line), file) != NULL)
            {
               if (ISCOMMENT (*p) ||  *p == '*')
                    continue;

               n = getargs (words, p, WORDSIZE);
               aptr = n > 2 ? *(words + (n - 1)) : *(words + 1);

               if (debug >= 3)
                    printf ("doalias: alias= %s  new adrs= %s\n",
                                *words, aptr);

               if (strucmp (address, *words) == 0)
                 {
                    if (debug >= 3)
                         printf ("doalias: substituting '%s' for '%s'\n",
                                     aptr, *words);

                    strcpy (address, aptr);
                    foundalias = TRUE;
                    break;
                 }
            }
          fclose (file);
       }

     if (debug >= 3)
          printf ("doalias: address = '%s'\n", address);

     return (foundalias);
}
