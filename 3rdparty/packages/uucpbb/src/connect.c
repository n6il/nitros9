/*  connect.c   Run the dial and login scripts when calling a remote.
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
#include <ctype.h>
#include <sgstat.h>

#define WORDSIZE    30
#define SS_BREAK    0x1d                     /* send break signal out acia */

static char *nothing = "<NOTHING>";


/* connect()  --negotiate the dialscript to dial the remote system, then
                negotiate the chatscript to log into the remote system */

int connect (index)
int index;
{
     register flag status;

     fprintf (log, "%s %s %s Calling system %s (port %s)",
              sender, sysname, gtime(), sysname,
              *device != '\0' ? device : "unknown");

     if (index > 1)
          fprintf (log, " (line %d)", index);

     putc ('\n', log);

     /* do dialscript */
     if ((status = doscript (TRUE)) == OK)
       {
          /* do chatscript */
          if ((status = doscript (FALSE)) != OK)
               return (ABORT);                    /* failed script */
       }

     return ((int) status);
}



/* doscript --do a chat script to dial and log in to the remote */

int doscript (dialing) 
flag dialing;
{
     char *words[WORDSIZE];
     register int i;
     flag status;
     int n;

     /* parse chat script into expect/send pairs. */
     n = getargs (words, (dialing ? dialscript : chatscript), WORDSIZE);

     /* cycle through expect/send pairs */
     for (i = 0; i < n; i++)
          if ((i & 1) == 0)
            {
               status = waitfor (*(words + i), dialing);
               switch (status)
                 {
                    case OK:
                         break;

                    case ABORT:
                         return ((int)status);

                    default:
                         if (!dialing)
                           {
                              logerror ("chat script failed");
                              return (CHATERROR);
                           }
                         else
                              return ((int)status); 
                 }
             }
          else
               send (*(words + i));

     return (OK);           /* status okay */
}



int send (msg)
char *msg;
{
     register short i;
     flag crneeded;
     char c;
     int msglen = strlen (msg);

     if (debuglvl > 1)
          fputs ("sendthem: ", log);

     /* send nothing? */
     if (*msg == '|')
       {
          if (debuglvl > 1)
               fprintf (log, "%s\n", nothing);

          return (OK);
       }

     /* send line break? */
     if (*msg == 'B'  &&  strcmp (msg, "BREAK") == 0)
       {
          sendbreak();
          return (OK);
       }

     /* send end-of-transmission character? */
     if (*msg == 'E'  &&  strcmp (msg, "EOT") == 0)
       {
          if (debuglvl > 1)
                fputs ("<EOT>", log);

          write (port, '\x04', 1);
          return (OK);
       }

     for (tsleep (MODEMDELAY), crneeded = TRUE, i = 0; i < msglen; i++)
       {
          c = *(msg + i);

          if (c != '\\')
            {
               if (debuglvl > 1)
                    putc (c, log);

               write (port, &c, 1);
            }
          else
            {
               switch (msg[i + 1])
                 {
                    case 'T':
                         if (debuglvl > 1)
                              fprintf (log, "%s", phone);
                         write (port, phone, strlen (phone));
                         break;

                    case 's':
                         if (debuglvl > 1)
                              fputs ("<SPACE>", log);
                         write (port, " ", 1);
                         break;

                    case 'r':
                         if (debuglvl > 1)
                              fputs ("<CR>", log);
                         write (port, "\x0D", 1);
                         break;

                    case 'n':
                         if (debuglvl > 1)
                              fputs ("<LF>", log);
                         write (port, "\x0A", 1);
                         break;

                    case '\\':
                         if (debuglvl > 1)
                              putc ('\\', log);
                         write (port, "\\", 1);
                         break;

                    case 'd':                        /* 1 second delay */
                         if (debuglvl > 1)
                              fputs ("<DELAY>", log);
                         sleep (1);
                         break;

                    case 'N':
                         if (debuglvl > 1)
                              fputs ("<NUL>", log);
                         write (port, "\0", 1);
                         break;

                    case 't':
                         if (debuglvl > 1)
                              fputs ("<TAB>", log);
                         write (port, "\t", 1);
                         break;

                    case 'b':                                /* back space */
                         if (debuglvl > 1)
                              fputs ("<BS>", log);
                         write (port, "\b", 1);
                         break;

                    case 'c':                              /* don't send CR */
                         if (debuglvl > 1)
                              fputs ("<NO CR>", log);
                         crneeded = FALSE;
                         break;

                    case '^':
                         c = toupper (msg[i + 2]) & 0x3f;
                         if (debuglvl > 1)
                              fprintf (log, "<CNTRL>-%c\n",
                                            toupper (msg[i + 2]));
                         write (port, &c, 1);
                         i += 2;
                         break;

                    case 'K':                          /* send a line break */
                         sendbreak();
                         break;

                    case 'p':                 /* fraction of a second pause */
                         if (debuglvl > 1)
                              fputs ("<PAUSE>", log);

                         tsleep (PORTSLEEP);
                         break;

                    case '[':                                /* send ESCAPE */
                         if (debuglvl > 1)
                              fputs ("<ESC>", log);

                         write (port, "\x1b", 1);
                         break;

                    case '0':
                    case '1':
                    case '2':
                    case '3':
                    case '4':
                    case '5':
                    case '6':
                    case '7':
                         if (debuglvl > 1)
                              fprintf (log, "<%.4s>", &msg[i]);

                         c = (msg[i + 1] - '0') & 0x07;
                         c <<= 3;
                         c |= (msg[i + 2] - '0') & 0x07;
                         c <<= 3;
                         c |= (msg[i + 3] - '0') & 0x07;
                         write (port, &c, 1);
                         i += 2;
                         break;

                    default:
                         break;
                 }
               ++i;
            }
       }

     if (crneeded)
          write (port, "\n", 1);

     if (debuglvl > 1)
          putc ('\n', log);

     return (OK);
}



