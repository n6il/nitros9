/* openarts.c - Open a number of articles, if possible.
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

EXTERN int debuglvl;
char *fixgroupname();


int openarts (g, gname)
struct mbuf *g;
char *gname;
{
     char lbuf[512], gpath[200];
     char *p, *ngroups, *np, *ncp;
     struct mbuf *gp;
     int havegroup = FALSE;

     /* Allocate some space for the group name stuff */
     ngroups = (char *)malloc (strlen (gname) + 2);

     if (ngroups == NULL)
          fatal ("openarts(): can't malloc copy of newsgroup name");

     sprintf (ngroups, "%s\n", gname);
     np = ngroups;

     /* Loop until we run out of given articles */
     while (*np != '\0'   &&   *np != '\l'   &&   *np != '\n')
       {
          /* Search for the terminator or separator character */
          for (ncp = np;
               *ncp != ',' &&  *ncp != '\0' &&  *ncp != '\l' &&  *ncp != '\n';
               ncp++);
            {
               *ncp = '\0';
            }

          /* Loop through the groups that are at this particular site, see if
             there is a match */

          for (gp = g;  gp != NULL; gp = gp->mbuf_next)
            {
               if (debuglvl > 4)
                 {
                    sprintf (lbuf, "Checking group '%s' and '%s'", np,
                             ((struct groups *)gp->cbuf)->name);
                    log (lbuf);
                 }

               /* Ok, this group matched */
               if (strcmp(((struct groups *)gp->cbuf)->name, np) == 0)
                 {
                    char *gname;

                    gname = NULL;
                    havegroup = TRUE;

                    if (chdir (newsdir) == ERROR)
                      {
                         sprintf (lbuf, "Can't chdir to '%s'", newsdir);
                         log (lbuf);
                         return (ABORT);
                      }

                    /* Make the directory path for this news group, if it
                       doesn't exist */

                    gname = fixgroupname (np);
                    makepath (gname);

                    if (gname != NULL)
                      {
                         free (gname);
                         gname = NULL;
                      }

                    /* Form this particular article.   We should already be in
                       the correct newsgroup's directory. */

                    ((struct groups *)gp->cbuf)->max++;
                    sprintf (gpath, "a%d", ((struct groups *)gp->cbuf)->max);

                    if (debuglvl > 3)
                      {
                         sprintf (lbuf, "Trying: '%s' in '%s'", gpath,
                                  ((struct groups *)gp->cbuf)->name);
                         log (lbuf);
                      }

                    /* Try to open the article, this should truncate any files
                       that are the same name */

                    if ((((struct groups *)gp->cbuf)->artfd
                         = fopen (gpath, "w")) == NULL)
                      {
                         sprintf (lbuf, "Couldn't open '%s', because %d",
                                  gpath, errno);
                         log (lbuf);
                      }
                    else
                      {
                         np = ncp + 1;
                         break;
                      }
                 }
            }
          np = ncp + 1;
       }

     /* Ok, this article doesn't go to any of the groups at this site */
     if (!havegroup)
       {
          if (debuglvl > 1)
            {
               log ("Article doesn't go to any news groups in active file.");
               log ("Junking it.");
            }

          for (gp = g; gp != NULL; gp = gp->mbuf_next)
            {
               if (strncmp (((struct groups *)gp->cbuf)->name, "junk" ,4) == 0)
                 {
                    np = ((struct groups *)gp->cbuf)->name;
                    if (chdir (newsdir) == ERROR)
                      {
                         sprintf (lbuf, "Can't chdir to '%s'", newsdir);
                         log (lbuf);
                         return (ABORT);
                      }
                    makepath (np);
                    ((struct groups *)gp->cbuf)->max++;
                    sprintf (gpath, "Z%d", ((struct groups *)gp->cbuf)->max);

                    for (p = gpath; *p != '\0'; p++)
                         if (*p == '.')
                              *p='/';

                    if (debuglvl > 3)
                      {
                         sprintf (lbuf, "Trying: '%s' in '%s'",
                                  gpath, ((struct groups *)gp->cbuf)->name);
                         log(lbuf);
                      }

                    if ((((struct groups *)gp->cbuf)->artfd
                           = fopen (gpath, "w")) == NULL)
                      {
                         sprintf (lbuf, "Couldn't open '%s', because %d",
                                  gpath, errno);
                         log (lbuf);
                      }
                    break;
                 }
            }

          /* This really indicates that there is a problem in the universe. 
             Every site should have a 'junk' group */

         if (gp == NULL)
              if (debuglvl > 1)
                   log ("No junk group.....");
       }
     free (ngroups);
}
