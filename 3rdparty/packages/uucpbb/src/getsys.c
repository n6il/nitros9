/*  getsys.c   This routine gets the default remote system name.
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

EXTERN QQ unsigned myuid;


int getsys (sysname)
char *sysname;
{
     char line[SYSLINE];
     FILE *file;
     register char *p;
     char *systems = SYSTEMS;

     /* we already have a system name */
     if (*sysname != '\0')
          return(0);

     /* get the first system in the Systems file as the default */
     p = line;
     asetuid (0);

     if ((file = fopen (systems, "r")) == NULL)
       {
          sprintf (p, "getsys() can't open '%s'", systems);
          asetuid (myuid);
          fatal (p);
       }

     asetuid (myuid);

     /* ignore comment lines starting with '#', <space>, <tab> or CR */
     while (mfgets (p, SYSLINE, file) != NULL)
          if (ISCOMMENT (*p) == TRUE)
               break;

     fclose (file);

     /* get first remote in Systems */
     if ((p = strrchr (p, ' ')) != NULL)
       {
          *p = '\0';
          strcpy (sysname, line);
       }
}
