/*  procbatch.c   Process a batch of news articles.
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

QQ flag gotgroup;
QQ char *refline = NULL;

/* Silly, hu.... */
QQ char *junk = "junk";
QQ char *space = " ";

char lbuf[512];

int free();
long xatol();
struct mbuf *mwrite();


int procbatch (fd, initalbuf, gh)
FILE *fd;
char *initalbuf;
struct mbuf *gh;
{
     struct mbuf *gg, *mp = NULL, *mh = NULL;
     long origlen, length = -1;
     char *groupname = NULL;
     int rr, r;

     while (feof (fd) == 0)
       {
          if (strncmp (initalbuf, "#! rnews ", 9) != 0)
               log ("Not a batch line");

          origlen = length = xatol (initalbuf+9);

          if (debuglvl > 8)
            {
               sprintf (lbuf, "loop... %ld", length);
               log (lbuf);
            }
          gotgroup = FALSE;

          if (length > 0)
            {
               if (debuglvl > 5)
                 {
                    sprintf (lbuf, "article length: %ld", length);
                    log (lbuf);
                 }

               while ((length > 0) && (feof(fd) == 0))
                 {
                    if (!gotgroup)
                         r = procnewgroup (fd, initalbuf, mp, mh, groupname);
                    else
                      {
                         if (gotgroup)
                              procoldgroup (origlen, gh, mp, mh, groupname);

                         /* Read, either the remaining length or BIGBUF,
                            whichever fits */

                         r = (length > BIGBUF) ? BIGBUF : length;

                         if (debuglvl > 8)
                           {
                              sprintf (lbuf, "reading: %d %ld", r, length);
                              log (lbuf);
                           }

                         if ((rr = fread (initalbuf, 1, r, fd)) != r)
                              log ("procbatch: Read error");

                         r = rr;

                         if (debuglvl > 8)
                           {
                              sprintf (lbuf, "read: %d %ld", r, length);
                              log (lbuf);
                           }

                         crlf (initalbuf, r);

                         /* Write the just-read-in block */
                         for (gg = gh;  gg != NULL;  gg = gg->mbuf_next)
                              if (((struct groups *)gg->cbuf)->artfd != NULL)
                                {
                                   fwrite (initalbuf, 1, r,
                                          ((struct groups *)gg->cbuf)->artfd);
                                }
                      }

                    /* Subtract the amount read */
                    length -= r;
                 }

               /* Close all the open files */
               for (gg = gh;  gg != NULL;  gg = gg->mbuf_next)
                    if (((struct groups *)gg->cbuf)->artfd != NULL)
                      {
                         fclose (((struct groups *)gg->cbuf)->artfd);
                         ((struct groups *)gg->cbuf)->artfd = NULL;
                      }

               /* Reset the groupname and refline strings. */
               groupname = refline = NULL;

               /* Free up the mbuf list, since these mbufs have simple cbufs
                  then just use 'free'  */

               if (mh != NULL)
                 {
                    mfree (mh, free);
                    mp = mh = NULL;
                 }

               /* There might be more batches */
               if (getline (fd, initalbuf) != -1)
                 {

                    /* If something is messed up, then skip until something
                       sane is found */

                    if (strncmp (initalbuf, "#! rnews ", 9) != 0)
                      {
                         if (debuglvl > 1)
                           {
                              strcpy (lbuf, "Mugged article, '");
                              strncat(lbuf, initalbuf, 20);
                              log (lbuf);
                           }

                         if (resync (fd, initalbuf) == TRUE)
                              break;
                      }
                 }
            }
          else
            {
               /* If the length is messed up, then skip until something sane
                  is found */

               if (debuglvl > 1)
                 {
                    sprintf (lbuf, "Bad length '%ld'", length);
                    log (lbuf);
                 }

               if (resync (fd, initalbuf) == TRUE)
                    break;
            }
       }
}



int procnewgroup (fd, initalbuf, mp, mh, groupname)
FILE *fd;
char *initalbuf;
struct mbuf *mp, *mh;
char *groupname;
{
     int r;

     r = getline (fd, initalbuf);

     if (debuglvl > 8)
          lineis (lbuf, initalbuf);

     mp = mwrite (mp, &mh, initalbuf, strlen (initalbuf) + 1);

     if (strncmp (mp->cbuf,"Newsgroups: ",12) == 0)
       {
          groupname = &mp->cbuf[12];

          if (debuglvl > 1)
            {
               sprintf (lbuf, "Newsgroup: %s", groupname);
               log (lbuf);
            }

          if (refline != NULL)
               gotgroup = TRUE;
       }

     /* Bob says that the Reference line shouldn't have tabs in it */
     if (strncmp (mp->cbuf, "References: ", 12) == 0)
       {
          refline = mp->cbuf;
          fixref (refline);

          if (debuglvl > 2)
            {
               sprintf (lbuf, "Reference line is: '%s'", refline);
               log (lbuf);
            }

          if (groupname != NULL)
               gotgroup = TRUE;
       }

     if (mp->cbuf[0] == '\0')
       {
          if (groupname == NULL)
            {
               if (debuglvl > 1)
                    log ("No newsgroup given, junking article");

               groupname = junk;
            }
          gotgroup = TRUE;
       }
     return (r);
}



int procoldgroup (origlength, gh, mp, mh, groupname)
long origlength;
struct mbuf *gh, *mp, *mh;
char *groupname;
{
     register struct mbuf *gg;  

     openarts (gh, groupname);

     /* See note in procart.c */
     if ((origlength - 1) > 0)
          for (gg = gh;  gg != NULL;  gg = gg->mbuf_next)
               if (((struct groups *)gg->cbuf)->artfd != NULL)
                 {
                    if (lseek (fileno (((struct groups *)gg->cbuf)->artfd),
                                      origlength - 1, 0) == -1)
                      {
                         sprintf (lbuf, "Couldn't seek %ld %d",
                                        origlength-1, errno);
                         log (lbuf);
                      }
                    write (fileno (((struct groups *) gg->cbuf)->artfd),
                            space, 1);

                    if (lseek (fileno (((struct groups *)gg->cbuf)->artfd),
                               0l, 0) == -1)
                      {
                         sprintf (lbuf, "Couldn't seek back %ld %d",
                                        origlength, errno);
                         log (lbuf);
                      }
                 }

     for (gg = gh;  gg != NULL; gg = gg->mbuf_next)
          if (((struct groups *)gg->cbuf)->artfd != NULL)
               for (mp = mh;  mp != NULL; mp = mp->mbuf_next)
                    fprintf (((struct groups *)gg->cbuf)->artfd,
                             "%s\n", mp->cbuf);
     gotgroup = TRUE;
}



/* We hit a bad length.  Try to get things back in sync.  Return TRUE if we
   succeed.  Return FALSE on EOF. */

int resync (fd, initalbuf)
FILE *fd;
char *initalbuf;
{
     while (getline (fd, initalbuf) != -1)
          if (strncmp (initalbuf, "#! rnews ", 9) == 0)
               return (TRUE);
          else if (debuglvl > 5)
            {
               strncat (strcpy (lbuf, "skip.... '"), initalbuf, 20);
               log (lbuf);
            }
     return (FALSE);
}



/* Change all the line feeds to carrage returns. */

int crlf (s, len)
char *s;
int len;
{
     register char *bscan;

     for (bscan = s + len;  --bscan >= s; )
          if (*bscan == '\x0A')
               *bscan = '\x0D';
}
