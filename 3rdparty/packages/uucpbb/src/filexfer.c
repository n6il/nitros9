/*  filexfer.c    Routines to send and receive files queued for the remote.
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

#define WORDSIZE  20

/* global file pointer for incoming/outgoing files, this file only  */
static QQ FILE *io_file;

static char data[MAX_SEND_PACKET+1], messg[100], *words[WORDSIZE];
static char Dfilename[256], tmp[50];
static long t_total, filesize;

long _gs_size();


/* msendfile --send file to remote (while in master mode) */

int msendfile (line)
char *line;
{
     register int stat;

     strcpy (temp, line);
     getargs (words, temp, WORDSIZE);
     strcpy (sender, *(words + 3));

     if (debuglvl > 2)
          fputs ("msendfile: Send file to remote as MASTER\n", log);
 
     if (strchr (*(words + 4), 'c') == NULL)
          strcpy (Dfilename, *(words + 5));             /* spool file */
     else
          strcpy (Dfilename, *(words + 1));             /* source file */

     /* open the file for send */
     if ((io_file = fopen (Dfilename, "r")) == NULL)
       {
          char tmp[75];

          sprintf (tmp, "msendfile: can't open '%s' to send...error #%d",
                        Dfilename, errno);
          logerror (tmp);
          return (FALSE);
       }
     wtmsg (line);                      /* tell remote we're sending a file */
     rdmsg (messg);                     /* what does the remote say? */

     if (strcmp (messg, "SY") != 0)            /* remote say no can do */
       {
          fclose (io_file);
          sprintf (tmp, "Request to send '%s' rejected", Dfilename);
          neg_reason (*(messg + 3));
          return (FALSE);
       }

     stat = filesend (Dfilename);            /* remote says OK to send file */

     /* delete spool file if successful */
     if (stat)
       {
          char tmp[65];

          sprintf (tmp, "Sent %-13s -> %ld / %ld secs",
                        Dfilename, filesize, t_total);
          lognorm (tmp);

          if (strnucmp (Dfilename, "D.", 2) == 0)
            {
               if (unlink (Dfilename) == ERROR)
                    return (FALSE);
            }

          /* don't delete in another directory */
          else if (*Dfilename == '/')
               if (strnucmp (Dfilename, spooldir, strlen (spooldir)) == 0)
                    if (unlink (Dfilename) == ERROR)
                         return (FALSE);

          return (TRUE);
       }
     return (stat);          /* if we failed, don't delete the control file */
}



/* mrecvfile  --receive file from remote while master */

int mrecvfile (line)
char *line;
{
     register int stat;

     strcpy (temp, line);
     getargs (words, temp, WORDSIZE);
     strcpy (sender, *(words + 3));

     if (debuglvl >= 3)
          fputs ("mrecvfile: Receive file from remote as MASTER\n", log);

     if ((strchr (*(words + 4), 'c') == NULL) && (words[2][0] == '/'))
          strcpy (Dfilename, *(words + 5));             /* spool file */
     else
          strcpy (Dfilename, *(words + 2));             /* destination file */

     /* open the file */
     if ((io_file =fopen (Dfilename, "w")) == NULL)
       {
          char tmp[65];

          sprintf (tmp, "Can't create '%s' to get file", Dfilename);
          lognorm (tmp);
          return (FALSE);
       }
     wtmsg (line);                            /* tell remote we want a file */
     rdmsg (messg);                           /* remote says... */

     if (strncmp (messg, "RY", 2) != 0)       /* no can do...*/
       {
          fclose (io_file);
          sprintf (tmp, "Request to get %s rejected", Dfilename);
          neg_reason (*(messg + 3));
          return (FALSE);
       }

     /* remote says OK */
     fprintf (log, "%s %s %s Received %s",
                   sender, sysname, gtime(), Dfilename);

     stat = filerecv();                        /* receive file from remote */

     if (stat)
          fprintf (log, " <- %ld / %ld secs\n", filesize, t_total);

     return (stat);
}



/* ssendfile  --send file to local (slave mode) */

int ssendfile (cline)
char *cline;
{
     register int stat;

     getargs (words, cline, WORDSIZE);
     strcpy (sender, *(words + 3));

     if (debuglvl > 2)
          fputs ("ssendfile: Receive file from remote as SLAVE\n", log);

     /* look for UNIX transfer address "~/receive/user/node" -- TK */
     if ((strchr (*(words + 4), 'c') != NULL)   &&   (words[2][0] == '~'))
          sprintf (Dfilename, "%s%s", pubdir, strrchr (*(words + 1), '/'));
     else 
       {
          /* spool file and destination files */
          if ((strchr (*(words + 4), 'c') == NULL) && (words[2][0] == '/'))
               strcpy (Dfilename, *(words + 5));
          else
               strcpy (Dfilename, *(words + 2));
       }

     fprintf (log, "%s %s %s Receiving %-13s",
                   sender, sysname, gtime(), Dfilename);

     if (debuglvl >= 5)
          putc ('\n', log);

     if ((io_file = fopen (Dfilename, "w")) == NULL)      /* open file */
       {
          fputs (" REFUSED - can't create file\n", log);
          wtmsg ("SN4");
          return (FALSE);
       }

     wtmsg ("SY");                    /* we'll gladly accept a file from ya */
     stat = filerecv();               /* receive file from remote */

     if (stat)
          fprintf (log, " <- %ld / %ld secs\n", filesize, t_total);

     return (stat);
}



