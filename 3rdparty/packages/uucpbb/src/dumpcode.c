/*  dumpcode.c   This routine writes data sent/received by UUCICO to log file.
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

/* Only come here if global variable 'debuglvl' > 7 */

#include "uucp.h"
#include "uucico.h"


int dumpcode (msg, code)
char *msg;
struct pk *code;
{
     static char *ttlist[] = { "CONTROL", "ALTCHN", "LONGDATA", "SHORTDATA" };
     static char *xxxlist[] = {
                "ZERO", "CLOSE", "RJ", "SRJ", "RR", "INITC", "INITB", "INITA"
              };

     short tt, xxx, yyy;

     fprintf (log, "    %s ", msg);
     tt = (code->C & 0xC0) >> 6;
     xxx = (code->C & 0x38) >> 3;
     yyy = code->C & 7;
 
     if (tt == 0)
          /* control message */
          fprintf (log, "%s %d\n", xxxlist[xxx], yyy);
     else
          /* packet */
          fprintf (log, "%s seg=%d ackno=%d\n", ttlist[tt], xxx, yyy);
}
