/*  getparam.c   This routine reads global or user's parameters files.
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
#include "uucico.h"
#ifndef _OSK
#include <password.h>
#endif

#define WORDSIZE  10

#ifdef _OSK
#define PWNSIZ 28
#endif

QQ char *scratchdir   = "/dd",
        *scratchbig   = "/dd",
        *uucphost     = '\0',
        *inhost       = '\0',
        *bithost      = '\0',
        *organization = '\0',
        *nodename     = '\0',
        *sitename     = '\0',
        *name         = '\0',
        *pager        = '\0';                /* optional reader for MailX */

/* Pointer to the host that provides our Usenet newsfeed.  This can be either
   our UUCP, Internet or Bitnet host.  If no host is given in the global
   parameter file, the default host becomes the first system listed in the
   /DD/SYS/UUCP/Systems file.  This default can be overridden by -S in
   POSTNEWS. */

QQ char *newshost = '\0';

/* bounced mail goes here unless overridden in Parameters file */
QQ char *errorsto = "postmaster";

QQ char quotechar = '>';              /* quote character used in ~m in mail */
                                      /* and postnews */
QQ char sepsym = '@';                 /* mail separator symbol -- BAS       */
QQ int rec_window = 1;                /* default window size for gproto()   */
QQ int rec_segment = K64;             /* default segment size for gproto()  */
QQ flag fullheader = TRUE;            /* default to showing full header     */
QQ flag auto_rot  = FALSE;            /* made direct page variables         */
QQ flag cc_prompt = FALSE;            /*                                    */
QQ flag fsactive  = FALSE;            /* assume file server is turned off   */
QQ flag dropDTR   = FALSE;            /* +++ATH to hand up modem.           */
                                      /* Default is use +++ATH              */
QQ unsigned myuid;

/* Global temp variable.  NEVER used to return a value, nor across a
   subroutine call which might use this temp.  May be used to parse a string
   into words via getargs(). */

char temp[1024];

/* global temp variable which contains a filename.  Use only long enough
   to open a file. */

char fname[100];

char tz[10] = "";
char user[PWNSIZ+1] = "";



/* getparam -- read parameter file + get other parameters */

int getparam()
{
     myuid = getuid();
     sprintf (fname, "%s/Parameters", UUCPSYS);
     return (readparam (fname, TRUE));
}



/* readparam  -- read parameter file for system parameters */

