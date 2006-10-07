/*  chown.c  This program lets a user change ownership of a file or directory
    Copyright (C) 1992  Bob Billson

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

/* A user who is not the superuser allowed only to ownership of files and/or
   directories belonging to them TO that of another user.  They are NOT
   allowed to change ownership another user's files and/or directories TO
   their own.

    Usage:  chown <user_id | username>   <file [<file...>]>   */

#define MAIN

#include "uucp.h"
#include <ctype.h>
#include <direct.h>
#include <modes.h>
#include <password.h>

/* #define OK         0 */
#define OPENERROR  1
#define GFDERROR   2
#define SFDERROR   3
#define OWNERROR   4

QQ unsigned myuid; 
unsigned getuserid();


int main (argc, argv)
int argc;
char **argv;
{
     unsigned uid;
     register int i;
     int result;

     if (argc < 3)
          usage();

     myuid = getuid();

     /* get the user name or ID from the command line */

     if ((uid = getuserid (argv[1])) == ERROR)
          exit (_errmsg (0, "chown: '%s' is not a valid user name or ID\n",
                     argv[1]));

     /* process each file and/or directory on the command line */
     for (i = 2; i < argc; ++i)
       {
          result = setnewowner (argv[i], uid);

          switch (result)
            {
               case OPENERROR:
                    fprintf (stderr, "can't open %s...error %d\n",
                              argv[i], errno);
                    break;

               case OWNERROR:
                    fprintf (stderr, "can't change ownership...you don't own '%s'\n",
                             argv[i]);
                    break;

               case GFDERROR:
                    fprintf (stderr, "can't get file descriptor for %s...error %d\n",
                               argv[i], errno);
                    break;
                    
               case SFDERROR:
                    fprintf (stderr, "can't update file descriptor for %s...error %d\n",
                               argv[i], errno);
                    break;

               case OK:
                    break;

               default:
                    fprintf (stderr, "can't change ownership of %s...error %d\n",
                                errno);
                    break;
            }
       }
     exit (0);
}




unsigned getuserid (user)
char *user;
{  
     register PWENT *pwentry;
     unsigned newuid;

     /* were we given a numerical uid? */
     if (validnum (user))
          return (atoi (user));

     /* Nope, must be username, get ID from password file.  Become superuser
        so we can open password file. */

     asetuid (0);
     pwentry = getpwnam (user);

     if (pwentry == ERROR)
          fatal ("getuserid() cannot open password file");

     if (pwentry == NULL)
       {
          endpwent();
          asetuid (myuid);
          return (ERROR);
       }

     newuid = (unsigned) atoi (pwentry->uid);
     endpwent();
     asetuid (myuid);
     return (newuid);
}




/* Is 'string' numerical user ID or name? */

int validnum (string)
char *string;
{
     register char *ptr;
     int result = FALSE;                             /* assume a user name */

     ptr = string;

     if (isdigit (*ptr))
       {
          while (*ptr &&  isdigit (*ptr))
               ++ptr;

          /* is this a numerical ID or user name? */
          if (*ptr == '\0')
               result = TRUE;          /* numerical ID */
       }
     return (result);
}



/* Change the ownership of a file or directory.  Microware's chown() will not
   allow directory ownership to be changed.  Therefore, we do it ourselves.
   If the current user is *not* the superuser or the file/directories is not
   theirs, the user won't be allowed to change ownership. 
   Owners can change ownership TO another user, but not another user's
   files/directories TO their own.  */

int setnewowner (file_or_dir, newowner)
char *file_or_dir;
unsigned newowner;
{
     struct fildes buffer;
     register int path;

     if (((path = open (file_or_dir, S_IWRITE)) == ERROR)  &&
          ((path = open (file_or_dir, S_IFDIR | S_IWRITE)) == ERROR))
       {
          return (OPENERROR);
       }

     if (_gs_gfd (path, &buffer, sizeof (buffer)) == ERROR)
       {
          close (path);
          return (GFDERROR);
       }

     /* Does this file belong to me  or am I the superuser? */
     if ((myuid != 0)  &&  (buffer.fd_own != myuid))
       {
          close (path);
          return (OWNERROR);
       }

     /* set the new owner ID to another user */
     buffer.fd_own = newowner;

     /* become superuser so we can write the file descriptor */
     asetuid (0);

     /* update the file descriptor */
     if (_ss_pfd (path, &buffer) == ERROR)
       {
          close (path);
          asetuid (myuid);
          return (SFDERROR);
       }

     /* back to our ID */
     asetuid (myuid);
     close (path);
     return (OK);
}



int usage()
{
     register char **ptr;
     static char *use[] = {
             "chown: change ownership of a file or directory to another user",
             " ",
             "Usage:  chown <username | ID>  <file | dir> [<file | dir>...]",
             NULL
          };

     for (ptr = use; *ptr != NULL; ++ptr)
          fprintf (stderr, "%s\n", *ptr);

     fprintf (stderr, "\nv%s (%s) This is free software released under the GNU General Public\n",
                      version, VERDATE);
     fputs ("License.  Please send suggestions/bug reports to:  bob@kc2wz.bubble.org\n", stderr);
     exit (0);
}



int fatal (msg)
char *msg;
{
     fprintf (stderr, "chown: %s...error %d\n", msg, errno);
     exit (0);
}
