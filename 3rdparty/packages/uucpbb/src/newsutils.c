/*  newsutils.c    Routines used manipulate the newsgroup active file.
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
#include <signal.h>

#define NAP  5                      /* seconds to sleep if active file busy */

EXTERN QQ int ngroups;
EXTERN QQ int debuglvl;
EXTERN struct active groups[];
EXTERN QQ FILE *log;
EXTERN char sender[];

static int activepath;                 /* only accessible within this file */


/* init in-core newsgroups list from active file */

int readactive (mode, showmsg)
int mode, showmsg;
{
     register char *words[3];
     FILE *file;
     char c, *p, buff[128];
     char *cantopen = "readactive: cannot open active file";

     int firstpass = TRUE;

     /* open the active file in non-sharable mode, read-write.

        if active file was already opened by some other user, such as rnews,
        wait until it is closed or user the decides to cancel sending the
        article.  Between waits take a brief nap. */

     for (;;)
          if ((activepath = open (NGROUPS, mode)) != ERROR)
               break;
          else
               if (errno == 253)
                 {
                    if (showmsg)
                      {
                         if (firstpass)
                           {
                              fputs ("\nrnews: active file in use...wait or hit 'c' to cancel...",
                                     stdout);

                              fflush (stdout);
                              firstpass = FALSE;
                           }

                         if (timeout (1) != TIMEDOUT)
                           {
                               read (0, &c, 1);

                               if (tolower (c) == 'c')
                                 {
                                    putchar ('\n');
                                    return (FALSE);
                                 }
                           }
                      }
                    sleep (NAP);                   /* take a short snooze */
                 }
               else
                 {
                    logerror (cantopen);
                    return (FALSE);
                 }

     /* now turn the path # into a file descriptor for read */
     ngroups = 0;

     if ((file = fdopen (activepath, "r")) == NULL)
       {
          logerror (cantopen);
          return (FALSE);
       }

     /* Read in the newsgroup name, lowest and highest message number in
        the group. */

     p = buff;
     while (mfgets (p, sizeof (buff), file) != NULL)
       {
          int linecount = 0;

          ++linecount;

          if (ISCOMMENT (*p) == TRUE)
               continue;

          if (getargs (words, buff, 3) != 3)
            {
               char tmp[40];

               sprintf (tmp, "readactive: error in active file, line: %d",
                             linecount);
               logerror (tmp);
               return (FALSE);
            }

          /* Newsgroup name */
          strcpy (groups[ngroups].newsgroup, *words);

          /* Lowest msg in group */
          groups[ngroups].index = atoi (words[1]);

          /* Highest msg in group */
          groups[ngroups].seq = atoi (words[2]);

          if (groups[ngroups].index <= 1)
               groups[ngroups].index = 1;

          if (debuglvl > 0)
               fprintf (log, "%s %s Newsgroup: %s  lowest: #%d  highest: #%d\n",
                             sender, gtime(), groups[ngroups].newsgroup,
                             groups[ngroups].index, groups[ngroups].seq);

          /* previously end of loop wouldn't detect when you exceeded
             MAXNEWGROUPS, fixed!  --TK  */

          if (ngroups++ == MAXNEWSGROUPS)
               break;
       }
     /* Leave file, thus, activepath open for updactive() */
     return (TRUE);
}



/* Release (unlock) active file if we won't update it */

int closeactive()
{
     close (activepath);
}



/* Update active file */

int updactive()
{
     FILE *file;
     register int  curgroup;

     if ((file = fdopen (activepath, "w")) == NULL)
       {
          logerror ("updactive: can't open active file for output");
          return (FALSE);
       }

     rewind (file);
     for (curgroup = 0; curgroup < ngroups; curgroup++)
          fprintf (file, "%s %d %d\n",
                         groups[curgroup].newsgroup,
                         groups[curgroup].index,
                         groups[curgroup].seq);

     /* make sure all I/O has flushed before: */
     /* chop off any junk at the end */
     fflush (file);
     _ss_size (activepath, ftell (file));

     /* closes readactive as well */
     fclose (file);
     return (TRUE);
}



/* Find the group "group" in the in-core table, return its index.  If not
   found, create if "makenew" otherwise return "-1".  */

int findgroup (group, makenew)
char *group;
int  makenew;
{
     register int curgroup;

     for (curgroup = 0; curgroup < ngroups; curgroup++)
          if (strcmp (group, groups[curgroup].newsgroup) == 0)
               break;

     /* If not found, return appropriate pointer */
     if (curgroup == ngroups)
          if (makenew)
            {
               strcpy (groups[ngroups].newsgroup, group);
               groups[ngroups].index = groups[ngroups].seq = 0;
               ngroups++;
            }
          else
               return (-1);

     return (curgroup);
}



/* Timeout will sleep for 'secs' seconds or until there's input ready
   Return:  TIMEDOUT  - if we timed out
            FALSE     - if data is waiting  */

int timeout (secs)
int secs;
{
     register int i;
     int count;

     /* if input waiting, return */
     if (_gs_rdy (1) > 0)
          return (FALSE);

     /* count *= 4 because we wake up 4 times / second */
     count = secs << 2;
     for (i = 0; i < count; i++)
       {
          if (_gs_rdy (1) > 0)
               return (FALSE);
          else
            {
               _ss_ssig (1, SIGWAKE);
               tsleep (PORTSLEEP);
               _ss_rel (1);
            }
       }
     return (TIMEDOUT);
}



static int logerror (msg)
char *msg;
{
     fprintf (log, "%s %s %s\n", sender, gtime(), msg);
}
