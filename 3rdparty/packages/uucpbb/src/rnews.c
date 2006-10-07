/*  rnews.c  --This is the main program to process and distribute Usenet news.
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

/* main function */

#define MAIN
#include "uucp.h"
#include "rnews.h"
#include "mbuf.h"
#include "getopt.h"
#include <direct.h>

QQ int debuglvl = 0;
struct mbuf *getgroups();

int main(argc,argv)
int argc;
char *argv[];
{
     char lbuf[512], buf[BIGBUF], filename[100], initng[100];
     struct fildes fdes;
     FILE *batchfile;
     int savein, saveout, fd, pipefd;
     char *bigbuf;
     int e,p,option,zflag=0;
     struct mbuf *g,*gg;
     long length = -1;

     initng[0] = '\0';

#ifndef _OSK
     pflinit();
#endif

     /* On the CC3 there seems to be a bit of arcane lore that is needed to
        make setbuf() work without crashing on exit.  This malloc is part of
        what I discovered to work.  */

     if ((bigbuf = (char *) malloc (BUFSIZ+16)) == NULL)
       {
          fprintf (stderr, "Can't allocate file buffer\n");
          exit(207);
       }

     /* I suppose that this is true */
     if (getuid() != 0)
       {
          fprintf (stderr,"Must be root\n");
          exit (214);
       }

     while (((option = getopt (argc, argv, "x:n:mz?")) != NONOPT)
             || optarg != NULL)
       {
          switch (option)
            {
               /* Set the debug level */
               case 'x':
                    debuglvl = atoi (optarg);
                    break;

              /* Set a newsgroup that is forced, if this is just a single
                 article */
               case 'n':
                    strcpy (initng, optarg);
                    break;

               /* Force logging to standard output with no reguard to the
                  debugging level */
               case 'z':
                    zflag++;
                    break;

               /* Must be the file to process */
               case NONOPT:
                    strcpy (filename, optarg);
                    break;

               case '?':                                   /* Help */
               default:
                    usage();
                    break;
            }
       }

     if (getparam() == FALSE)
          exit (ABORT);

     if ((logdir = getenv ("LOGDIR")) != NULL)
          logdir = strdup (logdir);
     else
          logdir = LOGDIR;

     if ((newsdir = getdirs ("newsdir")) == NULL)
          fatal ("newsdir not in Parameters");

     /* Set up the log file.  The fprintf below is important, as it makes sure
        that standard error has been opened */

     if (zflag  ||  debuglvl > 4)
       {
          fprintf (stderr, "\nLogging to stderr\n");
          inizlog ("rnews", 3);
       }
     else
          inizlog ("rnews", 1);

     /* Get the groups from the active file */
     g = getgroups();

     if (debuglvl > 5)
          for (gg = g; gg != NULL; gg = gg->mbuf_next)
           {
               sprintf (lbuf, "ACTIVE IN: %s, %d, %d",
                              ((struct groups *)gg->cbuf)->name,
                              ((struct groups *)gg->cbuf)->min,
                              ((struct groups *)gg->cbuf)->max);
               log (lbuf);
           }

    /* Got to be able to open the file */
     if ((fd = open (filename, 1)) < 0)
       {
          sprintf (lbuf, "Can't open '%s'", filename);
          log (lbuf);
          exit (1);
       }

     if (debuglvl > 3)
       {
          sprintf (lbuf, "Opened '%s'", filename);
          log (lbuf);
       }

     /* Hopefully the first bit of the file will tell us what sort of
        thing it is */

     if ((e = read (fd, buf, BUFSIZ-1)) <= 0)
       {
          sprintf (lbuf, "Can't read from '%s'", filename);
          log (lbuf);
          exit (1);
       }

     /* Ok, it seems to be a compressed file, possibly batched */
     if (strncmp (buf, "#! cunbatch", 11) == 0)
       {
          if (debuglvl > 1)
               log ("A compressed news file");

          /* Ok, move to the proper place in the file to begin decompression
           */

          lseek (fd, 12l, 0);

          /* Save stdin, stdout and close the originals */
          savein = dup (0);
          saveout = dup (1);
          close (0);
          close (1);

          /* Try making the file's fd stdin, fail if we can't */
          if (dup (fd) != 0)
            {
              log ("Can't dup fd 0");
              exit (1);
            }

          /* The pipe better be stdout !!! */

          if ((pipefd = open ("/pipe", 3)) != 1)
            {
               log ("Can't open /pipe");
               exit (1);
            }

          /* Fork compress, complain otherwise */
          if ((p = os9fork ("compress", 3, "-d\n", 0, 0, 0)) < 0)
            {
               log ("Could not fork compress");
               exit (1);
            }

          /* Increase my priority, hopefully, above compress.

             The theory is that we will spend most of our time processing and
              writing the article file, rather then reading from the pipe.
              And when we read from the pipe, we aren't doing anything else
              anyway [i.e. possibly sleeping on I/O].  So, don't take up CPU
              time on compress, because it will be given the CPU when needed
              anyway.   This may all be nuts, however....

             I've noted that making the priority the same makes for terrible
             performance */

          setpr (getpid(), 200);
          setpr (p, 100);

          /* It is important to close the file, on our side, or the end of
              file on the pipe won't be detected. */

          close (0);

          /* Unredirect the file descriptors.  More arcane stuff, you really
             shouldn't have to do this */

          pipefd = dup (1);
          close (1);
          dup (savein);
          dup (saveout);

          /* Make a FILE pointer for the pipefd */
          if ((batchfile = fdopen (pipefd, "r+")) == NULL)
            {
               log ("Couldn't fdopen the pipe fd");
               exit (1);
            }
          setbuf (batchfile, bigbuf);

          /* Get the first line, which may indicate that this is a batch of
             articles */

          if (getline (batchfile, buf) == -1)
            {
               log ("Nothing on the pipe");
               exit (1);
            }
       }
     else
       {
          /* Must not be compressed.  This is also the place where one might
             process other compression schemes, like lha.  In general, one
             should check for each type of compression before assuming that
             the file is uncompressed */

          if (debuglvl > 1)
               log ("An uncompressed news file");

          /* Rewind the file and get the size, so we can pass it along, if
             needed */

          lseek (fd, 0l, 0);

          if (_gs_gfd (fd, &fdes, sizeof (fdes)) != -1)
               length = (long)fdes.fd_fsize;

          /* Make a FILE pointer out of the file fd, instead of the pipe, as
             above */

          if ((batchfile = fdopen (fd, "r")) == NULL)
            {
               log ("Can't fdopen news file");
               exit (1);
            }
          setbuf (batchfile, bigbuf);

          /* Get a line, which could mean that this is a batch of articles */
          getline (batchfile, buf);
       }

     /* Ok, we seem to have a batch of articles.  Process them, as such */

     if (strncmp (buf, "#! rnews ", 9) == 0)
       {
          if (debuglvl > 1)
               log ("A batch of news articles");

          procbatch (batchfile, buf, g);
       }
     else
       {
          /* Not a batch of articles, assume that it is a single article */
          if (debuglvl > 1)
               log ("A single news article");

          procart (batchfile, buf, initng, g, length);
       }

     /* Put the updated active file back */
     if (debuglvl > 3)
          log ("Updating active file");

     putgroups (g);

     /* Clean things up */
     if (debuglvl > 4)
          log ("Exiting.....");

     fclose (batchfile);
     close (pipefd);
     close (fd);
     wait (0);

     /* Close up the log */
     deinizlog();
     exit (0);
}



/* Cheap fatal */

int fatal (s)
char *s;
{
    fprintf (stderr, "'%s'\n");
    exit (ABORT);
}



/* Cheaper usage */

int usage()
{
     fprintf (stderr,
              "rnews [-x debug_level] [-n inital_newsgroup] [-z] newsfile\n");
     exit (1);
}
