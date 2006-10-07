/*  adduser.c   Program to allow new user accounts to be added to the system.
    Copyright (C) 1990, 1993  Mark Griffith and Bob Billson

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

/* Adds a new user to the system by updating the password file and
   creating required user files.  Requires my LOGIN and PASSWORD
   utilities to work correctly.

                       * * *  N O T I C E  * * *

                  This code assumes the use of Shell+
                  Requires the Kreider library to compile

  Mark Griffith
  DeLand, Fl.

  91 Jun        o Changes to Mark's code made by Bob Billson
                     <uunet!kc2wz!bob> are indicated by 'REB' 

  ?? ??? ??     o Further changes made by Charles Ownes
                     <trystro!czos9!chuck> to make it work more happily
                     with Rick Adams' UUCP are indicated by 'CNO'.

             HINT:  If you edit /dd/sys/password by hand, be sure you don't
                    add any extra carrige returns at the end of the file.
                    Each line should end with one carrige return.  There
                    should be no blank lines between entries.  If this 
                    format is not adhered to, ADDUSER will not work
                    properly.  -- CNO

  92 Oct 20     o Minor additions to allow compiling with the makefile in
                     Rick Adams' UUCP.
                o Improved the way chk_uid() picks its own user id.
                o get_entries() now detects and reports blank lines in the
                     password file.
                o User's login file script can now be customized. -- REB

  93 Feb 14     o User name can now be given on the command line -- REB

  93 Sep 4      o Special processing for user named 'daemon' --REB

  94 Mar 30     o Added -s option for super user, fixed for OSK -- BGP
*/

#define MAIN

/* To compile for UUCPbb, make the next line '#undef  MARK'
   To compile for Mark's original,  make the next line '#define MARK'  */

#undef  MARK

/* To send certain login messages to the Speech Sound Pak, make the next
   line '#define SSP'.  ***NOTE*** do this only if you ALWAYS have the SSP in
   place.

   If you do NOT wish to send messages to the SSP, make the next line
   '#undef SSP' -- CNO  */
#undef  SSP

#ifndef MARK
#include "uucp.h"                                     /* default to Rick's */
#else                                                 /* uucp -- REB       */
#include <stdio.h>
#include <string.h>
#endif
#include <modes.h>
#include <ctype.h>                                    /* Added -- REB */
#include <password.h>
#include <sgstat.h>

/* Defines for password file array */

#define   NAME      0         /* User name */
#define   PASS      1         /* User password */
#define   ID        2         /* User ID */
#define   PRI       3         /* User priority */
#define   DIRX      4         /* Execution directory */
#define   DIRW      5         /* Working directory */
#define   CMD       6         /* first command to run */
#define   PW_SIZE   7         /* Number of entries */
#define   ON        1
#define   OFF       0

/* made direct page -- REB */
QQ char *daemon = "daemon",
        *Sorry = "Sorry, only the Superuser can use this utility!",
        *NewID = "Enter new user ID number\n    ('Q' to quit) or press <ENTER> and I'll pick: ";

/*  Change the filenames below as needed ONLY if compiling for Mark's version.
    For UUCPbb: userdir, maildir and logdir are defined in uucp.h PASSWORD and
    PWEMAX are defined in password.h -- REB  */

#ifdef MARK
QQ char *userdir  = "/DD/USR",              /* default user directory */
        *logdir   = "/DD/LOG",              /* default user log file */
        *maildir  = "/DD/MAIL";             /* default mail directory */
#else
QQ char *userdir  = USERDIR;
#endif

/* these apply to both UUCPbb and Mark's version */
QQ char *passfile = PASSWORD,               /* default password file */
        *motd     = "/DD/SYS/motd";         /* location of motd file */

char   pw[PW_SIZE][30],
       tempstr[256], dirname[256],
       u_name[PWEMAX][20],
       mailname[256];                         /* added -- REB */
flag   isdaemon = FALSE;                      /*              */

unsigned u_uid[PWEMAX];
#ifdef _OSK
QQ int super = 256;
#else
QQ int super = 1;         /* added -- BGP for super user creation */
#endif
QQ int entries = 0;                        /* made direct page -- REB */
QQ FILE *fp;                               /*                         */
QQ PWENT *entry;                           /*                         */


