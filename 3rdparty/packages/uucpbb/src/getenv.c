/*  getenv.c   This routine gives pseudo-environment variables for the CoCo.
    Copyright (C) 1993 Bob Billson

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

/* This is a combination of Brad Spencer's and Boisy Pitre's getenv.c.  Until
   Level 2 has real environmental variables, this will have to do.

   The system defaults are found in the file /dd/sys/profile.  The form is:
   <env_variable>=<data>.  For example:

   HOME=/dd/user
   MAIL=/h1/spool/mail
   TERM=coco3
   SHELL=shell

   There cannnot be any spaces between <env_variable> and '='.  Each line must
   be terminated with a carriage return.  A pointer to the string starting
   immediately to the right of the '=' is returned if the variable is defined.
   NULL is returned if the variable is undefined.  The default environment
   file must exist, though it can be empty or a NULL is returned.

   getenv() first searches /DD/SYS/profile for any matches.  It then tries to
   open the file 'profile' in the user's home directory as defined in the
   password file.  If the file exists and it contains an identical
   environment variable, this will be used instead of the system default.
   There are two exceptions to this: the environment variables MAIL and LOGDIR
   may only be defined in /DD/SYS/profile.  The user's personal profile file
   is not checked.

   All returned strings have the carriage return removed and are
   NULL-terminated.  The default system and user environment file names can be
   changed by changing two #defines below.

   The data pointed to by the returned pointer is only valid until getenv()
   is called again.  Therefore, it is a good idea to copy it to another string
   array before the next call to getenv().

     Bob Billson <bob@kc2wz.bubble.org>   1993 Oct 28 */

#ifndef _OSK

#include "uucp.h"
#include <password.h>

#define ENVFILE  "/dd/sys/profile"
#define USERENV  "profile"

static char buf[100];


char *getenv (var)
char *var;
{
     char buf2[80];
     FILE *f;
     unsigned ouid, setnuid();
     char *home,           
          *homeenv,
          *envfile = ENVFILE,
          *userenv = USERENV,
          *bptr2;
     PWENT *pwentry;
     register char *bptr;
     char *lookformatch();

     bptr = (char *)NULL;
     home = (char *)NULL;
     bptr2 = (char *)NULL;
     ouid = setnuid (0);

     /* get the default environment */
     if ((f = fopen (envfile, "r")) == NULL)
          return ((char*)NULL);

     bptr = lookformatch (f, var, buf, sizeof (buf));

     /* MAIL and LOGDIR may only be defined in /DD/SYS/profile */
     if ((strcmp (var, "MAIL") == 0)  ||  (strcmp (var, "LOGDIR") == 0))
       {
          setnuid (ouid);

          if (bptr != NULL)
               return (bptr);
          else
               return ((char*)NULL);
       }

     pwentry = getpwuid (ouid);
     setnuid (ouid);
     endpwent();

     if (pwentry == (PWENT *)ERROR  ||  pwentry == NULL)
          return (bptr);

     if (strcmp (var, "HOME") == 0)
          if (bptr != NULL)
            {
               strcat (strcat (bptr, "/"), pwentry->unam);
               return (bptr);
            }
          else
            {
               /* no system HOME defined?  Use the password file entry */
               strcpy (buf, pwentry->udat);
               return (buf);
            }

     /* see if the user has an environment file in their home directory */
     strcpy (buf2, pwentry->udat);
     home = buf2;
     homeenv = (char *) malloc (strlen (home) + strlen (userenv) + 5);
 
     if (homeenv == NULL)
          return (bptr);

     sprintf (homeenv, "%s/%s", home, userenv);

     if ((f = fopen (homeenv, "r")) == NULL)
       {
          free (homeenv);
          return (bptr);
       }

     free (homeenv);
     bptr2 = lookformatch (f, var, buf2, sizeof (buf2));

     /* if user environment exists it overwrites default */
     if (bptr2 != NULL)
       {
          strcpy (buf, bptr2);
          bptr = buf;
       }
     return (bptr);
}



char *lookformatch (fp, var, buff, bufsize)
FILE *fp;
char *var, *buff;
int bufsize;
{
     register char *bptr;
     int varlen = strlen (var);

     while (mfgets (buff, bufsize, fp) != 0)
          if (strncmp (buff, var, varlen) == 0)
               if ((bptr = strchr (buff, '=')) != NULL)
                 {
                    fclose (fp);
                    return (++bptr);
                 }
     fclose (fp);
     return ((char *)NULL);
}



/* set uid to id passed us.  Returns old uid. */

unsigned setnuid (newuid)
unsigned newuid;
{
     unsigned olduid;

     /* remember who we are */
     olduid = getuid();
     asetuid (newuid);
     return (olduid);
}
#endif
