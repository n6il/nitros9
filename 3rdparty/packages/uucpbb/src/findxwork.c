/*  findxwork.c    These routine find and process incoming work for remote.
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
#ifndef _OSK
#include "dir_6809.h"
#else
#include <dir.h>
#endif

#define WORDSIZE  10

EXTERN QQ FILE *log;
EXTERN QQ flag debuglvl, didwork, quiet, logopen;
EXTERN char sender[], sysname[];


int findxwork()
{
     DIR *dp;                                      /* defined in dir.h */
     register struct direct *dirbuf;               /*                  */

     /* We should already be in the system's spool directory on entry */

     /* open the system's spool directory */
     if ((dp = opendir (".")) == NULL)
          fatal ("findxwork: can't malloc() or open spool directory");

     /* scan the directory looking for work */
     while ((dirbuf = readdir (dp)) != NULL)
          if (dirbuf->d_name[0] != '.')
               if (strnucmp (dirbuf->d_name, "X.", 2) == 0)
                    doxwork (dirbuf->d_name);
     closedir (dp);
}



int doxwork (xfile)
char *xfile;
{
     char line[200], filenm[16], cmd[200], remoteuser[20], remotenode[20];
     register char *words[WORDSIZE];
     FILE *file;
     int an_error;

     /* If we can't open the execution file, log the error and go try
        another. */

     if ((file = fopen (xfile, "r")) == NULL)
       {
          fprintf (log, "%s %s - uuxqt: can't open control file '%s'\n",
                        sender, gtime(), xfile);
          return (0);
       }

     while (getline (file, line) != -1)
       {
          getargs (words, line, WORDSIZE);
          switch (words[0][0])
            {
               /* U remoteuser remotenode */
               case 'U':
                    strcpy (remoteuser, *(words+1));
                    strcpy (remotenode, *(words+2));
                    break;

               /* F datafile */
               case 'F':
                    strcpy (filenm, *(words+1));
                    break;

               /* C command localuser */
               case 'C':
                    if (strcmp (*(words+1), "rmail") == 0)
                         sprintf (cmd, "rmail %s %s", filenm, words[2]);
                    else if (strcmp (*(words+1), "rnews") == 0)
                      {
                         if (debuglvl > 0)
                              sprintf (cmd, "rnews -x%d %s",
                                            debuglvl, filenm);
                         else
                              sprintf (cmd, "rnews %s", filenm);
                      }

                    fprintf (log, "%s %s %s %s\n",
                                  sender, remotenode, gtime(), cmd);

                    /* close log file so rmail/rnews can use it */
                    if (logopen)
                      {
                         fclose (log);
                         logopen = FALSE;
                      }

                    /* delete D. file if rmail/rnews exited */
                    an_error = docmd_na (cmd);

                    if (an_error == 0)
                         unlink (filenm);

                    /* reopen log file */
                    openlog();

               default:
                    break;
            }
       }
     fclose (file);

     /* delete X. file if all is okay */
     if (an_error == 0)
       {
          unlink (xfile);
          didwork = TRUE;
       }
}
