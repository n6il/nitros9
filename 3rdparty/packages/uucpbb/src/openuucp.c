/*  openuucp.c    Establish a uucp connection with the remote.
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

#define DLE  '\x10'                                /* DLE character */

static char *handshake_ok = "Handshake successful",
            *no_proto = "no supported protocol",
            *startG = "start g protocol handshake",
            *whoweare = "telling remote who we are: ";


/**********************************\
* open uucp session in master mode *
\**********************************/

int mopenuucp()
{
     char string[200];
     register char *p;
     int i;

     p = string;

     if (debuglvl > 0)
          fprintf (log, "mopenuucp: %s\n", startG);

     /* receive "Shere" from remote */
     if (recv0 (p) == TIMEDOUT)
       {
          logerror ("mopenuucp: remote didn't send Shere");
          return (ABORT);
       }

     if (strncmp (p, "Shere", 5) != 0)
       {
          logerror ("mopenuucp: Bad Shere string from remote");

          if (debuglvl > 3)
               fprintf (log, "mopenuucp: remote sent: %s\n", p);

          return (ABORT);
       }

     if (debuglvl > 0)
          fputs ("mopenuucp: got Shere\n", log);

     lognorm ("Login successful");

     /* called the right remote, right? */
     if (*(p+5) == '=')
       {
          if (strncmp (p+6, sysname, strlen (sysname)) != 0)     /* oops!! */
            {
               char tmp[60];

               sprintf (tmp, "called wrong system (%s)", p+6);
               logerror (tmp);
               return (ABORT);
            }
       }
     else if (*(p+5) != '\0')
       {
          char tmp[65];

          sprintf (tmp, "mopenuucp: Strange Shere: %s", p);
          logerror (tmp);
       }

     /* tell 'em who we are */
     sprintf (p, "S%s", nodename);

     if (debuglvl > 0)
          fprintf (log, "mopenuucp: %s%s\n", whoweare, p);

     send0 (p);

     /* find out what remote thinks of us */
     if (recv0 (p) == TIMEDOUT)
          return (ABORT);

     if (*p != 'R')
       {
          char tmp[128];

          sprintf (tmp, "Bad response to handshake string (%s)", p);
          logerror (tmp);
          return (ABORT);
       }

      if (strncmp (p+1, "OK", 2) == 0)
        {
           if (debuglvl > 0)
                fputs ("mopenuucp: remote says we are OK\n", log);
        }
      else if (strcmp (p+1, "LCK") == 0)
       {
          logerror ("Remote says we are already talking");
          return (ABORT);
       }
     else if (strcmp (p+1, "CB") == 0)
       {
          logerror ("Remote will call back");
          return (ABORT);
       }
     else if (strcmp (p+1, "BADSEQ") == 0)
       {
          logerror ("bad sequence number");
          return (ABORT);
       }
     else
       {
          char tmp[65];

          sprintf (tmp, "Handshake failed (%s)", p+1);
          logerror (tmp);
       }

     /* receive list of supported protocols from remote */
     if (recv0 (p) == TIMEDOUT)
          return (ABORT);

     /* is "g" protocol supported? */
     if (*p != 'P')
       {
          logerror ("mopenuucp: Bad protocol handshake");
          return (ABORT);
       }

     if (strstr (p, "g") == NULL)
       {
          send0 ("UN");
          logerror (no_proto);
          return (ABORT);
       }

     /* tell 'em to use g protocol */
     protocol = 'g';
     sprintf (p, "U%c", protocol);
     send0 (p);
     sprintf (p, "%s (protocol '%c')", handshake_ok, protocol);
     lognorm (p);
     return (MS_SNDRCV);
}



/*********************************\
* open uucp session in slave mode *
\*********************************/

int sopenuucp()
{
     char string[200];
     register char *p;
     char *incoming = "Incoming call from ";

     p = string;

     if (debuglvl > 0)
          fprintf (log, "sopenuucp: %s\n", startG);

     /* send "Shere" to remote */
     sprintf (p, "Shere=%s", nodename);

     if (debuglvl > 0)
          fprintf (log, "sopenuucp: %s%s\n", whoweare, p);

     send0 (p);

     /* find out who they are */
     if (recv0 (p) == TIMEDOUT)
          return (ABORT);

     if (*p != 'S')
       {
          strcpy (sysname, "unknown");
          sprintf (p, "%s%s (port %s)", incoming, sysname, device);
          lognorm (p);
          logerror ("sopenuucp: Bad introduction string");
          return (ABORT);
       }

     if (debuglvl > 0)
          fputs ("sopenuucp: got remote's S<hostname>\n", log);

     /* isolate system name */
     if ((p = strchr (string, ' ')) != NULL)
          *p = '\0';

     p = string;
     strcpy (sysname, p+1);

     /* log the connection */
     sprintf (p, "%s%s on port %s",
                 incoming, sysname, *device != '\0' ? device : "unknown");
     lognorm (p);

     /* Are they allowed in here? */
     if (SystemIsOK (FALSE) == FALSE)
       {
          send0 ("RYou are unknown to me");
          sprintf (p, "WARNING--call from unknown system: %s", sysname);
          lognorm (p);
          return (ABORT);
       }

     /* For now we don't tell the remote we will call them back or reject
        the login otherwise.  Instead, we tell remote that all is fine. */
     send0 ("ROK");

     /* send list of supported protocols to remote */
     send0 ("Pg");

     /* is "g" protocol okay? */
     if (recv0 (p) == TIMEDOUT)
          return (ABORT);

     /* Ug if okay, UN if not */
     if (*p != 'U'  ||  *(p+2) != '\0')
       {
          logerror ("sopenuucp: Bad protocol response string");
          return (ABORT);
       }

     if (*(p+1) == 'N')
       {
          logerror ("sopenuucp: No supported protocol");
          return (ABORT);
       }
     protocol = *(p+1);
     sprintf (string, "%s (protocol '%c')", handshake_ok, protocol);
     lognorm (string);
     return (MS_SNDRCV);
}



