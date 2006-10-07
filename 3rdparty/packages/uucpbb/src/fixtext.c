/*  fixtext.c    Fixs text file so it has OS9 tabbing and line terminators.
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

/* Usage: fixtext [- | infile] [outfile]",

   Examples:

    fixtext                  -read standard in, output sent to standard out
    fixtext - outfile        -read standard in, output sent to outfile
    fixtext infile           -read infile, output sent to standard out
    fixtext infile outfile   -read infile, output sent to outfile
*/

#define MAIN

#include "uucp.h"


int main(argc, argv)
int argc;
char *argv[];
{
     FILE *infile, *outfile;
     char line[512], *p;

     switch (argc)
       {
          /* fixtext <infile >outfile */
          case 1:
               infile = stdin;
               outfile = stdout;
               break;

          /* fixtext infile >outfile  or  fixtext -?  (help) */
          case 2:
               if (argv[1][0] == '-'  &&  argv[1][1] == '?')
                    usage();
               else
                 {
                    if ((infile = fopen (argv[1], "r")) == NULL)
                         fatal ("cannot open input file:", argv[1]);
                    outfile = stdout;
                 }
               break;

          /* fixtext - outfile   or   fixtext infile outfile */
          case 3:
               /* get input from standard input */
               if (argv[1][0] == '-'  &&  argv[1][1] == '\0')
                    infile = stdin;
               else
                    /* Get input from file */
                    if ((infile = fopen (argv[1], "r")) == NULL)
                         fatal ("cannot open input file:", argv[1]);

               if ((outfile = fopen (argv[2], "w")) == NULL)
                    fatal ("cannot create output file:", argv[2]);
               break;

          default:
               usage();
       }

     p = line;
     while (mfgets (p, sizeof (line), infile) != NULL)
       {
          fixline (line);
          fprintf (outfile, "%s\n", line);
       }

     if (infile != stdin)
          fclose (infile);

     if (outfile != stdout)
          fclose (outfile);
}



int fatal (reason, arg)
char *reason, *arg;
{
     fprintf (stderr, "fixtext: %s %s ...error %d\n", reason, arg, errno);
     exit (0);
}



int usage()
{
     register char **use;
     static char *usetxt[] = {
         "\nfixtext: A text file filter.  Removes escape sequences, expand tabs and change",
         "         end-of-line terminators to OS-9 ones.",
         " ",
         "Usage:  fixtext [infile] [outfile]",
         "          if infile is a '-', the standard input is read",
         " ",
         "Examples:",
         " ",
         "fixtext                  -read standard in, write to standard out",
         "fixtext - outfile        -read standard in, write to outfile",
         "fixtext infile           -read infile, write to standard out",
         "fixtext infile outfile   -read infile, write to outfile",
         NULL
       }; 

     for (use = usetxt; *use != NULL; ++use)
          fprintf (stderr, "%s\n", *use);

     fprintf (stderr, "\nv%s (%s) This is free software released under the GNU General Public\n",
                      version, VERDATE);
     fputs ("License.  Please send suggestions/bug reports to:  bob@kc2wz.bubble.org\n", stderr);
     exit (0);
}
