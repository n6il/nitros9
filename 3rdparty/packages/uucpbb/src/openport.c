/*  openport.c   Open and close the port when making/receiving calls.
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
#include <modes.h>
#include <sgstat.h>
#ifndef _OSK
#include <os9.h>
#else
#include <module.h>
#endif

static struct sgbuf orig_opts;                     /* original port options */
static flag portopen = FALSE;

void flushport();


/* Open serial port.  If we are the master, use the port specified in the
   global variable 'device'.  If we are running as slave, we use the standard
   input.  In the latter case, we assume the standard input is the port
   a remote is logged in on. */

int openport()
{
     char buf[34];
#ifndef _OSK
     static short baudlist[] =
                {110,300,600,1200,2400,4800,9600,19200,0};
#else
     /* OSK baud rates */
     static short baudlist[] =
              {50,75,110,134,150,300,600,1200,1800,2000,2400,3600,4800,
               7200,9600,19200,38400};
#endif
     struct sgbuf newopts;
     register int i;

     /* open device */
     if (role == MASTER)
       {
          if ((port = open (device, PORTMODE)) <= 0)
               if (errno == NONSHARE)
                    return (PORTBUSY);
               else
                 {
                    portfatal (device);
                    return (ABORT);
                 }
       }
     else
       {
          _gs_devn (0, temp);
          buf[0] = '/';
          strhcpy (&buf[1], temp);

          if ((port = open (buf, 3)) <= 0)
               if (errno == NONSHARE)
                    return (PORTBUSY);
               else
                 {
                    portfatal (buf);
                    return (ABORT);
                 }
          strncpy (device, buf, sizeof (device) - 1);
       }
     portopen = offhook = TRUE;
     openlog();

     /* set device options.  Changed -- REB */
     _gs_opt (port, &orig_opts);

     newopts.sg_class  = orig_opts.sg_class;       /* device class      */
     newopts.sg_d2p    = orig_opts.sg_d2p;
     newopts.sg_err    = orig_opts.sg_err;
     newopts.sg_backsp =                           /* disable backspace */
     newopts.sg_delete =                           /* no delete seq     */
     newopts.sg_echo   =                           /* echo off          */
     newopts.sg_alf    =                           /* no auto LF        */
     newopts.sg_nulls  =                           /* no EOL null count */
     newopts.sg_pause  =                           /* no pause          */
     newopts.sg_page   =                           /* no lines/page     */
     newopts.sg_bspch  =                           /* no backspace      */
     newopts.sg_dlnch  =                           /* no del line       */
     newopts.sg_eorch  =                           /* no eor            */
     newopts.sg_eofch  =                           /* no eof            */
     newopts.sg_rlnch  =                           /* no reprint line   */
     newopts.sg_dulnch =                           /* no dup line       */
     newopts.sg_psch   =                           /* no pause          */
     newopts.sg_kbich  =                           /* no interrupt      */
     newopts.sg_kbach  =                           /* no abort          */
     newopts.sg_bsech  =                           /* no backspace echo */
     newopts.sg_bellch =                           /* no overflow char  */
     newopts.sg_xon    =                           /* no XON            */
     newopts.sg_xoff   = 0;                        /* no XOFF           */
     newopts.sg_baud   = orig_opts.sg_baud;        /* may be reset below */
     
     /* set baudrate */
     if (role == MASTER)
          for (i = 0; baudlist[i] != 0; i++)
               if (baudlist[i] == atoi (baud))
                 {
                    newopts.sg_baud = i;

                    if (debuglvl > 1)
                         fprintf (log, "opening port %s at %d bps\n",
                                       device, baudlist[i]);
                    break;
                 }

#ifndef RTSFLOW
     /* don't use hardware flow control (default) --REB */
     newsopts.sg_parity = orig_opts.parity;        /* use original setting */
#else
     /* if we are using Bruce Isted's SACIA and a modem using hardware 
        (RTS/CTS) flow control, set the port up for it --REB */

     newopts.sg_parity = 0x02;          /* hardware flow control (RTS/CTS) */
#endif

     /* update the port's path descriptor */
     _ss_opt (port, &newopts);
     flushport();
     return (role == MASTER ? MAKECALL : SOPEN);
}



/* Hang up and reset the modem, restore the port's original settings and close
   it.  Combined original hangup.c with this.   Added support to hanging up
   the phone by dropping the DTR line.  SACIA/DACIA will support this. --REB */

void closeport()
{
#ifndef _OSK
     struct registers regs;
#endif

     /* don't mess with the port if it is not opened --REB */
     if (!portopen)
          return;

     /* Hangup, restore the port and close */
     strcpy (sender, "uucp");

     if (debuglvl >= 1)
          fprintf (log, "%s %s %s DEBUG--closeport(): Closing port\n",
                             sender, sysname, gtime());

     /* Drop DTR to hang up? */
     if (dropDTR)
       {
#ifndef _OSK
          regs.rg_a = port;
          regs.rg_b = SS_HNGUP;
          _os9 (I_SETSTT, &regs);
#endif
       }
     else
       {
          /* Hang up using +++ATH */
#ifndef _OSK
          tsleep (MODEMDELAY);
#else
          sleep (1);
#endif
          write (port, "+++", 3);
#ifndef _OSK
          tsleep (MODEMDELAY);
#else
          sleep (1);
#endif
          write (port, "ATH\n", 4);
       }

     /* reset the modem */
     sleep (1);
     write (port, modemreset, strlen (modemreset));

     /* put the port back the way we found it */
     flushport();
     _ss_opt (port, &orig_opts);
     close (port);
     portopen = FALSE;
     *device = '\0';
}



/* flush the port to make sure SCF has nothing hanging around */

void flushport()
{
    register int rdy;

    if ((rdy = _gs_rdy (port)) > 0)
         read (port, temp, rdy);
}



int portfatal (device)
char *device;
{
     char buf[80];

     sprintf (buf, "openport: can't open path to: %s ...error %d",
                   device, errno);
     openlog();
     logerror (buf);
     closelog();

     if (!quiet)
          puts (buf);
}
