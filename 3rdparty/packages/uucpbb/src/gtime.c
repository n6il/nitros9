/*  gtime.c    Returns pointer to string containing current date and time.
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

/* Returns a pointer to a string containing the time for the uulog file. */

#include <time.h>

static char timestring[21];


char *gtime()
{
     register struct sgtbuf *p;
     struct sgtbuf gtpack;
     static char *months[] = {"Jan","Feb","Mar","Apr","May","Jun",
                              "Jul","Aug","Sep","Oct","Nov","Dec"};

     p = &gtpack;
     getime (p);

     /* assemble string to read, for example: '(May 05-01:56:00)' */
     sprintf (timestring, "(%s %d-%02d:%02d:%02d)",
                          months[p->t_month - 1], p->t_day, p->t_hour,
                          p->t_minute, p->t_second);

     return (timestring);
}
