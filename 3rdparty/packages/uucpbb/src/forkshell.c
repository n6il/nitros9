/*  forkshell.c   This routine forks a shell for the user.
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

#ifndef TERMCAP
EXTERN QQ flag t2flag;
#endif


int forkshell()
{
     char cmd[80], *usershell;

     if ((usershell = getenv ("SHELL")) == NULL)
          usershell = "shell";

#ifndef _OSK
     /* Decide if CoCo user uses the stock MW Shell, Shell+ v2.1 or later or
        some other Shell. */

     if (strucmp (usershell, "shell+") == 0)
          sprintf (cmd, "shell chd %s;shell p=\"os9: \"", homedir);
     else
#endif
          sprintf (cmd, "%s chd %s;%s", usershell, homedir, usershell);

#ifndef TERMCAP
     if (!t2flag)
       {
          /* keyboard users get an 80 x 24 overlay window */
          write (1, "\x1b\x22\x01\x00\x00\x50\x18\d00\d01", 9);
          docmd_na (cmd);
          write (1,"\x1b\x23", 2);
          return;
       }
#endif
     /* Nothing fancy, just give 'em the shell prompt */
     puts ("\n");
     docmd_na (cmd);
}
