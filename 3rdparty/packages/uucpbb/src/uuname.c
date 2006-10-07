/*  uuname.c   Return name of local machine or those of UUCP sites we talk to.
    Copyright (C) 1994 Bob Billson

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

char buf[256];
void showlocalname(), showsystems(), fatal(), usage();


int main (argc, argv)
int argc;
char *argv[];
{
     if (argc == 1)
          showsystems();
     else if (argv[1][0] == '-'  && argv[1][1] == 'l')
          showlocalname();
     else
          usage();
}



void showlocalname()
{
     FILE *fp;
     register char *p;
     char *nptr;

     p = buf;
     sprintf (p, "%s/Parameters", UUCPSYS);

     if ((fp = fopen (p, "r")) == NULL)
          fatal ("cannot open Parameters file");

     while (mfgets (p, sizeof (buf), fp) != NULL)
          if ( !ISCOMMENT (*p) )
               if (strnucmp (p, "nodename = ", 11) == 0)
                 {
                    nptr = strchr (p, '=');
                    puts ((nptr+2));
                 }
     fclose (fp);
}



void showsystems()
{
     char *words[3];
     FILE *fp;
     register char *p;
     int n;

     if ((fp = fopen (SYSTEMS, "r")) == NULL)
          fatal ("cannot open Systems file");

     p = buf;
     while (mfgets (p, sizeof (buf), fp) != NULL)
          if ( !ISCOMMENT (*p) )
               if ((n = getargs (words, buf, 3)) == 3)
                    puts (*words);
     fclose (fp);
}



void fatal (msg)
char *msg;
{
     fprintf (stderr, "uuname: %s...error %d\n", msg, errno);
     exit (0);
}



void usage()
{
     register char **help;
     static char *helptxt[] = {
            "uuname --show local machine name or those of UUCP sites we talk to",
            "Usage:  uuname [-l]\n",
            "           -l   show name of this machine\n",
            NULL
         };

     for (help = helptxt; *help != NULL; ++help)
          fprintf (stderr, "%s\n", *help);

     exit (0);
}