/* Is this valid system?  The remote's name is in the global variable
   'sysname'.  TRUE is returned if we talk to the remote.  FALSE if not or on
    error. */

int SystemIsOK (quitonerror)
int quitonerror;
{
     char buff[SYSLINE];
     int sysnamlen = strlen (sysname);
     register char *p;
     char *p1;
     FILE *fpsys;

     p = buff;

     if ((fpsys = fopen (SYSTEMS, "r")) == NULL)
       {
          openlog();
          strcpy (p, "SystemIsOk: can't open Systems file");
          logerror (p);
          closelog();

          if (quitonerror)
               fatal (p);
          else
               return (FALSE);
       }

     /* ignore comment lines beginning with #, <space>, <tab> or CR */
     while (mfgets (p, SYSLINE, fpsys) != NULL)
          if (ISCOMMENT (*p) == FALSE)
            {
               /* isolate system name */
               if ((p1 = strchr (p, ' ')) != NULL)
                    *p1 = '\0';

               if (strucmp (sysname, p) == 0)
                 {
                    fclose (fpsys);
                    return (TRUE);
                 }
            }

     /* no entry for this system */
     fclose (fpsys);
     sprintf (p, "no entry in Systems file for: %s", sysname);
     openlog();
     logerror (p);

     if (!quiet  &&  log != stderr)
          fprintf (stderr, "%s\n\n", buff);

     return (FALSE);
}



/* Receive a NULL terminated string.  This is one used when no protocol is
   being used.  The basic idea for this is borrowed from Taylor (GNU) UUCP. */

int recv0 (string)
char *string;
{
     register char *p;
     char c;
     flag gotDLE = FALSE;

     if (debuglvl > 7)
          fputs ("<< ", log);

     /* Keep reading the port until we time out or get an ending null */
     p = string;
     while (readport (&c, PKTTIME, MAXTRY) != TIMEDOUT)
       {
          /* strip any parity bit */
          c &= 0x7f;

          /* Log the byte if the debug level is high enough.  Don't bother
             logging the terminating null since we know it must be there. */

          if (debuglvl > 7)
               if (gotDLE  &&  c == '\0')
                    ;
               else
                    chardump (c);

          /* Look for the DLE to indicate the start of a null-terminated
             message.   We ignored everything until we get the DLE. */
          if (!gotDLE)
            {
               if (c == DLE)
                    gotDLE = TRUE;

               continue;
            }

          /* We got the DLE, so start assembling the string until we get a
             NULL signaling the end. */

          /* Huh?  Another DLE?  Something happened here.  Act like it is the
             first one we saw. */
          if (c == DLE)
            {
               p = string;
               continue;
            }

          /* Some systems send trailing \n on Shere line.  This is a definite
             no-no and should not occur...but...  This mod should be safe. */            if (c == '\x0d'  ||  c == '\x0a')
               c = '\0';

          *p++ = c;

          if (c == '\0')
            {
               if (debuglvl > 7)
                    putc ('\n', log);

               return (TRUE);
            }
       }
     /* we must have timed out */
     return (TIMEDOUT);
}



/* Send a NULL terminated string.  This is only used when no protocol is
   being used. */

int send0 (string)
register char *string;
{
     int lport, result, sendlen = strlen (string) + 1;

     lport = port == 0  ? 1 : port;

     if (debuglvl > 7)
       {
          fputs (">> [$10]", log);
          strdump (string);
       }

     /* send DLE... */
     if ((result = write (lport, "\x10", 1)) != 1)
          if (debuglvl > 0)
               logerror ("send0: didn't write enough data, probably won't write the rest either.");

     /* ...and the rest of the string including its ending \0 */
     result = write (lport, string, sendlen);
     return (result == sendlen ? TRUE : FALSE);
}



/* dump out string for diagnostic output */

int strdump (string)
char *string;
{
     register char *c;

     for (c = string;  *c != '\0';  ++c)
          chardump (*c);

     putc ('\n', log);
}



/* Dump out a char for diagnostic output.  This is called by strdump() above
   and recv0(). */

int chardump (c)
register char c;
{
     if (isprint (c))
       {
          if (c == '\x0d')
               fputs ("<CR>", log);
          else if (c == '\x0a')
               fputs ("<LF>", log);
          else
               fprintf (log, "%c", c);
       }
     else
          fprintf (log, "[$%02x]", c & 0xff);
}
