/*  log.c   Routines to manage the uulog file.
    Copyright (C) 1994 Brad Spencer

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

static char logpath[200], fcaller[200];
static flag  copylog = FALSE,
             to_stderr = FALSE,
             wval;


/* Initalize logpath to requested log path and others */

void inizlog (caller, where)
char *caller;
int where;
{
     if (logdir == NULL)
          if ((logdir = getenv ("LOGDIR")) != NULL)
               logdir = strdup (logdir);
          else
               logdir = LOGDIR;

     if (caller == NULL  ||  *caller == '\0')
          strcpy (fcaller, "unnamed");
     else
          strcpy (fcaller, caller);

     switch (where)
       {
          /* Someone did something silly, so log to LOGDIR/uulog */
          default:
              where = 1;
              /* Fall through */

          /* Ok, log to the disk file LOGDIR/uulog */
          case 1:
               sprintf (logpath, "%s/uulog", logdir);
               break;

          /* Ok, log to the RAMDISK and copy the contents to LOGDIR/uulog
             later */

          case 2:
               sprintf (logpath, "%s/uulog", RAMDISK);
               copylog = TRUE;
               break;

          /* Ok, log to stderr */
          case 3:
               strcpy (logpath, "stderr");
               to_stderr = TRUE;
               break;
       }
     wval = where;

     /* Ensure that something is in the uulog.  Might as well make it useful
        information */
}



/* Log will write a message to the end of the log, returning where, or -1
   Really, varargs should be used here, but I don't know if OSK or OS-9000
   has them */

int log (message)
char *message;
{
     FILE *fd;

     /* Need a message in order to log one */
     if (message == NULL  || *message == '\0')
          return (wval);

     if (to_stderr)
          fd = stderr;
     else
          if ((fd = fopen (logpath, "a")) == NULL)
            {
              fprintf (stderr, "log: Couldn't open '%s', because %d\n",
                       logpath, errno);
              return (-1);
            }

     fprintf (fd,"%s %s %s\n", fcaller, gtime(), message);

     if (!to_stderr)
          fclose (fd);

     return (wval);
}



/* deinizlog will copy the log from RAMDISK, if needed */

int deinizlog()
{
     FILE *rfd, *lfd;
     char nlog[200], bigbuf[1024], llbuf[100];
     int r;

     /* Copy the file from the RAMDRIVE to LOGDIR/uulog, if asked to */
     if (copylog)
       {
          if ((rfd = fopen (logpath, "r")) == NULL)
            {
               fprintf (stderr, "deinizlog: Can't open '%s', because %d\n",
                        logpath, errno);
               return (-1);
            }

          sprintf (nlog, "%s/uulog", logdir);

          if ((lfd = fopen (nlog, "a")) == NULL)
            {
               fprintf (stderr, "deinizlog: Can't open '%s'\n", nlog);
               return (-1);
            }

          do
            {
               if ((r = fread (bigbuf, 1, sizeof (bigbuf)-1, rfd)) < 0)
                    fputs ("deinizlog: read error\n", stderr);
               else
                    if (r != 0)
                         fwrite (bigbuf, 1, r, lfd);
            }
          while (r > 0);

          fclose (rfd);
          fclose (lfd);

          if (r == 0)
               unlink (logpath);
       }
     return (r);
}