/* srecvfile  --receive file from local (slave mode) */

int srecvfile (cline)
char *cline;
{
     register int stat;

     if (debuglvl > 3)
          fprintf (log, "srecvfile: cline=:%s:\n", cline);

     if (debuglvl > 2)
          fputs ("srecvfile: Send file to remote as SLAVE\n", log);

     /* which file should we send you? */
     getargs (words, cline, WORDSIZE);
     strcpy (sender, *(words + 3));

     if (strchr (*(words + 4), 'c') == NULL)
          strcpy (Dfilename, *(words + 5));            /* spool file */
     else
          strcpy (Dfilename, *(words + 1));            /* source file */

     fprintf (log, "%s %s %s Request to get '%s' ",
                   sender, sysname, gtime(), Dfilename);

     if (debuglvl >= 5)
          putc ('\n', log);

     /* if we can't open the file, deny the request */
     if ((io_file = fopen (Dfilename, "r")) == NULL)
       {
          fputs ("DENIED - can't open file\n", log);
          wtmsg ("RN2");
          return (FALSE);
       }

     wtmsg ("RY 0666");                 /* we'll gladly send you a file */
     stat = filesend (Dfilename);       /* send file to remote */

     if (stat)
          fprintf (log, " -> %ld / %ld secs\n", filesize, t_total);

     return (stat);
}



/* filerecv  --Receive file, which we've already opened.  The file pointer to
               to the opened file is in the global variable, io_file.  TRUE is
               returned on success, FALSE on failure. */

int filerecv()
{
     char thisseq;
     register int type;
     int length, done = FALSE;
     long t_start, t_end;

     /* receive the file */
     time (&t_start);
     while (!done)
       {
          type = getpacket (data, &length);
          thisseq = ((inpacket.C >> 3) & 0x7);

          switch (type)
            {
               case LDATA:
               case SDATA:
                    if (((rseq + 1) & 0x07) == thisseq)
                      {
                         rseq = thisseq;
                         wtcontrol (RR | rseq);

                         if (length != 0)
                              fwrite (data, length, 1, io_file);
                         else
                              done = TRUE;
                      }
                    else
                         wtcontrol (RR | rseq);
                    break;

               default:
                    wtcontrol (RR | rseq);
                    break;
            }
       }

     time (&t_end);
     fflush (io_file);
     fixperms (io_file);
     filesize = _gs_size (fileno (io_file));
     fclose (io_file);
     t_total = t_end - t_start;

     if (t_total == 0L)
          ++t_total;

     /* got execution (X.) file? */
     if (words[2][0] == 'X'  &&  words[2][1] == '.')
          uuxflag = TRUE;

     /* can we move the file where it belongs? */
     if ((words[2][0] == '/')  &&  (strchr (*(words + 4), 'c') != NULL))
       {
          FILE *fp;

          /* don't copy if it's already there */
          if ((fp = fopen (*(words + 2), "r")) != NULL)
               fclose (fp);
          else
               if (filemove (*(words + 5), *(words + 2)) == FALSE)
                 {
                    wtmsg ("CN5");
                    fputs (" COPY FAILED\n", log);
                    return (FALSE);
                 }
       }

     /* yup!  signal success */
     wtmsg ("CY");

     if (debuglvl > 2)
          fputs (" RECEIVE OK\n", log);

     return (TRUE);
}



/* filesend   --Send the already opened file.  The file pointer to the opened
                the opened file is in the global variable, io_file.  Read 'C'
                completion message from remote.  Return TRUE on success, FALSE
                on failure. */

int filesend (filename)
char *filename;
{
     register int count;
     long t_start, t_end;

     time (&t_start);

     /* initialize sliding window */
     swin_init();

     /* send file; swin_send updates sseq */
     while ((count = fread (data, 1, 64, io_file)) != 0)
          if (count == 64)
               swin_send (LDATA, data, count);
          else
               swin_send (SDATA, data, count);

     /* signal EOF */
     swin_send (SDATA, data, 0);

     /* make sure all packets are sent */
     swin_flush (TRUE);

     fflush (io_file);
     filesize = _gs_size (fileno (io_file));
     fclose (io_file);
     time (&t_end);
     t_total = t_end - t_start;

     if (t_total == 0L)
          ++t_total;

     /* is the remote happy? */
     rdmsg (messg);

     /* CY ? */
     if (strcmp (messg, "CY") == 0)                      /* Success */
       {
          if (debuglvl > 2)
               fputs (" SEND OK\n", log);

          return (TRUE);
       }
     else
       {
          sprintf (tmp, "SEND '%s' FAILED", filename);   /* Failed */
          neg_reason (*(messg + 3));
          return (FALSE);
       }
}



/* neg_reason    We got a CN, RN, SN, or XN.  Say why, below action taken
                 message is in global 'tmp'. */

int neg_reason (reason)
char reason;
{
     fprintf (log, "%s %s %s ", sender, sysname, gtime());

     /* Were we given a reason why it was rejected? */
     switch (reason)
       {
          case NULL:
               fprintf (log, "%s --no reason given", tmp);
               break;

          case '2':
               fprintf (log, "%s --remote access to file denied", tmp);
               break;

          case '4':
               fprintf (log, "%s --remote system cannot create file", tmp);
               break;

          case '5':
               fprintf (log,
                        "%s --remote system cannot copy file to requested destination",
                        tmp);
               break;

          default:
               fprintf (log, "%s --unknown reason = '%c'", tmp, reason);
       }
     putc ('\n', log);
}
