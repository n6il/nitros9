/*      optpat.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

TOKEN *oldpat;

TOKEN *
 optpat()
{
  char delim, str[MAXPAT], *cp;

  delim = *inptr++;
  cp = str;
  while (*inptr != delim && *inptr != NL) {
        if (*inptr == ESCAPE && inptr[1] != NL) *cp++ = *inptr++;
        *cp++ = *inptr++;
  }

  *cp = EOS;
  if (*str == EOS) return(oldpat);
  if (oldpat) unmakepat(oldpat);
  oldpat = getpat(str);
  return(oldpat);
}

