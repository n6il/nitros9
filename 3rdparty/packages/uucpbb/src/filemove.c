/*  filemove.c   Various routines to copy, move and append files.
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

/* These functions return TRUE, on successful copying, FALSE if there
   was an error. */

#include "uucp.h"
#include <modes.h>

#define BSIZE     1024

FILE *skpheader();


/* Fast move a file.  No LF <-> CR translation takes place.  The original
   file remains unchanged. */

int filemovf (infile, dest)
FILE *infile;
char *dest;
{
     FILE *outfile;

     if ((outfile = fopen (dest, "w")) == NULL)
          return (FALSE);

     return (fastcopy (infile, outfile, FALSE, FALSE));
}


/* Copy a file from one place to another.  No LF <-> CR translations is done.
   The source file is deleted after a successful move. */

int filemove (source, dest)
char *source, *dest;
{
     FILE *infile, *outfile;
     int noerror;

     if ((infile = fopen (source, "r")) == NULL)
          return (FALSE);

     if ((outfile = fopen (dest, "w")) == NULL)
          return (FALSE);

     noerror = fastcopy (infile, outfile, FALSE, FALSE);

     if (noerror)
          unlink (source);

     return (noerror);
}



/* Copy file changing CRs to LFs.  The source file is deleted after a 
   successful copy. */

int filemovl (source, dest)
char *source, *dest;
{
     FILE *infile, *outfile;
     int noerror;
     
     if ((infile = fopen (source, "r")) == NULL)
          return (FALSE);

     if ((outfile = fopen (dest, "w")) == NULL)
          return (FALSE);

     noerror = fastcopy (infile, outfile, TRUE, FALSE);

     if (noerror)
          unlink (source);

     return (noerror);
}


/* Copy a file to another.  No LF <-> CR translation is done.  The source
   file is left unchanged. */

int filecopy (source, dest)
char *source, *dest;
{
     FILE *infile, *outfile;

     if ((infile = fopen (source, "r")) == NULL)
          return (FALSE);

     if ((outfile = fopen (dest, "w")) == NULL)
          return (FALSE);

     return (fastcopy (infile, outfile, FALSE, FALSE));
}


/* Append one file onto another.  If the variable lf2cr is TRUE, any LF are
   changed to CRs during the copy.  If lf2cr is FALSE, any CRs are changed
   to LFs during the copy.  The source file is left unchanged. */

int fileapnd (source, dest, lf2cr)
char *source, *dest;
flag lf2cr;
{
     FILE *infile, *outfile;

     if ((infile = fopen (source, "r")) == NULL)
          return (FALSE);

     if ((outfile = fopen (dest, "a")) == NULL)
          return (FALSE);

     return (fastcopy (infile, outfile, TRUE, lf2cr));
}



/* Same as fileapnd() above, except all lines are skip until the first blank
   line containing only a CR or LF is reached, appending begins with the
   following line. */

int fileapskp (source, dest, lf2cr)
char *source, *dest;
int lf2cr;
{
     FILE *infile, *outfile;

     if ((infile = fopen (source, "r")) == NULL)
          return (FALSE);

     if ((outfile = fopen (dest, "a")) == NULL)
          return (FALSE);

     infile = skpheader (infile);
     return (fastcopy (infile, outfile, TRUE, lf2cr));
}



/* Fast copy a file.  If lf2cr is TRUE, all LFs are changed to CRs.  If lf2cr
   is FALSE, all CRs are changed to LFs.

   Attempt to lessen file fragmentation by seeking outfile to the maximum
   length of infile, write a byte, then rewind the file pointer.  */

int fastcopy (infile, outfile, fixLFCR, lf2cr)
FILE *infile;
FILE *outfile;
int fixLFCR, lf2cr;
{
     char buff[BSIZE];
     register char *bscan;
     char *p, fromchar, tochar;
     int count, noerror = TRUE;
     long insize, _gs_size();

     if (fixLFCR)                                       /* LF->CR or CR->LF */
       {
          fromchar = lf2cr ? '\x0A' : '\x0D';
          tochar   = lf2cr ? '\x0D' : '\x0A';
       }

     if ((insize = _gs_size (fileno (infile))) != -1)
       {
          long origptr;

          origptr = ftell (outfile);
          fseek (outfile, insize - 1, 1);
          write (fileno (outfile), " ", 1);
          fseek (outfile, origptr, 0);
       }

     p = buff;

     while ((count = fread (p, sizeof (char), BSIZE, infile)) != 0)
       {
          if (fixLFCR)
               for (bscan = p + count; --bscan >= p; )
                    if (*bscan == fromchar)
                         *bscan = tochar;

          if (fwrite (p, sizeof (char), count, outfile) == 0)
               if (feof (outfile) == 0)
                 {
                    noerror = FALSE;
                    break;
                 }
       }

     if (feof (infile) == 0)
          noerror = FALSE;

     fclose (infile);
     fclose (outfile);
     return (noerror);
}



/* Read a file until we come to a line starting with a CR or LF.  The file
   pointer is returned pointing to the next line to read. */

FILE *skpheader (file)
FILE *file;
{
     char buffer[256], *p;

     p = buffer;

     while (mfgets (p, sizeof (buffer), file) != NULL)
          if (*p == '\0')
               break;

     return (file);
}
