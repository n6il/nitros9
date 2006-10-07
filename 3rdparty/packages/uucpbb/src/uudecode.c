/*
   uudecode [input]

   create the specified file, decoding as you go.
   used with uuencode.

   Modified to allow split uuencoded files to be joined together.  Such files
   might come from an archive server such as ftp@cabrales.cs.wisc.edu.
         Bob Billson <bob@kc2wz.bubble.org>     16 Feb 1992
*/

#include "uucp.h"

#define DEC(c) (((c) - ' ')&077)         /* single character decode */

char *decode();
char buf[256];


int main (argc, argv)
int   argc;
char  *argv[];
{
     FILE  *in, *out;
     char  dest[128], path[128];
     register char *p;
     int first_one;

     if (argc > 2)
          usage();

     if (argc > 1)
       {
          if (strcmp (argv[1], "-?") == 0)
               usage();

          if ((in = fopen (argv[1], "r")) == NULL)
            {
               fprintf (stderr, "can't open %s\n\n", argv[1]);
               usage();
            }

          argv++;
          argc--;
       }
     else
          in = stdin;

     /* decode the file.  If it is split across more than one file, handle
        each one separately. */

     for (first_one = TRUE;;)
       {
          /* search for the header line */
          if ( !findbegin (in)  &&  !first_one)
            {
               fputs ("No begin line\n", stderr);
               exit (0);
            }

          /* create the output file the first time through */
          if (first_one)
            {
               p = strrchr (buf, ' ');
               strncpy (dest, &p[1], sizeof (dest));
               dest[sizeof (dest) - 1] = '\0';

               if ((out = fopen (dest, "w")) == NULL)
                 {
                    fprintf (stderr, "can't create %s for output\n", dest);
                    exit (errno);
                 }
            }
          p = decode (in, out);

          if (p != NULL)
            {
               /* close old input file */
               fclose (in);

               /* get the name of next part from 'include ...' line */
               p = strchr (p, ' ');
               strncpy (path, &p[1], sizeof (path));
               path[sizeof (path) - 1] = '\0';
               printf ("adding next file '%s'\n", path);
               first_one = FALSE;

               /* open the input, decode it to the current output stream */
               if ((in = fopen (path, "r")) == NULL)
                 {
                    fprintf (stderr, "can't open '%s' for input\n", path);
                    exit (errno);
                 }
            }
          else
            {
               if ((fgets (buf, sizeof (buf), in) == NULL)
                    || (strcmp (buf, "end\n") != 0))
                 {
                    fputs ("No end line\n", stderr);
                 }

               exit(0);
            }
       }
}



/* copy from in to out, decoding as you go along */

char *decode (in, out)
FILE  *in, *out;
{
     char  buff[80], *bp;
     register int n;

     /* for each input line */
     for (;;)
       {
          if (fgets (buff, sizeof (buff), in) == NULL)
            {
               fputs ("Short file\n", stderr);
               exit (0);
            }

          /* decode the data */
          n = DEC(buff[0]);

          /* everything is in this one file ? */
          if (n <= 0)
               break;

          /* was this file split in more than one piece? */
          if (strncmp (buff, "include ", 8) == 0)
            {
               /* get rid of the CR */
               if ((bp = strchr (buff, '\n')) != NULL)
                    *bp = '\0';

               return (buff);
            }

          bp = &buff[1];

          while (n > 0)
            {
               outdec (bp, out, n);
               bp += 4;
               n -= 3;
            }
       }

     /* everything is in this one file ? */
     return (NULL);
}



/* Output a group of 3 bytes (4 input characters).  The input chars are
   pointed to by p, they are to be output to file f.  n is used to tell us not
   to output all of them at the end of the file.  */

int outdec ( p, f, n)
register char  *p;
FILE  *f;
int   n;
{
     int   c1, c2, c3;

     c1 = DEC(*p) << 2 | DEC(p[1]) >> 4;
     c2 = DEC(p[1]) << 4 | DEC(p[2]) >> 2;
     c3 = DEC(p[2]) << 6 | DEC(p[3]);

     if (n >= 1)
          putc (c1, f);

     if (n >= 2)
          putc (c2, f);
 
     if (n >= 3)
          putc (c3, f);
}



/* search for the 'begin' header line */

int findbegin (in)
FILE *in;
{
     register char *p;

     p = buf;

     while (fgets (p, sizeof (buf), in) != NULL)
          if (strncmp (p, "begin ", 6) == 0) 
               return (TRUE);

     return (FALSE);
}



int usage()
{
     char **help;
     static char *helptxt[] = {
             "Usage: uudecode [infile]\n",
             "Restore a file created with uuencode.  Split files will be restored if the",
             "last line is in the form 'include XX', where XX is a sequencial name.",
             "uudecode will look for a file called <infile>.XX for its next input.\n",
             NULL
          };

     for (help = helptxt; *help != NULL; ++help)
          fprintf (stderr, "%s\n", *help);

     exit (2);
}
