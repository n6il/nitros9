/*  uucp.c   UNIX-to-UNIX copy program, send/request files to/from remote.
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

/*  uucp [-options] [system!]fromfile [system!]tofile  */

#define MAIN

#include "uucp.h"

extern QQ unsigned myuid;
extern char user[];
extern QQ char *nodename;

QQ FILE *log;


int main(argc, argv)
int argc;
char *argv[];
{
     char options[10], fromfile[100], tofile[100];
     register int i;
     char *p1, *p2;

     if ((argc < 2) ||  strcmp (argv[1], "-?") == 0)
          usage();

     log = stderr;

     if (getparam() == FALSE)
          exit (0);

     if ((spooldir = getdirs ("spooldir")) == NULL)
          fatal ("spooldir not in Parameters");

     /* get user name */
     getuser (user);

     /* parse all the arguments */
     strcpy (options, "-");
     *fromfile = *tofile = '\0';

     for (i = 1; i < argc; i++)
          if (argv[i][0] == '-')
               strcat (options, &argv[i][1]);
          else
            {  if (fromfile[0] == '\0')
                    strcpy (fromfile, argv[i]);
               else if (tofile[0] == '\0')
                    strcpy (tofile, argv[i]);
               else
                    fatal ("too many file names");
            }

     /* receive file from remote, or transmit file to remote? */
     p1 = strchr (fromfile, '!');
     p2 = strchr (tofile, '!');

     if ((p1 == NULL) && (p2 == NULL))
          fatal ("no remote system specified");
     else if ((p1 != NULL) && (p2 != NULL))
          fatal ("can't do 3rd party copies");
     else if (p1 == NULL)
       {
          /* uucp fromfile system!tofile */
          *p2++ = '\0';
          senduucp (tofile, options, fromfile, p2);
       }
     else
       {
          /* uucp system!fromfile tofile */
          *p1 = '\0';
          ++p1;
          recvuucp (fromfile, options, p1, tofile);
       }
     exit (0);
}



/* senduucp  --queue job to send file

          fromfile is local filename
          tofile is "system!remotefile" */

int senduucp (system, options, fromfile, tofile)
char *system, *options, *fromfile, *tofile;
{
     char line[100], cname[16], dname[16], tmp[256];
     FILE *qfile, *file;
     register int count;

     /* figure out filenames */
     getfnames (system, cname, dname);

     if ((file = fopen (fromfile, "r")) == NULL)
       {
          sprintf (tmp, "can't open '%s'...error #%d", fromfile, errno);
          fatal (tmp);
       }

     /* go to proper spool file */
     sprintf (line, "%s/%s", spooldir, system);
     asetuid (0);

     if (chdir (line) != 0)
       {
          sprintf (tmp, "can't change to spool directory for '%s'", system);
          fatal (tmp);
       }

     asetuid (myuid);

     /* create spooled data file */
     if (strchr (options, 'c') == NULL)
       {
          asetuid (0);

          if ((qfile = fopen (dname, "w")) == NULL)
            {
               sprintf (tmp, "can't create spooled data file '%s'", dname);
               fatal (tmp);
            }

          asetuid (myuid);

          /* copy file to spool directory */
          while ((count = fread (tmp, sizeof (char), sizeof (tmp), file)) != 0)
               fwrite (tmp, sizeof (char), count, qfile);

          fclose (qfile);
       }

     /* close data file */
     fclose (file);

     /* write control file */
     asetuid (0);

     if ((qfile = fopen (cname, "w")) == NULL)
          fatal("can't create control file");

     asetuid (myuid);

     /* S fromname toname user options dname perms user */
     if (strchr (options, 'c') == NULL)
          fprintf (qfile, "S %s %s %s %s %s 0666 %s\n",
                          fromfile, tofile, user, options, dname, user);
     else
          fprintf (qfile, "S %s %s %s %s D.0 0666 %s\n",
                          fromfile, tofile, user, options, user);
     fclose (qfile);

     /* be sure files belong to the proper owner */
     asetuid (0);
     chown (dname, myuid);
     chown (cname, myuid);
}



/* recvuucp  --queue job to receive file

           fromfile is "system!remotefile"
           tofile is local file   */

int recvuucp (system, options, fromfile, tofile)
char *system, *options, *fromfile, *tofile;
{
     char line[100], cname[16], dname[16];
     register FILE *qfile;

     /* figure out filenames */
     getfnames (system, cname, dname);

     /* go to proper spool file */
     asetuid (0);
     sprintf (line, "%s/%s", spooldir, system);

     if (chdir (line) != 0)
          fatal ("can't change to spool directory");

     /* write control file */
     if ((qfile = fopen (cname, "w")) == NULL)
          fatal ("can't create control file");

     asetuid (myuid);

     /* R fromname toname user options dname perms user */
     if (strchr (options, 'c') == NULL)
          fprintf (qfile, "R %s %s %s %s %s 0666 %s\n",
                          fromfile, tofile, user, options, dname, user);
     else
          fprintf(qfile, "R %s %s %s %s D.0 0666 %s\n",
                          fromfile, tofile, user, options, user);
     fclose(qfile);
}



int getfnames (system, controlfile, datafile)
char *system, *controlfile, *datafile;
{
     char seq[10], *genseq();

     /* generate sequence number -- Changed REB */
     strcpy (seq, genseq() );

     /* D.systemXXXXXXX filename (uucp spooled data file) */
     sprintf (datafile, "D.%.8s%s", nodename, seq);

     /* C.systmCXXXXXXX (spooled control file) */
     sprintf (controlfile, "C.%.8sC%s", system, seq);
}



int fatal (msg)
char *msg;
{
     asetuid (myuid);
     fprintf (stderr, "uucp: %s", msg);

     if (errno != 0)
          fprintf (stderr, "...error %d", errno);

     putc ('\n', stderr);
     exit (0);
}



int usage()
{
     fputs ("uucp:  unix to unix copy program\n\n", stderr);
     fputs ("       uucp [-options] [system!]fromfile [system!]tofile\n\n",
            stderr);
     fprintf (stderr, "v%s (%s) This is free software released under the GNU General Public\n",
                      version, VERDATE);
     fputs ("License.  Please send suggestions/bug reports to:  bob@kc2wz.bubble.org\n", stderr);
     exit (0);
}
