/*  termio.c   Terminal I/O support routines
    Copyright (C) 1993  Boisy G. Pitre

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

#ifdef TERMCAP
# ifndef BSDISH
#  ifdef _OSK
#   include <termcap.h>
#  else
#   include "ttydefs.h"
#  endif
# endif

#ifdef _OSK
#define TCAPSLEN 2048
#else
#define TCAPSLEN 400                                /* CoCo */
#endif

extern char *getenv();
void ErEOLine();
void curxy();

int nrows, ncolumns;
static char tcapbuf[TCAPSLEN];

# ifdef _OSK
char PC_,    /* pad character */
     *BC,    /* cursor backspace */
     *UP;    /* cursor up */
short ospeed;
# else
char PC_;    /* rest are defined in termcap library */
#ifdef BSDISH
char *UP;
#endif
# endif

static char *CM,
            *CL,
            *DL,
            *CE,
            *CD,
            *SO,
            *SE,
            *BL,
            *VE,
            *VI,
            *CR;

# ifndef _OSK
#  ifndef BSDISH
#   include <os9.h>

char *crtbynam();
char *crtbypth();

#   define LINESIZE 80

char *crtbynam(line, buffer)
char *line, *buffer;
{
     char linebuff[LINESIZE],
     int found = 0;                      /* indicates tty line was found */
     register char  *workptr;
     FILE * ttysfd;

     /* Open the TTYTYPE file, in either of three directories */
     if ((ttysfd = fopen ("/r0/sys/ttytype", "r")) == NULL)
          if ((ttysfd = fopen ("/r/sys/ttytype", "r")) == NULL)
               ttysfd = fopen ("/dd/sys/ttytype", "r");

     /* Search through the TTYTYPE file for a match on this 'line' */

     if (ttysfd != NULL) {
#ifdef DEBUG
          fprintf (stderr, "File 'ttytype' was found and opened ok\n");
#endif

          while (fgets (linebuff, LINESIZE, ttysfd) != NULL) {
               if (workptr = index (linebuff, ' ')) {
                    /* Terminate the LINE name */
                    *workptr++ = '\0';

                    /* Index forward to the CRT name */
                    workptr = skipbl (workptr);

                    if (strucmp (line, linebuff) == 0) {
                         found++;
#ifdef DEBUG
     fprintf(stderr,"line %s was found in the file\n",line);
#endif
                         strcpy (buffer, workptr);
                         for (workptr = buffer; (!isspace (*workptr)); workptr++) {
                              /* do nothing */;
                         }
                         *workptr = '\0';
#ifdef DEBUG
     fprintf(stderr,"content of buffer [crtname] is: %s\n",buffer);
#endif
                         break;
                      }
                 }
          }
          fclose (ttysfd);

          if (found)
               return (buffer);
          else
               return ((char *)NULL);
     }
     else
          return ((char *)NULL);
}


/* Don't need this right now on CoCo?  --REB */
#   ifdef ORIGCODE
char *crtbypth (path, buffer)
int path;
char *buffer;
{
     char line[32];

     *line = '/';
     getstat (SS_DEVNM, path, &line[1]);
     strhcpy (line, line);
     return (crtbynam (line, buffer));
}
#   endif
#  endif
# endif



void term (str)
char *str;
{
    fputs (str, stderr);
    exit(0);
}



void init_term_cap()
{
# ifdef _OSK
     register char *term_type;
# else
#  ifdef BSDISH
     char *term_type;
     char tt[32];
#  else
     char term_type[32];
#  endif
# endif

#ifdef _OSK
     char tcbuf[2048];
#else
     char tcbuf[1024];                                   /* CoCo */
#endif
     char *ptr = tcapbuf;

     if ((term_type = getenv ("TERM")) == 0) {
          term ("Environment variable TERM not defined!\n");
     }

#  ifdef BSDISH
     strcpy (tt, term_type);
     term_type = tt;
#  endif

     if (tgetent (tcbuf, term_type) <= 0) {
          sprintf (tcbuf, "Unknown terminal type '%s'\n", term_type);
          term (tcbuf);
     }
 
     if ((CL = tgetstr ("cl", &ptr)) == NULL)
          term ("'cl' capability not found\n");
     if ((CM = tgetstr ("cm", &ptr)) == NULL)
          term ("'cm' capability not found\n");
     if ((CE = tgetstr ("ce", &ptr)) == NULL)
          term ("'ce' capability not found\n");
     if ((CD = tgetstr ("cd", &ptr)) == NULL)
          term("'cd' capability not found\n");
     if ((DL = tgetstr ("dl", &ptr)) == NULL) {
          if ((CR = tgetstr("cr", &ptr)) == NULL)
               CR = "\015";
     }
     UP = tgetstr ("up", &ptr);

     if ((SO = tgetstr ("so", &ptr)) != NULL)
          SE = tgetstr ("se", &ptr);
     else if ((SO = tgetstr ("md", &ptr)) != NULL)
          SE = tgetstr ("me", &ptr);
     else if ((SO = tgetstr ("us", &ptr)) != NULL)
          SE = tgetstr ("ue", &ptr);
     else
          SE = NULL;

    VI = tgetstr ("vi", &ptr);
    VE = tgetstr ("ve", &ptr);
    BL = tgetstr ("bl", &ptr);

    if (ptr >= &tcapbuf[TCAPSLEN])
         term ("Terminal description too big\n");

    nrows = tgetnum ("li");
    ncolumns = tgetnum ("co");
    
    if (!nrows || !ncolumns) {
         nrows = 80;
         ncolumns = 24;
    }
}
#endif