int main (argc, argv)
int argc;
char *argv[];
{
     register int i;                                /* made register -- REB */
     int path, uloginpath;
     flag ipickit;                                  /* added --REB */
     unsigned userid;
     char *p;

     /* Get the user's userid */
     /* Must be the superuser to add a new user */

     if ( getuid() )
          exit (_errmsg (0, "%s\n", Sorry));

     /* need help? */
     if (argc > 3 || strcmp (argv[1], "-?") == 0)
          usage();

     *tempstr = '\0';

#ifndef MARK
     if ((maildir = getenv ("MAIL")) != NULL)
          maildir = strdup (maildir);
     else
          fatal ("MAIL is undefined");

     if ((logdir = getenv ("LOGDIR")) != NULL)
          logdir = strdup (logdir);
     else
          logdir = LOGDIR;
#endif
     /* allow creation of super users? */
     if (argc >= 2   &&  strcmp (argv[1], "-s") == 0)
       {
          if (argc == 3)
              strcpy (tempstr, argv[2]);
          argc = 1;          /* so that we don't get caught later on -- BGP */
          super = 0;
       }

     /* delete a local user? */
     if (argc >= 2  &&  strcmp (argv[1], "-r") == 0)
          if (argc == 3)
               removeuser (argv[2]);
          else
            {
               fputs ("adduser: -r requires a username\n\n", stderr);
               usage();
            }

     /* Set up some default password file entries -- edit as you require */
     strcpy (pw[PRI], "128");
     strcpy (pw[DIRX], "/dd/cmds");
     strcat (strcpy (pw[DIRW], userdir), "/");
     strcpy (pw[PASS], "000000");
     get_entries();                          /* read the password file */

     /* user name given on command line? --REB */
     if (argc >= 2)
          strcpy (tempstr, argv[1]);

     /* Get the new username.  If they enter a 'Q', end the program.
        Otherwise, check to see if the username is already used.  If it is,
        ask them for another one. */
     do
       {
          while (*tempstr == '\0')
            {
               printf ("\nEnter username (Q to quit): ");
               fflush (stdout);

               if (mfgets (tempstr, sizeof (tempstr), stdin) == NULL)
                 {
                    errno = 0;
                    fatal ("<ESC> hit...exiting");
                 }
            }

          if (*tempstr == 'Q'  ||  *tempstr == 'q')
               exit (0);
       }
     while ( chk_name() );                     /* name already in use? */

     if (strucmp (tempstr, daemon) == 0)       /* user 'daemon' is special */
          isdaemon = TRUE;

     strcat (pw[DIRW], tempstr);
     strcpy (pw[NAME], tempstr);

     /* user ID given on command line? --REB */
     if (argc == 3)
          strcpy (tempstr, argv[2]);
     else
          *tempstr = '\0';

     /* Get the new user ID number -- make my own if user enters nothing
        changed -- REB */
     putchar ('\n');
     do
       {
          if (*tempstr == '\0')
            {
               fputs (NewID, stdout);
               fflush (stdout);

               if (mfgets (tempstr, sizeof (tempstr), stdin) == NULL)
                 {
                    errno = 0;
                    fatal ("<ESC> hit...exiting");
                 }

               if (*tempstr == 'Q'  ||  *tempstr == 'q')
                    exit (0);
               else if (*tempstr == '\0')
                    ipickit = TRUE;
               else
                    ipickit = FALSE;
            }
          else
               ipickit = FALSE;

#ifndef _OSK
          userid = (unsigned) atoi (tempstr);
#else
          userid = (unsigned) uIDtoInt (tempstr);
#endif
       }
     while (chk_uid (&userid, ipickit));

#ifdef _OSK
     p = InttouID (userid);
     strcpy (pw[ID], p);
     free (p);
#else
     sprintf (pw[ID], "%u", userid);
#endif
     printf ("\nAdding new user '%s' as UID %s\n", pw[NAME], pw[ID]);

     /* Create user login file */
     sprintf (tempstr, "%s/%s.login", logdir, pw[NAME]);

     if ((path = create (tempstr, S_IREAD+S_IWRITE, S_IREAD+S_IWRITE)) == ERROR)
       {
         sprintf (tempstr, "%s.login already exists\n", pw[NAME]);
         fatal (tempstr);
       }

     close (path);

     /* Open and add user data to password file */
     if ((fp = fopen (passfile, "a")) == NULL)
          fatal ("can't open password file");

     for (i = 0; i < (PW_SIZE - 1); i++)
          fprintf (fp, "%s,", pw[i]);

     /* Create the commands the user will use after logging in.
        Changed --REB */
#ifndef _OSK
#  ifdef SHELLPLUS
     /* turn off Shell+ shell variable expansion so MAIL works properly make
        prompt user's name -- REB */

     fprintf (fp, "ulogin; ex shell -v p=\"%s\"\n", pw[NAME]);
#  else
     fprintf (fp, "ulogin;ex shell\n");
#  endif
#else
     fprintf (fp, "ulogin;ex shell\n");
#endif
     fclose (fp);

     /* Create user directory with owner bits only set. */
     strcpy (tempstr, pw[NAME]);
     sprintf (dirname, "%s/%s", userdir, strupr (tempstr));
     setuid (atoi (pw[ID]));                      /* set uid to new user */

     if ((mknod (dirname, S_IREAD+S_IWRITE+S_IEXEC)) == ERROR)
       {
          sprintf (tempstr, "can't create user's home directory...error %d\n",
                   errno);
          fatal (tempstr);
       }

#ifndef _OSK
     /* CoCo user needs a UUCP directory in their home directory for UUCPbb */
     sprintf (tempstr, "%s/UUCP", dirname);

     if ((mknod (tempstr, S_IREAD+S_IWRITE+S_IEXEC)) == ERROR)
       {
          sprintf (tempstr, "can't create user's home UUCP directory...error %d\n",
                            errno);
          fatal (tempstr);
       }
#endif

     /* Create user mail directory with owner bits only set.  Mail directory
        is compatible with UUCPbb --REB */

     /* user 'daemon' does not need a mail directory */
     if (!isdaemon)
       {
          strcpy (tempstr, pw[NAME]);
          sprintf (mailname, "%s/%s", maildir, strupr (tempstr));

          if ((mknod (mailname, S_IREAD+S_IWRITE+S_IEXEC)) == ERROR)
            {
               sprintf (tempstr,
                        "can't create user's mail directory '%s'...error %d\n",
                        mailname, errno);
               fatal (tempstr);
            }
       }

     /*  Setup users login file in their directory */
     sprintf (tempstr, "%s/%s/ulogin", userdir, pw[NAME]);

     /* changed -- REB */
     if ((uloginpath = create (tempstr, S_IWRITE, S_IREAD+S_IWRITE)) == ERROR)
       {
          sprintf (tempstr, "Can't create user's ulogin file '%s'...error %d\n",
                  tempstr, errno);
          fatal (tempstr);
       }

     /* now turn the path number in a file descriptor for writing -- REB */
     if ((fp = fdopen (uloginpath, "w")) == NULL)
          fatal ("can't create user's 'ulogin' file");

     asetuid (0);                              /* set uid back to SuperUser */

     /* create user's ulogin file...moved -- REB */
     make_ulogin (fp);

     /* make sure all I/O is flushed and chop off any junk at the end
        before we close the file -- REB */

     fflush (fp);
     _ss_size (uloginpath, ftell (fp));
     fclose (fp);

     printf ("\n\nUser '%s' has been added to the system\n\n", pw[NAME]);
     printf ("**NOTE** the password for user '%s' is NOT set right now.\n",
              pw[NAME]);
     puts ("         You must use the utility PASSWORD to set it.\n");
     free (maildir);
     free (logdir);
     exit (0);
}



