/*  findwork.c    Routine to find and process outgoing uucp traffic.
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
#include "uucico.h"
#include <modes.h>
#ifndef _OSK
#include "dir_6809.h"
#else
#include <dir.h>
#endif


/* This function checks to see if there is any work to do.  Used by slave()
   -- BAS */

int anywork()
{
     DIR *dp;
     register struct direct *dirbuf;            /* defined in dir.h */
     flag worktodo = FALSE;

     if ((dp = opendir (".")) == NULL)
       {
          logerror ("anywork: not enough memory to read directory");
          longjmp (env, FATAL);
       }

     while ((dirbuf = readdir (dp)) != NULL)
          if (strnucmp (dirbuf->d_name, "C.", 2) == 0)
            {
               worktodo = TRUE;
               break;
            }
     closedir (dp);
     return ((int)worktodo);
}



/* findwork() should ONLY be executed when the role is MASTER -- BAS */

void findwork()
{
     void dowork();
     DIR *dp;                                  /* defined in dir.h */
     register struct direct *dirbuf;           /*                  */

     /* Open spool directory; exit on error.  Our current data directory
        should already be the correct spool directory for this remote. */

     if (role == SLAVE)
     {
       if (debuglvl > 1)
            fputs ("findwork: Why is the SLAVE here?\n", log);

       return;
     }

     if ((dp = opendir (".")) == NULL)
       {
          logerror ("findwork: can't read entire directory--too much work to do");
          /* fatal error, abort back to uucico() */
          longjmp (env, FATAL);
       }

     /* scan the directory */
     while ((dirbuf = readdir (dp)) != NULL)
          if (dirbuf->d_name[0] != '.')
               if (strnucmp (dirbuf->d_name, "C.", 2) == 0)
                    dowork (dirbuf->d_name);
     closedir (dp);
}



/* dowork  --do work for one C. file (while in master mode) */

void dowork (cfile)
char *cfile;
{
     char line[100];
     FILE *file;
     register char *p;
     flag workdone, killC = TRUE;                      /* assume we succeed */

     if ((file = fopen (cfile, "r")) == NULL)                 /* DEBUG */
       {
          fprintf (log, "DEBUG--dowork: can't open C. file '%s'\n", cfile);
          return;
       }

     p = line;
     while (mfgets (p, sizeof (line), file) != NULL)
       {
          switch (*p)
            {
               case 'S':
                    workdone = msendfile (p);
                    break;

               case 'R':
                    workdone = mrecvfile (p);
                    break;

               default:
                    workdone = TRUE;
                    break;
            }

          if (!workdone)
               killC = FALSE;
       }
     fclose (file);

     /* get rid of C. file only if everything went okay */
     if (killC)
         if (unlink (cfile) == ERROR)
           {
              char tmp[65];

              sprintf (tmp,
                       "dowork: can't unlink %s ...error %d\n", cfile, errno);
              logerror (tmp);
           }
}



/* slavework  --do queued work from remote system */

int slavework (cline)
char *cline;
{
     char command[120];

     strcpy (command, cline);

     switch (*cline)
       {
          case 'R':
               srecvfile (command);
               break;

          case 'S':
               ssendfile (command);
               break;

          default:
               break;
       }
}