#ifdef BSDISH
void out_char (c)
char c;
{
     write (1, &c, 1);
}



#define FPUTS(STR,FD) tputs(STR,1,out_char)
#else
#define FPUTS(STR,FD) fputs(STR,FD)
#endif

void CurUp()
{
#ifdef TERMCAP
# ifdef BSDISH
     fflush (stdout);
# endif
     FPUTS (UP, stdout);
#else
     putchar ('\x09');
#endif
     fflush (stdout);
}



void DelLine()
{
#ifdef TERMCAP
     if (DL == NULL) {
# ifdef BSDISH
          fflush(stdout);
# endif
          FPUTS(CR, stdout);
          FPUTS(CE, stdout);
     }
     else {
          FPUTS (DL, stdout);
     }
#else
     FPUTS ("\x1f\x31", stdout);
#endif
     fflush (stdout);
}



void DelLines (startline, numlines)
int startline, numlines;
{
     curxy (0, startline);
     while (numlines--) {
          ErEOLine();
          putchar ('\n');
     }
     curxy (0, startline);
}



void ErEOScrn()
{
#ifdef TERMCAP
# ifdef BSDISH
     fflush(stdout);
# endif
     FPUTS (CD, stdout);
#else
     putchar ('\x0B');
#endif
     fflush (stdout);
}



void ErEOLine()
{
#ifdef TERMCAP
# ifdef BSDISH
     fflush(stdout);
# endif
     FPUTS (CE, stdout);
#else
     putchar ('\x04');
#endif
     fflush (stdout);
}



void Bell()
{
#ifdef TERMCAP
     if (BL) {
#  ifdef BSDISH
          fflush(stdout);
# endif
          FPUTS (BL, stdout);
     }
#else
     putchar ('\x07');
#endif
     fflush (stdout);
}



void ReVOn()
{
#ifdef TERMCAP
     if (SO) {
# ifdef BSDISH
          fflush (stdout);
# endif
           FPUTS (SO, stdout);
     }
     else
           fputs ("** ", stdout);
#else
     FPUTS ("\x1f\x20", stdout);
#endif
     fflush (stdout);
}



void ReVOff()
{
#ifdef TERMCAP
     if (SE) {
# ifdef BSDISH
          fflush (stdout);
# endif
          FPUTS (SE, stdout);
     }
     else
          fputs (" **", stdout);
#else
     FPUTS ("\x1f\x21", stdout);
#endif
     fflush (stdout);
}



void CurOn()
{
#ifdef TERMCAP
     if (VE) {
# ifdef BSDISH
          fflush (stdout);
# endif
          FPUTS (VE, stdout);
     }
#else
     FPUTS ("\x05\x21", stdout);
#endif
     fflush (stdout);
}



void CurOff()
{
#ifdef TERMCAP
     if (VI) {
# ifdef BSDISH
          fflush (stdout);
# endif
          FPUTS (VI, stdout);
     }
#else
     FPUTS ("\x05\x20", stdout);
#endif
     fflush (stdout);
}



void cls()
{
#ifdef TERMCAP
     if (CL) {
# ifdef BSDISH
          fflush (stdout);
# endif
          FPUTS (CL, stdout);
     }
#else
     putchar ('\x0c');
#endif
     fflush(stdout);
}



void curxy (x, y)
int x,y;
{
#ifdef TERMCAP
     char *t;

     t = tgoto (CM, x, y);
# ifdef BSDISH
     fflush (stdout);
# endif
     FPUTS (t, stdout);
#else
     printf ("\x02%c%c", x+32, y+32);
#endif
     fflush (stdout);
}
