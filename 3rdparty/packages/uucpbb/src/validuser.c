/*  validuser.c    Confirms if the user is in the password file.
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

/* If the user is in the password file, return TRUE, otherwise FALSE.
   donated by FILIP (thanks!). */

#include "uucp.h"
#include <password.h>

EXTERN QQ unsigned myuid;
EXTERN QQ char *errorsto;
QQ unsigned validuid;                     /* UID of validated username */


int validuser (user)
char *user;
{
     if (chkuser (user) == TRUE)
          return (TRUE);

     /* can't find the user, so use the 'errorsto' user instead */
     strcpy (user, errorsto);
     chkuser (user);
     return (FALSE);
}



int chkuser (user)
char *user;
{
     register PWENT *pwentry;
     flag result = FALSE;                     /* assume failure */

     asetuid (0);
     pwentry = getpwnam (user);
     endpwent();
     asetuid (myuid);

     if (pwentry == (PWENT *)ERROR)
          fatal ("validuser: can't open password file");

     if (pwentry != NULL)
       {
#ifdef _OSK
          validuid = (unsigned) uIDtoInt(pwentry->uid);
#else
          validuid = (unsigned) atoi (pwentry->uid);
#endif
          result = TRUE;
       }

     return ((int)result);
}