/*  Read the password file getting all the usernames and UID there. */

int get_entries()
{
     register char *p;
     char tmpstr[PWSIZ];
     int line, badline;

     p = tmpstr;
     line = 0;
     badline = FALSE;

     if ((fp = fopen (passfile, "r")) == NULL)
       {
          sprintf (tempstr, "can't open password file...error %d\n", errno);
          fatal (tempstr);
       }

     while (fgets (p, sizeof (tmpstr), fp) != NULL)
       { 
          ++line;

          if (*p == '\n')
            {
               fputs ("adduser: illegal password entry...line", stderr);
               fprintf (stderr, "%d starts with a CR.\n", line);
               badline = TRUE;
            }
       }
     fclose (fp);

     if (badline)
       {
          fputs ("There cannot be blank lines anywhere in the ", stderr);
          fputs ("password file.  These lines must\nbe fixed ", stderr);
          fputs ("fixed before continuing.\n", stderr); 
          exit (0);
       }

     while((entry = getpwent()) != NULL)
       {
          if (entry == (PWENT *)ERROR)
               fatal ("error in the password file!");

          strcpy (u_name[entries], entry->unam);
#ifndef OSK
          u_uid[entries++] = (unsigned) atoi (entry->uid);
#else
          u_uid[entries++] = (unsigned) uIDtoInt (entry->uid);
#endif
       }
     endpwent();
}



