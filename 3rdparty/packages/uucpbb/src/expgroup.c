/*  expgroup.c   This routine deletes a newsgroup's old articles.
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
#include <direct.h>
#include <time.h>

#define BRUTE_LIMIT  32                         /* EK */

extern QQ int expireflag, debuglvl;             /* made direct page -- REB */
extern QQ FILE *log;                            /* Added -- REB */
extern char sender[];                           /*              */
extern struct active groups[];


int expgroup (grp, limit)
struct active *grp;
int limit;                           /* how many days old the article needs */
{                                    /* be before it is expired.            */
     char filename[33];
     int age, min, mid, max;                                     /* EK */
     register int i;
     struct fildes finfo;
     struct sgtbuf date;

     /* get today's date and time */
     getime (&date);

     /* expire articles */

     /* Use brute force if less than BRUTE_LIMIT articles exist. */
     if (grp->seq - grp->index < BRUTE_LIMIT)
       {
          if (debuglvl > 3)
               fputs ("expgroup: using brute-force to expire articles\n",
                      log);

          /* expire articles -- brute force, linear search */
          for (i = grp->index;  i <= grp->seq;  i++)
            {
               /* get filename */
               sprintf (filename, "a%d", i);

               if (debuglvl > 3)
                    fprintf (log, "expgroup: checking article %s\n",
                                  filename);

               /* was the article already deleted? */
               if ((age = getage (filename, &date)) == ERROR)
                 {
                    if (debuglvl > 3)
                         fprintf (log, "expire: unable to get age of article: %s\n",
                                       filename);
                    continue;
                 }

               if (age > limit)
                 {
                    if (debuglvl > 2)
                         fprintf (log, "%s %s expiring %s\n",
                                       sender, gtime(), filename);

                    if (expireflag)
                         unlink (filename);
                    else
                         fprintf (log, "article %s/%s would have been deleted\n",
                                  grp->newsgroup, filename);
                 }
               else
                 {
                    if (!expireflag)                 /* added --REB */
                         fprintf (log, "article %s/%s too new\n",
                                  grp->newsgroup, filename);

                    break;                /* Found first non-expirable file */
                 }
            }
       }
     else
       {
          /* expire articles -- binary search */
          min = grp->index;
          max = grp->seq;

          if (debuglvl > 3)
               fputs ("expgroup: using binary search to expire articles\n",
                      log);

          while (max - min > 1)
            {
               mid = min + (max - min)/2; 
               i = 0;
               sprintf (filename, "a%d", mid);

               /* if midpoint file doesn't exist */
               while ((age = getage (filename, &date)) == ERROR
                       &&   mid - i > min)
                 {
                    if (debuglvl > 3)
                         fprintf (log, "expire: unable to get age of article: %s\n",
                                       filename);
                    ++i;
                    sprintf (filename, "a%d", mid - i);
                 }
                 
               if (age == ERROR)
                    age = 32767;          /* No files between min and mid */

               if (age > limit)           /* would we expire this file? */
                    min = mid;            /* yes, search forward */
               else
                    max = mid;            /* no, search backward */
            }

          if (debuglvl > 1)
               fprintf (log, "expire: expiring articles %d to %d\n",
                             grp->index, min);

          /* Now delete all articles, grp->index to min */
          for (i = grp->index;  i <= min; i++)
            {
               sprintf (filename, "a%d", i);
               
               if (debuglvl > 2)
                    fprintf (log, "expiring article: %s\n", filename);

               if (expireflag)
                    unlink (filename);
            }
       }
     /* if deleting files, set lowest # index in active file */
     if (expireflag)
          grp->index = i;
}



/* getage -- return age of file 'filename' in days */

int getage (filename, date)
char *filename;
struct sgtbuf *date;
{
     struct fildes finfo;
     int path, stat, year, mon, day, age;

     /* get the file info sector */
     if ((path = open (filename, S_IREAD)) == -1)
          return (ERROR);                        /* Must already be deleted */

     stat = _gs_gfd (path, &finfo, sizeof (finfo));
     close (path);

     if (stat == ERROR)                          /* Error getting FD */
          return (ERROR);

     /* get file modification date and time */
     year = finfo.fd_date[0];
     mon  = finfo.fd_date[1];
     day  = finfo.fd_date[2];

     /* how old is this article? */
     age  = (date->t_year - year) * 365;
     age += (date->t_month - mon) * 31;
     age += (date->t_day - day);

     if (debuglvl > 2)
          fprintf (log, "article %s age is %d days\n", filename, age);

     return (age);
}
