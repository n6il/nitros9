/*  getval.c   These routines to extract information from mail/news headers.
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
#include <ctype.h>

#define BUFFSIZE    256

static char vtemp[BUFFSIZE];

#ifndef _OSK
char *memset();
#endif

char *cutspace();


/* getval  --parse mail/news header line and return value */

char *getval (line)
char *line;
{
     register char *p;

     memset (vtemp, '\0', sizeof (vtemp));

     /* Return value between <> if we find them */
     if ((p = strchr (line, '<')) != NULL)
       {
          strncpy (vtemp, &p[1], BUFFSIZE);

          /* be sure string is NULL-terminated */
          vtemp[BUFFSIZE - 1] = '\0';

          if ((p = strchr (vtemp, '>')) != NULL)
               *p = '\0';
       }

     /* Otherwise, return the string following the colon */
     else
       {
          p = strchr (line, ':');
          p++;
          p = skipspace (p);
          strncpy (vtemp, p, BUFFSIZE);
          p = vtemp;

          /* be sure string is NULL-terminated */
          vtemp[BUFFSIZE - 1] = '\0';

          while (*p  && !isspace (*p))
               p++;

          *p = '\0';
       }

     return (vtemp);
}



/* getrealname  --get real name from mail/news header */

char *getrealname (line)
char *line;
{
     register char *p;

     memset (vtemp, '\0', sizeof (vtemp));

     /* From: real name here <EMail address> */
     if (strchr (line, '<') != NULL)
       {
          p = strchr (line, ':');
          p++;
          p = skipspace (p);

          if (*p == '\"')
               p++;

          strncpy (vtemp, p, BUFFSIZE);

          /* be sure string is NULL-terminated */
          vtemp[BUFFSIZE - 1] = '\0';

          p = strchr (vtemp, '<');
          --p;

          while (isspace (*p)  &&  p >= vtemp)
               p--;

          if (*p == '\"')
               p--;

          *(p+1) = '\0';
       }

     /* From: EMail_address (real name here) */
     else if ((p = strchr (line, '(')) != NULL)
       {
          strncpy (vtemp, &p[1], BUFFSIZE);

          /* be sure string is NULL-terminated */
          vtemp[BUFFSIZE - 1] = '\0';

          if ((p = strchr (vtemp, ')')) != NULL)
               *p = '\0';
       }

     /* Otherwise, no real name */
     return (vtemp);
}



/* getstring  --get string following the ':' */

char *getstring (line)
char *line;
{
     register char *p;

     memset (vtemp, '\0', sizeof (vtemp));

     if ((p = strchr (line, ':')) != NULL)
       {
          p++;
          p = skipspace (p);
          strncpy (vtemp, p, BUFFSIZE);

          /* be sure string is NULL-terminated */
          vtemp[BUFFSIZE - 1] = '\0';

          /* eliminate CR */
          if ((p = strchr (vtemp, '\n')) != NULL)
               *p = '\0';

          /* eliminate any trailing whitespace */
          p = &vtemp[strlen (vtemp) - 2];

          /* hack off any trailing whitespace */
          while (isspace (*p)  &&  p >= vtemp)
            {
               *p = '\0';
               p--;
            }
       }
     return (vtemp);
}
