/*      getlst.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

int getlst()
{
  int num;

  line2 = 0;
  for (nlines = 0; (num = getone()) >= 0;) {
        line1 = line2;
        line2 = num;
        nlines++;
        if (*inptr != ',' && *inptr != ';') break;
        if (*inptr == ';') curln = num;
        inptr++;
  }
  nlines = min(nlines, 2);
  if (nlines == 0) line2 = curln;
  if (nlines <= 1) line1 = line2;

  if (num == ERR)
        return(num);
  else
        return(nlines);
}