/*  Check password file entries. If 'ipickit' is FALSE, see if there is a
    UID of the same number already used.  If 'ipickit' is TRUE, pick the 
    next highest available UID.  If all the UID (0-255) are picked, exit
    with an error.  Global variable 'tempstr' has the user ID to be checked
    on entry.  If the user ID is already used, we exit with 'tempstr' set
    to a NULL string. -- REB  */

int chk_uid (uid, ipickit)
int ipickit;
unsigned *uid;
{
     register int i;                            /* made register -- REB */
     unsigned j;                                /* added -- REB */

     /* UID was passed to us, is it taken? */
     if (!ipickit)
       {
          for (i = 0; i < entries; i++)
               if (*uid == u_uid[i])
                 {
                    fprintf (stderr, "\nUID '%d' is already used\n\n", *uid);
                    *tempstr = '\0';
                    return (TRUE);
                 }
          return (FALSE);
       }
     else
       {
         /* we have to pick the UID.  find the lowest unused one */
         for (j = super; j < 65536; ++j)
           {
               for (i = 0; i < entries; i++)
                    if (j == u_uid[i])
                         break;

               /* didn't find a match, this is our UID */
               if (i == entries)
                 {
                    *uid = j;
                    return (FALSE);
                 }
            }

          /* all 65535 user IDs are taken (wow!) */
          fatal ("all user IDs are used");
       }
}



/*  Check the password file entries and see if the username entered is
    already in the file.  global variable 'tempstr' has the username on
    entry.  */

int chk_name()
{
     register int i;                           /* made register -- REB */

     for (i = 0; i < entries; i++)
          if ((strucmp (tempstr, u_name[i])) == 0)
            {
               fprintf (stderr, "\nUsername '%s' already exists\n", tempstr);

               if (strucmp (tempstr, daemon) == 0)
                    exit (0);
               else
                    *tempstr = '\0';

               return (TRUE);
            }
     return (FALSE);
}



/* make the user's ulogin file...expanded -- REB */

int make_ulogin (fptr)
FILE *fptr;
{
     char script[256], answer, get_yn();
     int done = FALSE;

     /* user 'daemon' has a really short login script */
     if (isdaemon)
       {
          fputs ("echo daemon is logged in; echo", fptr);
          return (0);
       }

     while (!done)
       {
          /* start script */
          fprintf (fptr, "* Login file for %s *\n", pw[NAME]);


          cls();
          printf ("Do you wish to customize %s's login script?\n", pw[NAME]);
          fputs ("     (NO means use default script)       y/n --> ", stdout);
          fflush (stdout);
          answer = get_yn();

          /* customize our own ulogin script */
          if (answer == 'y')
            {
               cls();
               printf ("                           ");
               ReVOn();
               printf (" Customize ulogin script ");
               ReVOff();
               puts ("\nEnter commands one line at time.  Check for waiting mail has already been");
               puts ("included at the beginning of the script.\n");
               puts ("<ENTER> only for any line ends the customizing.  If you make a mistake, end");
               fputs ("customizing and answer 'N' (no) to 'Script okay?' prompt.  You may then start\nover.\n", stdout);
#ifdef SSP
               puts ("\nYou may send text to the Speech Sound Pak by redirecting it.  For example:");
               puts ("     echo hi there >/ssp");
#endif
               fputs ("\nHit <ENTER> to begin --> ", stdout);
               fflush (stdout);
               answer = getchar();
               cls();
               ReVOn();
               fputs (" ulogin script so far: ", stdout);
               ReVOff();
               puts ("\n");

               /* put in the standard stuff */
               fputs ("-x\n", fptr);
               puts ("-x");
               fprintf (fptr, "list %s\n", motd);
               printf ("list %s\n", motd);
               fputs ("echo\n", fptr);
               puts ("echo");
#ifndef SSP
               fprintf (fptr, "echo Hello %s\n", pw[NAME]);
               printf ("echo Hello %s\n", pw[NAME]);
#else
               /* Send 'hello <name>' to speech pak if SSP is set -- CNO */
               fprintf (fptr, "echo Hello %s >/ssp&\n", pw[NAME]);
               printf ("echo Hello %s >/ssp&\n", pw[NAME]);
#endif
               /* This line is specific to the mail utility packaged with the
                  OS9 uucp port.  Added code for Rick Adams' UUCP
                  enhancements -- REB */
#ifdef MARK
               fputs ("lmail -c\n", fptr);          /* Mark's original UUCP */
               puts ("lmail -c");
#else
               fputs ("mailx -c\n", fptr);          /* Rick Adams' UUCP */
               puts ("mailx -c");
#endif
               putchar ('\n');
               ReVOn();
               printf (" Continue script... ");
               ReVOff();
               puts("\n");

               for (;;)
                 {
                    fgets (script, sizeof (script), stdin);
 
                    if (*script == '\n')
                         break;
                    else
                         fputs (script, fptr);
                 }

               fputs ("\nScript okay?  (y/n) --> ", stdout);
               fflush (stdout);
               answer = get_yn();

               if (answer == 'y')
                    done = TRUE;
               else
                    rewind (fptr);               /* try again */
            }
          else
            {
               /* make the default login script */
               fputs ("-x\n", fptr);
               fprintf (fptr, "list %s\n", motd);
               fputs("x\n", fptr);
               fputs ("echo\n", fptr);
#ifndef SSP
               fprintf (fptr, "echo Hello %s\n", pw[NAME]);
#else
               /* Send 'hello <name>' to speech pak if SSP is set -- CNO */
               fprintf (fptr, "echo Hello %s >/ssp&\n", pw[NAME]);
#endif
               /* This line is specific to the mail utility packaged with the
                  OS9 uucp port.  Added code for Rick Adams' UUCP enhancement
                  -- REB */
#ifdef MARK
               fputs ("lmail -c\n", fptr);        /* Mark's original mailer */
#else
               fputs ("mailx -c\n", fptr);        /* UUCPbb */
#endif
               fputs ("echo\n", fptr);
               fputs ("echo Please use the 'bye' command to log off\n\n",
                      fptr);
               done = TRUE;
            }
       }
     fputs ("* End of Script *\n", fptr);
     return (0);
}