int waitfor (msg, dialing)
char *msg;
flag dialing;
{
     register char *p;
     flag result;
     char c, *p1, *p2, *p3, *p4, *p5;
     char *nocarrier = "NO CARRIER",
          *busy = "BUSY",
          *noanswer = "NO ANSWER",
          *nodialtone = "NO DIALTONE",      /* for real Hayes compatable */
          *notone2 = "NO DIAL TONE";        /* and not so compatible modems */

     p = msg;
     p1 = busy;
     p2 = nocarrier;
     p3 = noanswer;
     p4 = nodialtone;
     p5 = notone2;

     if (debuglvl > 1)
          fprintf (log, "expect: %s\n", *msg != '|' ? msg : nothing);

     /* expect nothing? */
     if (*msg == '|')
          return (OK);

     while (*p && *p1 && *p2 && *p3 && *p4 && *p5)
       {
          if (readport (&c, dialing  ? CNCTIME : LOGTIME,
                            dialing  ? 1 : MAXLOGTRY) == TIMEDOUT)
            {
               return (ABORT);
            }

          c &= 0x7F;                                 /* strip parity */
                                                     /* check for...       */
          p  = (c == *p)  ? ++p  : msg;              /*    expected string */
          p1 = (c == *p1) ? ++p1 : busy;             /*    BUSY            */
          p2 = (c == *p2) ? ++p2 : nocarrier;        /*    NO CARRIER      */
          p3 = (c == *p3) ? ++p3 : noanswer;         /*    NO ANSWER       */
          p4 = (c == *p4) ? ++p4 : nodialtone;       /*    NO DIALTONE     */
          p5 = (c == *p5) ? ++p5 : notone2;          /*    NO DIAL TONE    */
       }

     if (debuglvl > 1)
          fputs ("got: ", log);
 
     if (*p1 == '\0')                        /* BUSY */
       {
          if (debuglvl > 1)
               fputs (busy, log);
          else
               logerror ("line is BUSY");

          result = BUSY; 
       }
     else if (*p2 == '\0')                   /* NO CARRIER */
       {
          if (debuglvl > 1)
               fputs (nocarrier, log);
          else
               logerror (nocarrier);

          result = NOCARRIER;
       }
     else if (*p3 == '\0')                   /* NO ANSWER */
       {
          if (debuglvl > 1)
               fputs (noanswer, log);
          else
               logerror ("Remote not answering");

          result = NOANSWER;
       }
     else if (*p4 == '\0' || *p5 == '\0')    /* NO DIALTONE */
       {
          if (debuglvl > 1)
               fputs (nodialtone, log);
          else
               logerror (nodialtone);

          result = NODIALTONE;
       }
     else
       {
          if (debuglvl > 1)
               fputs (msg, log);

          result = OK;                       /* status okay */
       }

     if (debuglvl > 1)
          putc ('\n', log);

     return ((int) result);
}



/* Send a line break.  First try using a system call to send a true line
   break.  If that fails, fake it by setting the port to its lowest baud
   rate, send a NUL character and return the port to its original baud rate.
   This will cause a framing error on the receiving end which will act the
   same as a line break.  This method will work on many but not all systems.
*/

int sendbreak()
{
     struct sgbuf options;
     int oldbaud;
     
     /* try sending break via setstat */
     if (_ss_sbreak (port) < 0)
       {
          /* could not do it, so fake one */
          _gs_opt (port, &options);
          oldbaud = options.sg_baud;
          options.sg_baud = 0;
          _ss_opt (port, &options);

          /* send a nul */
          write (port, "\0", 1);

          /* put port back the way we found it */
          options.sg_baud = oldbaud;
          _ss_opt (port, &options);
       }
}



/* Try sending a true line break */

int _ss_sbreak (path)
int path;
{
     return (setstat (SS_BREAK, path));
}



/* Read one byte from the port.  Returns TRUE if successful, TIMEDOUT if we
   timed out. */

int readport (c, seconds, retries)
char *c;
unsigned seconds;                /* timeout in seconds */
int retries;
{
     register int i;

     /* wait for data available */
     for (i = 0;  i < retries;  ++i)
          if ( !timeout (seconds) )             /* something is waiting */
            {
               read (port, c, 1);
               return (TRUE);
            }

     /* we timed out, tell the caller */
     logerror ("readport: timed out");
     return (TIMEDOUT);
}



/* Read 'count' characters into buffer 'p'.  Return # chars read (less than
   'count' only if timeout). */

int readfill (p, count)
register char *p;
int  count;
{
     int rdy, byte_count = 0;

     while (byte_count < count  &&  timeout (1) != TIMEDOUT)
       {
          if ((rdy = min (_gs_rdy (port), count-byte_count)) < 1)
               continue;

          /* Handle I/O Error! */
          if ((rdy = read (port, p, rdy)) == ERROR)
               continue;

          p += rdy;
          byte_count += rdy;
       }
     return (byte_count);
}



/* Timeout will sleep for 'secs' seconds or until there's input ready
   Return:  TIMEDOUT  - if we timed out
            FALSE - if data is waiting */

int timeout (secs)
int secs;
{
     register int i;
     int count;

     /* if input waiting, return */
     if (_gs_rdy (port) > 0)
          return (FALSE);

     /* count *= 4 because we wake up 4 times / second */
     for (count = secs << 2, i = 0; i < count; i++)
          if (_gs_rdy (port) > 0)
               return (FALSE);
          else
            {
               _ss_ssig (port, SIGWAKE);
               tsleep (PORTSLEEP);
               _ss_rel (port);
            }
     return (TIMEDOUT);
}
