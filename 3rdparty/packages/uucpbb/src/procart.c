/* procart.c - Process a single article into one or more news groups.
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

extern char *junk;
extern char *space;
struct mbuf *mwrite();
extern int debuglvl;

int free();

int procart (fd, initalbuf, initng, gh, origlength)
FILE *fd;
char *initalbuf, *initng;
struct mbuf *gh;
long origlength;
{
     char lbuf[512];
     char *newsgroups = NULL, *refline = NULL;
     int gotgroup = FALSE, r;
     struct mbuf *mh = NULL, *mp = NULL;
     register struct mbuf *gg;

     /* A inital newsgroup may be forced onto this article */
     if (*initng != '\0')
          newsgroups = initng;

     mp = mwrite (mp, &mh, initalbuf, strlen (initalbuf) + 1);

     while (feof (fd) == 0)
       {
          if (gotgroup == FALSE)
            {
               getline (fd, initalbuf);

               if (debuglvl > 8)
                    lineis (lbuf, initalbuf);

               mp = mwrite (mp, &mh, initalbuf, strlen (initalbuf) + 1);

               if (*initng == '\0')
                 {
                    if (strncmp (mp->cbuf, "Newsgroups: ", 12) == 0)
                      {
                         newsgroups = &mp->cbuf[12];

                         if (debuglvl > 1)
                           {
                              sprintf (lbuf, "Newsgroup: %s", newsgroups);
                              log (lbuf);
                           }

                         if (refline != NULL)
                              gotgroup = TRUE;
                      }
                 }

               /* Bob says that tabs need to be eaten from References: lines
                */
              if (strncmp (mp->cbuf, "References: ", 12) == 0)
                {
                   refline = mp->cbuf;
                   fixref (refline);

                   if (debuglvl > 2)
                     {
                        sprintf (lbuf, "Reference line is: '%s'", refline);
                        log (lbuf);
                     }

                   if (newsgroups != NULL)
                        gotgroup = TRUE;
                 }

               if (mp->cbuf[0] == '\0')
                 {
                    if (newsgroups == NULL)
                      {
                         if (debuglvl > 1)
                              log ("No newsgroup given, junking article");

                         newsgroups = junk;
                      }
                    gotgroup = TRUE;
                 }
            }
          else
            {
               if (gotgroup == TRUE)
                 {
                    openarts (gh, newsgroups);

                    if (origlength != -1)
                         if ((origlength - 1) > 0)
                              extendfile (gh, origlength, lbuf);

                    /* Write the inital few lines to the file(s) */
                    for (gg = gh; gg != NULL; gg = gg->mbuf_next)
                         if (((struct groups *)gg->cbuf)->artfd != NULL)
                              for (mp = mh; mp != NULL; mp = mp->mbuf_next)
                                   fprintf (((struct groups *)gg->cbuf)->artfd,"%s\n", mp->cbuf);

                    gotgroup++;
                 }

               if ((r = fread (initalbuf, 1, BIGBUF-1, fd)) < 0)
                    log ("procart: read error");

               if (debuglvl > 8)
                 {
                    sprintf (lbuf, "read: %d", r);
                    log (lbuf);
                 }
               crlf (initalbuf, r);

               /* Write a just-read block */
               for (gg = gh;  gg != NULL;  gg = gg->mbuf_next)
                    if (((struct groups *)gg->cbuf)->artfd != NULL)
                         fwrite (initalbuf, 1, r,((struct groups *)gg->cbuf)->artfd);
            }
       }

     /* Close all the open files */
     for (gg = gh; gg != NULL; gg = gg->mbuf_next)
          if (((struct groups *)gg->cbuf)->artfd != NULL)
            {
               fclose (((struct groups *)gg->cbuf)->artfd);
               ((struct groups *)gg->cbuf)->artfd = NULL;
            }

     /* free the mbuf list, use 'free' because the cbufs are simple */
     if (mh != NULL)
          mfree (mh, free);
}



/* This next bit is a attempt to lessen the disk fragmentation that seems to
   occur when spooling news.  It seeks to the maximum length that a article
   may be and then writes a byte.  It then rewinds.  Hopefully, contiguous
   blocks will be allocated */

int extendfile (gh, origlength, lbuf)
struct mbuf *gh;
long origlength;
char lbuf[];
{
     register struct mbuf *gg;

     for (gg = gh; gg != NULL; gg = gg->mbuf_next)
          if (((struct groups *)gg->cbuf)->artfd != NULL)
            {
               if (lseek (fileno (((struct groups *)gg->cbuf)->artfd),
                                  origlength-1, 0) == -1)
                 {
                    sprintf (lbuf, "Couldn't seek %ld %d",
                                   origlength-1, errno);
                    log (lbuf);
                 }

               write (fileno (((struct groups *)gg->cbuf)->artfd), space, 1);

               if (lseek (fileno (((struct groups *)gg->cbuf)->artfd), 0L, 0)
                      == -1)
                 {
                    sprintf (lbuf, "Couldn't seek back %ld %d",
                                   origlength, errno);
                    log (lbuf);
                 }
            }
}



int lineis (lbuf, initalbuf)
char lbuf[], *initalbuf;
{
     strncat (strcpy (lbuf, "LINE IS '"), initalbuf, 20);
     log (lbuf);
}
