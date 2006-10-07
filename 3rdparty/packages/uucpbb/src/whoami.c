/*  whoami.c    This program returns the login name of the user.
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

#include <stdio.h>
#include <password.h>

#ifndef ERROR
#define ERROR -1
#endif


int main()
{
     register PWENT *pwentry;
     unsigned myuid;

     myuid = getuid();
     asetuid (0);
     pwentry = getpwuid (myuid);
     asetuid (myuid);
     endpwent();

     if (pwentry == (PWENT *)NULL  ||  pwentry == (PWENT *)ERROR)
          puts ("Intruder alert");
     else
          printf ("you are: %s (UID %d)\n", pwentry->unam, myuid);
}
