/*  setuser.c   Set the current user PID to that of user passed us.
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
#include <password.h>
#ifndef _OSK
#include <os9.h>
#endif

EXTERN QQ unsigned myuid;


int setuser (user)
char *user;
{
     register PWENT *pwentry;
     unsigned newuid;

     asetuid (0);
     pwentry = getpwnam (user);
     endpwent();

     if (pwentry == (PWENT *)ERROR)
          exit (_errmsg (errno, "setuser() can't open password file\n"));
     else if (pwentry != NULL)
          newuid = (unsigned) atoi (pwentry->uid);
     else
          newuid = myuid;                         /* no such user */

     asetuid (newuid);
}
