/* uuencode input >output

   Encode a file so it can be mailed to a remote system.

   modified so it does not put an absolute pathname in the encoded file's
   header.  Bob Billson <...uunet!kc2wz!bob>   92 Apr 14

   Added stdin support to emulate UNIX version.
   If only one parameter is specified, uuencode uses that parameter as the
   name and takes input from stdin. - Boisy G. Pitre  05/16/92  */

#include "uucp.h"

/* ENC is the basic 1 character encoding function to make a char printing */

#define ENC(c) (((c)&077) + ' ')


int main (argc, argv)
int argc;
char  *argv[];
{
     FILE *in;
     char filename[128];
     register char *p;

     in = stdin;

     if ((argc < 2 || argc > 3)  ||  strcmp (argv[1], "-?") == 0)
       {
          fprintf (stderr, "%s: Usage: uuencode name [infile]\n", argv[0]);
          fputs ("If infile is not given, file is read from standard input",
                 stderr);
          exit (0);
       }

     if (argc == 3)
          if ((in = fopen (argv[2], "r")) == NULL)
            {
               fprintf (stderr, "%s: Can't open %s\n", argv[0], argv[2]);
               exit (1);
            }

     strncpy (filename, argv[1], sizeof (filename));
     filename[sizeof (filename) - 1] = '\0';

     /* strip off any directory names */
     p = strrchr (filename, '/');

     if (p == NULL)
          p = filename;
     else
          ++p;

     printf ("begin 644 %s\n", p);
     encode (in, stdout);
     puts ("end");
     exit (0);
}



/* copy from in to out, encoding as you go along */

int encode (in, out)
FILE  *in;
FILE  *out;
{
     char  buf[80];
     register int i;
     int   n;

     for (;;)
       {
          /* 1 (up to) 45 character line */
          n = fr (in, buf, 45);
          putc (ENC(n), out);

          for (i = 0; i < n; i += 3)
               outdec (&buf[i], out);

          putc ('\n', out);

          if (n <= 0)
               break;
       }
}



/* output one group of 3 bytes, pointed at by p, on file f. */

int outdec (p, f)
register char *p;
FILE  *f;
{
     int   c1, c2, c3, c4;

     c1 = *p >> 2;
     c2 = (*p << 4)&060 | (*(p+1) >> 4)&017;
     c3 = (*(p+1) << 2)&074 | (*(p+2) >> 6)&03;
     c4 = *(p+2) & 077;

     putc (ENC(c1), f);
     putc (ENC(c2), f);
     putc (ENC(c3), f);
     putc (ENC(c4), f);
}



/* fr: like read but stdio */

int fr (fd, buf, cnt)
FILE  *fd;
char  *buf;
int   cnt;
{
     register int i;
     int c;

     for (i = 0; i < cnt; i++)
       {
          c = getc (fd);

          if (c == EOF)
               return (i);

          buf[i] = c;
       }

     return (cnt);
}
