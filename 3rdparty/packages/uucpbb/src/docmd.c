/*  docmd.c    Various routines to fork a process.
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

/* Added dochcmd() and docmd_error() to this file.  Error are logged to
   to the /DD/LOG/uulog file if possible. */

#include "uucp.h"

#ifndef _UCC
char *strtok();
#endif

QQ int childid;
static QQ char *cantspawn = "cannot spawn process--> ";

#ifdef _OSK
extern int chain();
#endif



/* docmd  --fork a command

            just like system(), but no 80 character limit.  Exits if forked
            process returns an error.   Does NOT return error to calling
            function. */

int docmd (command)
char *command;
{
#ifdef _OSK
     char *argv[32];   /* up to 32 arguments */
     char cmd [256];
     int status;

     strcpy (cmd, command);     
     parse_cmd (argv, cmd);
# ifdef _UCC
     childid = os9exec (os9fork, argv[0], argv, _environ, 0, 0, 3);
# else /* C 3.2 */
     childid = os9exec (os9fork, argv[0], argv, environ, 0, 0, 3);
# endif
#else
     char cmd[512]; 
     register char *p;
     int status;

     strcpy (cmd, command);
     p = parse_cmd (cmd);
     childid = os9fork (cmd, strlen (p), p, 1, 1, 1);
#endif

     if (childid == ERROR)
       {
          docmd_error ("docmd()", cantspawn, command);
          exit (errno);
       }

     /* ignore signals not for us */
     while (wait (&status) != childid)
          /* do nothing */;

     childid = -1;

     if (status != 0)
          exit (status);
}



/* docmd_na  --fork a command

               Just like system(), but no 80 character limit.  If the forked
               process returns an error, the error is returned to the calling
               function. */

int docmd_na (command)
char *command;
{
#ifdef _OSK
     char *argv[32];
     char cmd [256];
     int status;

     strcpy (cmd, command);
     parse_cmd (argv, cmd);
# ifdef _UCC
     childid = os9exec (os9fork, argv[0], argv, _environ, 0, 0, 3);
# else /* C 3.2 */
     childid = os9exec (os9fork, argv[0], argv, environ, 0, 0, 3);
# endif
#else
     char cmd[512];
     register char *p;
     int status;

     strcpy (cmd, command);
     p = parse_cmd (cmd);
     childid = os9fork (cmd, strlen (p), p, 1, 1, 1);
#endif

     if (childid == ERROR)
       {
          docmd_error ("docmd_na()", cantspawn, command);
          return (ERROR);
       }

     /* ignore signals not for us */
     while (wait (&status) != childid)
          /* do nothing */;

     childid = -1;
     return (status);
}



/* dochcmd   --do chained command. */

int dochcmd (command)
char *command;
{
#ifdef _OSK
     char cmd[256];
     register char *argv[32];

     strcpy (cmd, command);
     parse_cmd (argv, cmd);
#else
     char cmd[256];
     register char *p;

     strcpy (cmd, command);
     p = parse_cmd (cmd);
#endif

#ifdef _OSK
# ifdef _UCC
     if (os9exec (chain, argv[0], argv, _environ, 0, 0, 3) == ERROR)
# else /* C 3.2 */
     if (os9exec (chain, argv[0], argv, environ, 0, 0, 3) == ERROR)
# endif
#else
     if (chain (cmd, strlen (p), p, 1, 1, 1) == ERROR)
#endif
       {
          docmd_error ("dochcmd()", "cannot chain process--> ", command);
          exit (0);
       }
}



static int docmd_error (name, reason, command)
char *name, *reason, *command;
{
     char fname[100];
     register FILE *log;

     sprintf (fname, "%s/uulog", logdir);

     /* Try logging the error, don't fret if we can't */
     if ((log = fopen (fname, "a")) != NULL)
       {
          fprintf (log, "%s %s: %s%s (error %d)\n",
                        gtime(), name, reason, command, errno);
          fclose (log);
       }

     fprintf (stderr, "%s: %s%s (error %d)\n", name, reason, command, errno);
}
