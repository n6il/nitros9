/* getargs.c

   This replaces the original parse.c.  It is little more compact and with
   a minor change it will parse quoted or unquoted arguments (double quotes,
   ("). If there is nothing between two sets of quotes (""), the field is
   replaced with the '\0' character and parsing continues.  This routine was
   originally posted to comp.lang.c by Steve Summit <scs@eskimo.c>.  Thanks
   to Steve for his okey dokey to use it in UUCPbb.

   Quote and OS-9 mods by Bob Billson <bob@kc2wz.bubble.org> (REB)
*/

/*
 *  takes a string (line) and builds an array of pointers to each word in it.
 *  words are separated by spaces or any control characters.  At most maxargs
 *  pointers are calculated.  \0's are inserted in line, so that each word
 *  becomes a string in its own right.  The number of pointers (argc) is
 *  returned.
 */

#ifndef ORIGINAL
#include "uucp.h"
#else
#include <stdio.h>
#endif

#ifndef ORIGINAL
#define iswhite(c) ((c)==' ' || (c)=='\t' || (c)=='\x0D' || (c)=='\x0A')
#else
#define iswhite(c) ((c)==' ' || (c)=='\t' || (c)=='\n')    /* original code */
#endif

int getargs(argv, line, maxargs)
#ifndef ORIGINAL
char *argv[];
register char *line;
#else
register char *argv[];
register char *line;
#endif
int maxargs;
{
register int nargs = 0;
int firstquote = FALSE;                                        /* added REB */

for(;;)
        {
        while(iswhite(*line))
                line++;

        if(*line == '\0')
                {
                if(nargs < maxargs) *argv = NULL;
                return(nargs);
                }
#ifndef ORIGINAL
        if (*line == '"' && !firstquote)                       /* added REB */
                {
                firstquote = TRUE;
                line++;
                }
#endif
        *argv++ = line;
        nargs++;

#ifndef ORIGINAL
        while (((!firstquote  &&  !iswhite(*line))             /* added REB */
                 || (firstquote && *line != '"'))  && *line != '\0')
#else
        while(!iswhite(*line) && *line != '\0')
#endif
                line++;

        if(*line == '\0')
                {
                if(nargs < maxargs) *argv = NULL;
                return(nargs);
                }

#ifndef ORIGINAL
        if(*line == '"')                                       /* added REB */
                firstquote = FALSE;
#endif

        *line++ = '\0';
        if(nargs == maxargs) return(nargs);
        }
}



/************************************************************
 ************************************************************
 ***  The following code is not part of getargs.c.  This  ***
 ***  code IS covered by the GNU General Public license.  ***
 ************************************************************
 ************************************************************/
 
 /*  parse.c  Routines to deal with parsing passed strings.
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

/* Returns pointer to first non-whitespace character in string pointed to by
   string.  Added  --REB */

char *skipspace (string)
char *string;
{
     register char *p;

     p = string;

     while (iswhite (*p))
          p++;

     return (p);
}



/* Parse command line parameters.  Broken out of docmd.c.  Originally, this
   was part of docmd.c.  It was split into a separate file because it is
   needed in osk.c as well.  All the modules which link osk.c do not
   necessarily link docmd.c as well.

   Modified for OSK -- BGP
*/

#ifdef _OSK
/* Parse the command passed us under OSK */

int parse_cmd (argvect, string)
char **argvect;
char *string;
{
     char *p, delimit;
     int count = -1;

     p = string;
     do
       {
          p = skipspace (p);             /* skip leading spaces */

          if (*p == '\"')
               delimit = *(p++);         /* quote is delimiter */
          else
               delimit = ' ';            /* space is delimiter */

          argvect[++count] = p;

          /* include all between */
          while (*(++p) != delimit && *p != '\0');
               if (*p == '\0')
                    --p;
               else
                    *p = '\0';
       }
     while (*(++p) != '\0');

     argvect[++count] = NULL;        /* NULL terminate last */
}

#else
/* Parse the command passed us under OS-9/6809 */

char *parse_cmd (cmd)
char *cmd;
{
     register char *p;

     /* Make sure command line end with a \n */
     if ((p = strchr (cmd, '\n')) == NULL)
          strcat (cmd, "\n");

     /* Return a pointer to the command line parameters or the \n if there are
        no parameters. */

     if ((p = strchr (cmd, ' ')) != NULL)
          *p++ = '\0';
     else
          p = cmd + strlen (cmd) - 1;

     return (p);
}
#endif
