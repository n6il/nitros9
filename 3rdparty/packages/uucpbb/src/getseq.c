/*  getseq.c   The routine returns a unique sequence number as a type long.
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

EXTERN QQ unsigned myuid;


long getseq (seqfile)
char *seqfile;
{
     char tmpstr[7];
     FILE *file;
     long sequence, atol();

     /* become superuser */
     asetuid (0);

     /* update sequence number */
     if ((file = fopen (seqfile, "r")) == NULL)
       {
          if ((file = fopen (seqfile, "w")) == NULL)
               fatal ("getseq() can't open sequence file for read or create");

          fputs ("1\n", file);
          sequence = 1;
       }
     else
       {
          mfgets (tmpstr, sizeof (tmpstr), file);
          fclose (file);
          sequence = atol (tmpstr) + 1;

          /* if sequence reachs 100,000, wrap back to 1 */
          if (sequence > 99999)
               sequence = 1;

          if ((file = fopen (seqfile, "w")) == NULL)
               fatal ("getseq() can't open sequence file for write");

          fprintf (file, "%ld\n", sequence);
       }

     /* protect sequence file */
     fixperms (file);
     asetuid (myuid);
     fclose (file);
     return (sequence);
}