/* get a single character response from the user.  Added --REB */

char get_yn()
{
     char answer;

     echo (OFF);

     for (;;)
       {
          while (_gs_rdy (0) <= 0)
               tsleep (4);

          read (0, &answer, 1);
          answer &= 0xff;
          answer = tolower (answer);

          if (answer == 'y' ||  answer == 'n')
            {
               putchar (answer);
               break;
            }
       }

     echo (ON);
     return (answer);
}



/* Turn off or on echo on the standard input path --REB */

int echo (onoroff)
int onoroff;
{
     struct sgbuf stdinpath;

     _gs_opt (1, &stdinpath);
     stdinpath.sg_echo = onoroff;             /* switch standard input echo */
     _ss_opt (1, &stdinpath);                 /* update the path descriptor */
}



/* Convert a string to upper case.  Returns a pointer to the start of the
   string.  --REB  */

char *strupr (string)
char *string;
{
     register char *p;

     p = string;
     while (*p)
       {
          *p = toupper (*p);
          ++p;
       }
     return (string);
}



int usage()
{
     char temp[80], *strdetab();
     register char **use;
     static char *usetext[] = {
            "ADDUSER: add a user to or remove a user from the system",
            "Usage: adduser [opts] [<username> [<userid>] ]",
            " ",
            "opts: -r <username>  - remove <username> from the system",
            "      -s  - allow the creation of super users",
            "\t-?\t\t - this message",
            " ",
            "\tacceptable command lines are:",
            "\t   adduser",
            "\t   adduser <username>",
            "\t   adduser <username> <userid>",
            "\t   adduser -r <username>",
            "\t   adduser -s <username>",
            NULL
         };

     for (use = usetext; *use != NULL; ++use)
          fprintf (stderr, " %s\n", strdetab (strcpy (temp, *use), 6));

     fprintf (stderr, "\nv%s (%s) This is free software released under the GNU General Public\n",
                      version, VERDATE);
     fputs ("License.  Please send suggestions/bug reports to:  bob@kc2wz.bubble.org\n", stderr);
     exit (0);
}



int fatal (msg)
char *msg;
{
     fprintf (stderr, "adduser: %s", msg);

     if (errno != 0)
         fprintf (stderr, "...error %d", errno);

     putc ('\n', stderr);
     exit (0);
}



int removeuser (username)
char *username;
{
     userbegone (username);
     fatal ("removing user is not implemented yet");
}



int userbegone (name)
{
}
