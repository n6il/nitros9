/*  mbuf.c - Provides some basic linked list management.
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

/* Note:  It is up to the caller to keep track of what is in each block. */

/* Perhaps a mread should be written sometime */

extern int debuglvl;

#include <stdio.h>
#include "mbuf.h"

/* This function writes a block into a mbuf list.  Its ok for mp and mhp
   to be NULL */

struct mbuf *mwrite (mp, mhp, buf, len)
struct mbuf *mp;
struct mbuf **mhp;
char *buf;
int len;
{
     struct mbuf *mh;
     char *sp,*dp;

     mh = *mhp;

     if (mh == NULL)
       {
          if ((mh = (struct mbuf *) malloc (sizeof (struct mbuf))) == NULL)
            {
               log ("Couldn't malloc head space for mbuf");
               exit(207);
            }
          mp = mh;
       }
     else
       {
          if (mp == NULL)
               for (mp = mh; mp->mbuf_next != NULL; mp = mp->mbuf_next);
                    if ((mp->mbuf_next = (struct mbuf *)malloc(sizeof(struct mbuf))) == NULL)
                      {
                         log ("Couldn't malloc mbuf space");
                         exit (207);
                      }
          mp = mp->mbuf_next;
       }

     mp->mbuf_next = NULL;

     /* If buf is NULL, then make a blank mbuf entry */

     if (buf != NULL)
       {
          if ((mp->cbuf = (char *)malloc(len)) == NULL)
            {
               log ("Couldn't malloc cbuf space");
               exit (207);
            }
          memcpy ((char *)mp->cbuf, (char *)buf, len);
       }
     else
          len = 0;

     *mhp = mh;
     mp->siz = len;
     return (mp);
}



/* This function frees a mbuf list.  The function cfree should free any
   sub-malloced parts of the cbuf.  This function could also be used to
   close open files, or whatever.  For simple things, the function can
   be 'free' */

int mfree (mh, cfree)
struct mbuf *mh;
int (*cfree)();
{
     struct mbuf *mp,*mp2;

     mp = mh;
     while (mp != NULL)
       {
          mp2 = mp->mbuf_next;

          if (mp->cbuf != NULL)
               (*cfree)(mp->cbuf);

          free (mp);
          mp = mp2;
       }
}
