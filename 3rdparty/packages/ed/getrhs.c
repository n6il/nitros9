/*      getrhs.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

int getrhs(sub)
char *sub;
{
  if (inptr[0] == NL || inptr[1] == NL) /* check for eol */
        return(ERR);

  if (maksub(sub, MAXPAT) == NULL) return(ERR);

  inptr++;                      /* skip over delimter */
  while (*inptr == SP || *inptr == HT) inptr++;
  if (*inptr == 'g') {
        inptr++;
        return(1);
  }
  return(0);
}