int readparam (filename, global)
char *filename;                  /* parameter file filename */
int global;                      /* is this the system-wide parameter file? */
{
     char line[132];
     FILE *file;
     register char *p;
     char *words[WORDSIZE], *tmp_ptr;
     int n, which, linecount;

     asetuid (0);

     if ((file = fopen (filename, "r")) == NULL)
       {
          if (!global)              /* it's OK if we can't find a user's */
            {
               asetuid (myuid);
               return (TRUE);       /* parameter file */
            }
          fputs ("readparam: cannot open Parameters\n", stderr);
          asetuid (myuid);
          return (FALSE);
       }
     asetuid (myuid);
     p = line;
     linecount = 0;

     /* ignored comments lines starting with #, *, <space>, <tab> or <cr> */
     while (mfgets (p, sizeof (line), file) != NULL)
       {
          ++linecount;

          if (ISCOMMENT (*p) )
               continue;

          strcpy (temp, p);

          /* Changed to prevent bus errors on incomplete entries -- BGP */
          if ((n = getargs (words, temp, WORDSIZE)) == 1)
            {
               badentry (p, line, FALSE);
               continue;
            }

          if (words[1][0] != '=')
            {
               fprintf (stderr,
                        "readparam: illegal parameter line: %s at line %d\n",
                        p, linecount);
               return (FALSE);
            }

          /*-----> Parameters in either mailrc or global param file <-----*/

          /* organization */
          else if (strucmp (*words, "organization") == 0)
            {
               if (n < 3)
                 {
                    badentry (p, linecount, FALSE);
                    continue;
                 }

               if (*organization == '\0')
                    if ((organization = strdup (words[2])) == NULL)
                         badentry("organization", linecount, TRUE);
            }

          /* prompt Cc:? */
          else if (strucmp (*words, "cc_prompt") == 0
                   || strucmp (*words, "askcc") == 0)
            {
               if (n < 3)
                    badentry (p, linecount, FALSE);
               else
                    cc_prompt = setonoff (*(words+2), linecount);
            }

          /* Automatically un-rot rot13'ed news articles? */
          else if (strucmp (*words, "auto_rot") == 0)
            {
               if (n < 3)
                    badentry (p, linecount, FALSE);
               else
                    auto_rot = setonoff (*(words+2), linecount);
            }

          /* get real name */
          else if (strucmp (*words, "realname") == 0)
            {
               if (n < 3)
                 {
                    badentry (p, linecount, FALSE);
                    continue;
                 }

               if ((name = strdup (words[2])) == NULL)
                    badentry ("realname", linecount, TRUE);
            }

          /* Get file viewer such as MORE, VU for reading mail. */
          else if (strucmp (*words, "pager") == 0)
            {
               if (n < 3)
                 {
                    badentry (p, linecount, FALSE);
                    continue;
                 }

               if ((pager = strdup (words[2])) == NULL)
                    badentry ("pager", linecount, TRUE);
            }

          /* Set default quote char for ~m in mail and postnews */
          else if (strucmp (*words, "quote") == 0)
            {
               if (n < 3)
                    badentry (p, linecount, FALSE);
               else
                    quotechar = words[2][0];
            }

          /* This allows for something besides a '@' character between a user
             and their address -BAS */

          else if (strucmp (*words, "separatesym") == 0)
            {
               if (n < 3)
                    badentry (p, linecount, FALSE);
               else
                    sepsym = words[2][0];
            }

          else if (strucmp (*words, "fullheader") == 0)
            {
               if (n < 3)
                    badentry (p, linecount, FALSE);
               else
                    fullheader = setonoff (*(words+2), linecount);
            }

          else if (!global)              /* allow following parameters only */
               continue;                 /* in /dd/sys/uucp/Parameters */

          /*------> Parameters only from global parameter file <------*/

          /* use +++ATH or drop DTR to hang up modem? */
          else if (strucmp (*words, "hangup") == 0)
            {
               if (n < 3)
                    badentry (p, linecount, FALSE);
               else
                    dropDTR = (strucmp (*(words+2), "DTR") == 0) ? TRUE
                                                                 : FALSE;
            }

          /* who to send bounced mail to.  Default is 'postmaster'. */
          else if (strucmp (*words, "errorsto") == 0)
            {      
               if (n < 3)
                 {
                    badentry (p, linecount, FALSE);
                    continue;
                 }
               else
                    tmp_ptr = errorsto;

               if ((errorsto = strdup (words[2])) == NULL)
                    errorsto = tmp_ptr;
            }

          /* nodename */
          else if (strucmp (*words, "nodename") == 0)
            {
               if (n < 3)
                 {
                    badentry (p, linecount, FALSE);
                    continue;
                 }

               if ((nodename = strdup (words[2])) == NULL)
                    badentry ("nodename", linecount, TRUE);
            }

          /* sitename (nodename plus domain) */
          else if (strucmp (*words, "sitename") == 0)
            {
               if (n < 3)
                 {
                    badentry (p, linecount, FALSE);
                    continue;
                 }

               if (*(words+2) != '\0')
                 {
                    if ((sitename = strdup (words[2])) == NULL)
                         badentry ("sitename", linecount, TRUE);
                 }
               else
                 {
                    sitename = (char *) malloc (strlen (nodename) + 6);
                    strcat (strcpy (sitename, nodename), ".UUCP");
                 }
            }

          /* timezone */
          else if (strucmp (*words, "tz") == 0)
               switch (n)
                 {
                    case 3:
                         /* if given only one TZ string, return it */
                         strcpy (tz, *(words+2));
                         break;

                    case 4:
                         strcpy (tz, isdst() ? *(words+3) : *(words+2));
                         break;

                    default:
                         badentry (p, linecount, FALSE);
                         break;
                 }

          /* scratch directory */
          else if (strucmp (*words, "scratch") == 0)
            {
               if (n < 3)
                 {
                    badentry (p, linecount, FALSE);
                    continue;
                 }
               else
                    tmp_ptr = scratchdir;

               if ((scratchdir = strdup (words[2])) == NULL)
                    scratchdir = tmp_ptr;
            }

          /* big scratch directory */
          else if (strucmp (*words, "bigscratch") == 0)
            {
               if (n < 3)
                 {
                    badentry (p, linecount, FALSE);
                    continue;
                 }
               else
                    tmp_ptr = scratchbig;

               if ((scratchbig = strdup (words[2])) == NULL)
                    scratchbig = tmp_ptr;
            }

          /* UUCP smart host */
          else if (strucmp (*words, "uucphost") == 0)
            {
               if (n < 3)
                 {
                    badentry (p, linecount, FALSE);
                    continue;
                 }

               if ((uucphost = (char *) malloc (strlen (words[2])+2)) == NULL)
                     badentry ("uucphost", linecount, TRUE);

               strcat (strcpy (uucphost, words[2]), "!");
            }

          /* Internet smart host */
          else if (strucmp (*words, "inhost") == 0)
            {
               if (n < 3)
                 {
                    badentry (p, linecount, FALSE);
                    continue;
                 }

               if ((inhost = (char *) malloc (strlen (words[2])+2)) == NULL)
                     badentry ("inhost", linecount, TRUE);

               strcat (strcpy (inhost, words[2]), "!");
            }

          /* Bitnet smart host */
          else if (strucmp (*words, "bithost") == 0)
            {
               if ((bithost = (char *) malloc (strlen (words[2])+2)) == NULL)
                     badentry ("bithost", linecount, TRUE);

               strcat (strcpy (bithost, words[2]), "!");
            }

          /* Default Usenet newsfeed host. */
          else if (strucmp (*words, "newshost") == 0)
            {
               if (n < 3)
                 {
                    badentry (p, linecount, FALSE);
                    continue;
                 }

               if ((newshost = (char *) malloc (strlen (words[2])+1)) == NULL)
                     badentry ("newshost", linecount, TRUE);

               strcpy (newshost, words[2]);
            }

          /* UUCP receiving window size */
          else if (strucmp (*words, "window") == 0)
            {
               if (n < 3)
                 {
                    badentry (p, linecount, FALSE);
                    continue;
                 }
               else
                    rec_window = atoi (*(words+2));

               if (rec_window < 1 || rec_window > 7)
                 {
                    fprintf (stderr, "readparam: illegal window size: %s at line %d\n",
                               words[2], linecount);
                    return (FALSE);
                 }
            }

          /* file server turned on? */
          else if (strucmp (*words, "server") == 0)
            {
               if (n < 3)
                    badentry (p, linecount, FALSE);
               else
                    fsactive = setonoff (*(words+2), linecount);
            }
       }

     if (global  &&  *inhost == '\0'  &&  *bithost == '\0')
       {
          fputs ("readparam: must have either 'inhost' or 'bithost' parameter\n",
                 stderr);
          return (FALSE);
       }

     return (TRUE);
}



