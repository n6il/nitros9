/*
 *      mfgets (modified fgets)
 *
 *      Same as fgets() only this version looks for either a linefeed
 *      or a carriage return as the end-of-line character.  It returns
 *      the line without the EOL character.
 *
 *      Returns a NULL if EOF was encountered.
 *
 * From Mark Griffith's OS-9 UUCP software.  Thanks to Mark for his general
 * okey-dokey to use it.  -- Bob Billson [REB]
 */

#include <stdio.h>

char *mfgets (s, n, iop)
char *s;
int n;
FILE *iop;
{
     register int c;
     char *cs;

     cs = s;

     while (--n > 0 && (c = getc (iop)) != EOF)
          if (c == 0x0d  ||  c == 0x0a)
            {
               *cs = '\0';
               break;
            }
          else
               *cs++ = c;

     return ((c == EOF && cs == s) ? NULL : s);
}
