/*      getnum.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

int mark['z' - 'a' + 1];

int getnum(first)
int first;
{
  TOKEN *srchpat;
  int num;
  char c;

  while (*inptr == SP || *inptr == HT) inptr++;

  if (*inptr >= '0' && *inptr <= '9') { /* line number */
        for (num = 0; *inptr >= '0' && *inptr <= '9';) {
                num = (num * 10) + *inptr - '0';
                inptr++;
        }
        return num;
  }
  switch (c = *inptr) {
      case '.':
        inptr++;
        return(curln);

      case '$':
        inptr++;
        return(lastln);

      case '/':
      case '?':
        srchpat = optpat();
        if (*inptr == c) inptr++;
        return(find(srchpat, c == '/' ? 1 : 0));

      case '-':
      case '+':
        return(first ? curln : 1);

      case '\'':
        inptr++;
        if (*inptr < 'a' || *inptr > 'z') return(EOF);

        return mark[*inptr++ - 'a'];

      default:
        return(first ? EOF : 1);/* unknown address */
  }
}