int setonoff (word, thisline)
register char *word;
int thisline;
{
     if ((strucmp (word, "on") == 0)  ||  (strucmp(word, "yes") == 0))
          return (TRUE);

     if ((strucmp (word, "off") == 0) ||  (strucmp(word, "no") == 0))
          return (FALSE);

     fprintf (stderr,
              "readparam: illegal setonoff() value: '%s' at line %d\n",
              word, thisline);
     exit (ABORT);
}



int badentry (param, line, isdup)
char *param;
int line;
flag isdup;
{
     char *getparam = "getparam: ";

     if (isdup)
       {
          sprintf (temp, "%scan't dup parameter '%s' at line %d...error %d",
                         getparam, param, line, errno);
          fatal (temp);
       }
     else
       {
          fprintf (stderr, "%sbad parameter line: %s at line %d\n",
                           getparam, param, line);
       }
}



/* Are we in Daylight Savings Time?  Return TRUE if we are.  FALSE if we
   are not. */

int isdst()
{
     struct tm *ltime;
#ifdef _OSK
     time_t t;
#else
     long t;
#endif

     time (&t);
     ltime = localtime (&t);

     /* DST run from 2 a.m. of *first* Sunday in April till last Sunday in
        October.  Fixed wrong DST start day. --REB */

     /* Jan-Mar, Nov-Dec */
     if ((ltime->tm_mon < 3) || (ltime->tm_mon > 9))
          return (FALSE);

     /* May-Sep */
     else if ((ltime->tm_mon > 3) && (ltime->tm_mon < 9))
          return (TRUE);

     else if (ltime->tm_mon == 3)
       {
          /* after 2 a.m. of the *first* Sunday of April? */
          if (((ltime->tm_mday - ltime->tm_wday + 7) > 7)
                && (ltime->tm_hour >= 2))
            {
               return (TRUE);                /* DST */
            }
          else
               return (FALSE);
       }
     else
       {
          /* after 2am of the last Sunday of Oct? */
          if (((ltime->tm_mday - ltime->tm_wday + 7) > 31)
                && (ltime->tm_hour >= 2))
            {
               return (FALSE);
            }
          else
               return (TRUE);                 /* DST */
       }
}
