/*  rnew.h -- header file for rnews program.
    Copyright (C) 1994 Brad Spencer

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

#ifndef _RNEWS_H
#define _RNEWS_H

struct groups
{
     char *name;
     int  min, max;
     FILE *artfd;
};


/* This is somewhat ugly.  I've seen articles that had lines over 256
   characters, but I don't think that it is very likely that a line will
   ever be over 1024 characters.  Something better should be thought up */

#define BIGBUF 2048

#endif
