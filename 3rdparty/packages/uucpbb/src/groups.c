/* groups.c  - do some functions that deal with the active file.
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
#include "rnews.h"
#include "mbuf.h"
#include <modes.h>

static int gfd = -1;
static FILE *gfp = NULL;
extern int debuglvl;
struct mbuf *mwrite();
void putgroups();

/* Set a sleep, if the active file isn't accessable */

#define ZZZZZZZ 7

struct mbuf *getgroups()
{
     char lbuf[512], line[BUFSIZ];
     struct groups g;
     struct mbuf *mh = NULL, *mp = NULL;
     char *p, *minp, *maxp;
     int zcnt = 0; 
     flag hasjunk = FALSE;

     /* Ok, try to open the active file, non-shareable */
     for (;;)
          if ((gfd = open (NGROUPS,S_IREAD|S_IWRITE|S_ISHARE)) < 0)
            {
               /* If this file is busy, then sleep for a bit and try again. 
                  Something could be done with zcnt sometime */

               if (errno == E_SHARE)
                 {
                    if (zcnt == 0)
                      {
                         sprintf (lbuf,
                                  "'%s' is busy.  I'll try again in a bit.",
                                  NGROUPS);
                         log (lbuf);
                      }

                    zcnt++;
                    sleep (ZZZZZZZ);
                    continue;
                 }
               else
                 {
                    sprintf (lbuf, "Can't open '%s', because '%d'",
                                   NGROUPS, errno);
                    log (lbuf);
                    exit (errno);
                 }
            }
          else
               break;

     /* Ok, we actually opened the active file, make a FILE pointer for it */
     if ((gfp = fdopen (gfd, "r+")) == NULL)
       {
          sprintf (lbuf, "can't fdopen %s", NGROUPS);
          log (lbuf);
          exit (1);
       }

     /* Read one line at a time, eating blank lines */
     while (fgets (line, BUFSIZ-1, gfp) != NULL)
       {
          if (*line == '\n')
               continue;

          for (p = line;  *p != ' ';  p++);
               *p = '\0';

          minp = p + 1;

          for (p++;  *p != ' ';  p++);
               *p = '\0';

          maxp = p + 1;
          g.name = (char *) malloc (strlen (line) + 1);
          strcpy (g.name, line);
          g.min = (unsigned) atoi (minp);
          g.max = (unsigned) atoi (maxp);
          g.artfd = NULL;
          mp = mwrite (mp, &mh, (char *) &g, sizeof (struct groups));

          /* No site should be without a junk group.  Note if this one has
             one */

          if (strncmp (((struct groups *)mp->cbuf)->name, "junk", 4) == 0)
               hasjunk = TRUE;

          if (debuglvl > 3)
           {
               sprintf (lbuf, "Newsgroup: %s, min: %d, max: %d",
                              ((struct groups *)mp->cbuf)->name,
                              ((struct groups *)mp->cbuf)->min,
                              ((struct groups *)mp->cbuf)->max);
               log (lbuf);
            }
       }

     /* Nope, no junk group.  Make one. */
     if (hasjunk == FALSE)
       {
          g.name = (char *) malloc(5);
          strcpy (g.name, "junk");
          g.min = 1;
          g.max = 0;
          g.artfd = NULL;
          mp = mwrite (mp, &mh, (char *) &g, sizeof (struct groups));
       }

     /* Leave the file open, which should keep it locked down until later */
     return (mh);
}



/* put the active file back */

void putgroups(gh)
struct mbuf *gh;
{
     char lbuf[512];
     struct mbuf *mp;

     /* Complain, and don't do anything, if the file isn't open */

     if (gfp == NULL)
       {
          log ("Active file doesn't appear open");
          return;
       }

     /* rewind the active file and write it all out */
     rewind (gfp);

     /* loop and write out the group entries */
     for (mp = gh;  mp != NULL;  mp = mp->mbuf_next)
       {
          fprintf (gfp, "%s %d %d\n",
                        ((struct groups *)mp->cbuf)->name,
                        ((struct groups *)mp->cbuf)->min,
                        ((struct groups *)mp->cbuf)->max);

          if (debuglvl > 3)
            {
               sprintf (lbuf, "ACTIVE OUT: %s %d %d",
                              ((struct groups *)mp->cbuf)->name,
                              ((struct groups *)mp->cbuf)->min,
                              ((struct groups *)mp->cbuf)->max);
               log (lbuf);
            }
       }

     /* Ok, close everything up, this should unlock the active file */
     fclose (gfp);
     close (gfd);
     gfp = NULL;
     gfd = -1;
}
